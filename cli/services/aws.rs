use std::{
    collections::{HashMap, HashSet},
    convert::TryInto,
    io,
    path::{Path, PathBuf},
    str::FromStr,
};

use async_recursion::async_recursion;
use rusoto_core::{region::Region, RusotoError};
use rusoto_s3::{
    DeleteObjectError, DeleteObjectRequest, HeadBucketError, HeadBucketRequest, ListObjectsV2Error,
    ListObjectsV2Request, Object, PutObjectRequest, S3Client, S3 as S3Trait,
};
use thiserror::Error;
use tokio::fs;

use crate::{Config, Done, FileData, FileFormat, Loc, Output};

pub struct S3 {
    client: S3Client,
    bucket: String,
}

impl S3 {
    pub fn new(config: &Config) -> Self {
        std::env::set_var("AWS_ACCESS_KEY_ID", config.AWS_ACCESS_KEY_ID());
        std::env::set_var("AWS_SECRET_ACCESS_KEY", config.AWS_SECRET_ACCESS_KEY());

        let region = Region::from_str(config.AWS_REGION()).expect("Unexpected AWS region");
        Self {
            client: S3Client::new(region),
            bucket: config.AWS_S3_BUCKET().to_owned(),
        }
    }

    pub async fn sync(&self) -> Output {
        let mut keys: HashSet<String> = HashSet::new();
        let local_files = Self::read_local_files().await?;
        let bucket_objects = self.get_bucket_objects().await?;

        for key in local_files.keys() {
            keys.insert(key.to_owned());
        }

        for key in bucket_objects.keys() {
            keys.insert(key.to_owned());
        }

        let mut progress_bar = ProgressBar::new("Syncing S3 bucket", keys.len());

        progress_bar.start();

        for key in keys {
            let local_file = local_files.get(&key);
            let bucket_object = bucket_objects.get(&key);
            match (local_file, bucket_object) {
                (Some(file), None) => {
                    progress_bar.println(format!(
                        "{action} {file}",
                        action = console::style("Uploading").green().bold(),
                        file = file.key
                    ));
                    let data = FileData::try_read(file.path.to_owned()).await?;
                    self.upload_file_to_bucket(file, data).await?;
                    progress_bar.update(1);
                }
                (Some(file), Some(object)) => {
                    let data = FileData::try_read(file.path.to_owned()).await?;
                    let etag = object
                        .e_tag
                        .as_ref()
                        .map(|x| x.replace("'", "").replace("\"", ""));
                    match etag {
                        Some(object_hash) if data.hash() == object_hash => {
                            progress_bar.println(format!(
                                "{action} {file}",
                                action = console::style("Skipping").dim().bold(),
                                file = file.key
                            ));
                            progress_bar.update(1);
                        }
                        Some(_) => {
                            progress_bar.println(format!(
                                "{action} {file}",
                                action = console::style("Uploading").green().bold(),
                                file = file.key
                            ));
                            self.upload_file_to_bucket(file, data).await?;
                            progress_bar.update(1);
                        }
                        None => {
                            progress_bar.println(format!(
                                "{action} {file}",
                                action = console::style("Uploading").green().bold(),
                                file = file.key
                            ));
                            self.upload_file_to_bucket(file, data).await?;
                            progress_bar.update(1);
                            progress_bar.println(format!("{}: done.", file.key));
                        }
                    }
                }
                (None, Some(_)) => {
                    progress_bar.println(format!(
                        "{action} {file}",
                        action = console::style("Deleting").yellow().bold(),
                        file = key
                    ));
                    self.delete_file_from_bucket(&key).await?;
                    progress_bar.update(1);
                }
                (None, None) => panic!(
                    "Impossible case: no local image nor bucket object for provided key `{}`",
                    key
                ),
            }
        }

        progress_bar.finish();

        Ok(Done::Bye)
    }

    pub async fn list(&self, detailed: bool) -> Output {
        let objects = self.get_bucket_objects().await?;
        let output = if detailed {
            format!("{:#?}", objects)
        } else {
            let total = objects.len();
            let mut objects =
                objects
                    .into_iter()
                    .fold(Vec::with_capacity(total), |mut acc, (key, _)| {
                        acc.push(key);
                        acc
                    });
            objects.sort();
            objects.join("\n")
        };
        Ok(Done::Output(output))
    }

    pub async fn reset_bucket(&self) -> Output {
        if self.bucket_exists().await? {
            let objects = self.get_bucket_objects().await?;
            for (key, _) in objects {
                self.delete_file_from_bucket(&key).await?;
            }
        }
        self.sync().await?;
        Ok(Done::Bye)
    }

    pub async fn empty_bucket(&self) -> Output {
        if self.bucket_exists().await? {
            let objects = self.get_bucket_objects().await?;
            for (key, _) in objects {
                self.delete_file_from_bucket(&key).await?;
            }
        }
        Ok(Done::Bye)
    }

    async fn bucket_exists(&self) -> Result<bool, RusotoError<HeadBucketError>> {
        match self
            .client
            .head_bucket(HeadBucketRequest {
                bucket: self.bucket.to_owned(),
                expected_bucket_owner: None,
            })
            .await
        {
            Ok(()) => Ok(true),
            Err(RusotoError::Service(HeadBucketError::NoSuchBucket(_))) => Ok(false),
            Err(err) => Err(err),
        }
    }

    async fn get_bucket_objects(
        &self,
    ) -> Result<HashMap<String, Object>, RusotoError<ListObjectsV2Error>> {
        Ok(self
            .client
            .list_objects_v2(ListObjectsV2Request {
                bucket: self.bucket.to_owned(),
                ..Default::default()
            })
            .await?
            .contents
            .map(|objects| {
                let len = objects.len();
                objects.into_iter().fold(
                    HashMap::with_capacity(len),
                    |mut acc, object| match object.key.to_owned() {
                        Some(key) => {
                            acc.insert(key, object);
                            acc
                        }
                        None => {
                            eprintln!("Bucket contains an object without a key: {:#?}", object);
                            acc
                        }
                    },
                )
            })
            .unwrap_or_else(|| HashMap::with_capacity(0)))
    }

    async fn read_local_files() -> Result<HashMap<String, File>, ReadLocalFilesError> {
        let mut files = HashMap::new();
        Self::read_dir(Loc::images().path(), &mut files).await?;
        Ok(files)
    }

    #[async_recursion]
    async fn read_dir<D: AsRef<Path> + Send>(
        dir: D,
        files: &mut HashMap<String, File>,
    ) -> Result<(), ReadLocalFilesError> {
        let mut dir = fs::read_dir(dir).await?;

        while let Some(entry) = dir.next_entry().await? {
            let path = entry.path();
            if path.is_dir() {
                Self::read_dir(path, files).await?;
            } else {
                match File::try_new(path) {
                    Ok(file) => {
                        files.insert(file.key.to_owned(), file);
                    }
                    Err(err) => return Err(err),
                }
            }
        }

        Ok(())
    }

    async fn upload_file_to_bucket(&self, file: &File, data: FileData) -> anyhow::Result<()> {
        let _ = self
            .client
            .put_object(PutObjectRequest {
                bucket: self.bucket.to_owned(),
                key: file.key.to_owned(),
                content_md5: Some(base64::encode(data.hash.bytes())),
                body: Some(data.bytes.into()),
                content_encoding: None,
                content_type: Some(file.format.content_type().to_string()),
                content_length: Some(data.length as i64),
                content_disposition: Some("inline".to_string()),
                content_language: None,
                acl: Some("bucket-owner-full-control".to_string()),
                cache_control: Some("max-age=31536000".to_string()),
                ..Default::default()
            })
            .await?;
        Ok(())
    }

    async fn delete_file_from_bucket(
        &self,
        key: &str,
    ) -> Result<(), RusotoError<DeleteObjectError>> {
        let _ = self
            .client
            .delete_object(DeleteObjectRequest {
                bucket: self.bucket.to_owned(),
                key: key.to_string(),
                ..Default::default()
            })
            .await?;
        Ok(())
    }
}

#[derive(Debug)]
pub struct File {
    key: String,
    path: Loc,
    format: FileFormat,
}

impl File {
    pub fn try_new(path: PathBuf) -> Result<Self, ReadLocalFilesError> {
        let rel = path.strip_prefix(Loc::images()).unwrap();
        let key = rel.to_str().unwrap().to_string();
        match path.extension() {
            None => Err(ReadLocalFilesError::UnexpectedFileType(key)),
            Some(ext) => match ext.try_into() {
                Ok(format) => Ok(Self {
                    key,
                    path: Loc::image_file(rel),
                    format,
                }),
                Err(()) => Err(ReadLocalFilesError::UnexpectedFileType(key)),
            },
        }
    }
}

#[derive(Error, Debug)]
pub enum ReadLocalFilesError {
    #[error("Failed to read directory")]
    ReadError(io::Error),
    #[error("Unexpected file type: {0}")]
    UnexpectedFileType(String),
}

impl From<io::Error> for ReadLocalFilesError {
    fn from(err: io::Error) -> Self {
        Self::ReadError(err)
    }
}

#[derive(Error, Debug)]
pub enum SyncError {
    #[error("Failed to get S3 bucket contents: {0}")]
    GetBucketContentsError(RusotoError<ListObjectsV2Error>),
}

impl From<RusotoError<ListObjectsV2Error>> for SyncError {
    fn from(err: RusotoError<ListObjectsV2Error>) -> Self {
        Self::GetBucketContentsError(err)
    }
}

struct ProgressBar {
    task: &'static str,
    bar: indicatif::ProgressBar,
    completed: usize,
}

impl ProgressBar {
    pub fn new(task: &'static str, len: usize) -> Self {
        Self {
            task,
            bar: indicatif::ProgressBar::new(len as u64),
            completed: 0,
        }
    }

    pub fn start(&self) {
        self.bar.set_style(
            indicatif::ProgressStyle::default_bar()
                .template(&format!(
                    "{task} {bar}",
                    task = self.task,
                    bar = "{spinner:.green} [{bar:40.cyan/blue}] {pos}/{len}"
                ))
                .progress_chars("=> "),
        );
        self.bar.enable_steady_tick(120);
    }

    pub fn update(&mut self, progress: usize) {
        self.completed += progress;
        self.bar.set_position(self.completed as u64);
    }

    pub fn finish(&self) {
        self.bar.finish();
    }

    pub fn println<S: Into<String>>(&self, s: S) {
        self.bar.println(s);
    }
}
