pub mod placeholder {
    use std::str;

    use clap::Clap;

    use crate::{
        services::cache::{CachableFile, Cache, CacheResult, ImageCache},
        CmdEnv, Done, Loc, Output,
    };

    #[derive(Clap, Debug)]
    pub struct PlaceholderInput {
        #[clap(index = 1)]
        file: String,
        #[clap(long, default_value = "200")]
        size: usize,
        #[clap(long, default_value = "256")]
        resize: usize,
        #[clap(long, default_value = "20")]
        shapes: usize,
    }

    async fn generate(loc: &Loc, input: &PlaceholderInput) -> anyhow::Result<String> {
        let bytes = cmd! {
            exe: format!(
                "{primitive} -i {i} -o - -n {n} -s {s} -r {r}",
                primitive = Loc::primitive_bin(),
                i = loc,
                s = input.size,
                r = input.resize,
                n = input.shapes,
            ),
            env: CmdEnv::empty(),
            pwd: Loc::root(),
            msg: "Rendering image placeholder",
        }
        .output()
        .await?
        .unwrap();
        let placeholder = str::from_utf8(&bytes)?;
        Ok(placeholder.to_string())
    }

    pub async fn render(input: &PlaceholderInput) -> Output {
        let file = CachableFile::new(Loc::image_file(&input.file));
        match Cache::fetch::<ImageCache>(&file).await? {
            CacheResult::Hit(cache) => Ok(Done::Output(cache.placeholder)),
            CacheResult::Miss(data) => {
                let placeholder = generate(&data.loc, input).await?;
                let image_cache = ImageCache::new(&data.hash, placeholder.to_owned());
                Cache::write(file, image_cache).await?;
                Ok(Done::Output(placeholder))
            }
        }
    }
}

pub mod gallery {
    use std::path::PathBuf;

    use rand::{seq::SliceRandom, thread_rng};
    use tokio::fs;

    use crate::Loc;

    struct Photo {
        id: String,
        path: PathBuf,
    }

    impl Photo {
        pub fn full_size_binding(&self) -> String {
            format!("photo_{}", self.id)
        }

        pub fn thumb_binding(&self) -> String {
            format!("photo_{}_thumb", self.id)
        }

        pub fn full_size_require(&self) -> String {
            let external = format!(
                r#"@module("{path}?preset=photo") external {name}: Image.responsive<Image.photo> = "default""#,
                name = self.full_size_binding(),
                path = self.rel_path(),
            );
            let binding = format!(r#"let {name} = {name}"#, name = self.full_size_binding(),);
            format!("{}\n{}", external, binding)
        }

        pub fn thumb_require(&self) -> String {
            let external = format!(
                r#"@module("{path}?preset=galleryThumb") external {name}: Image.responsive<Image.galleryThumb> = "default""#,
                name = self.thumb_binding(),
                path = self.rel_path(),
            );
            let binding = format!(r#"let {name} = {name}"#, name = self.thumb_binding(),);
            format!("{}\n{}", external, binding)
        }

        pub fn array_item(&self) -> String {
            format!(
                r#"  ("{id}"->Image.Id.pack, {full_size}, {thumb}),"#,
                id = self.id,
                full_size = self.full_size_binding(),
                thumb = self.thumb_binding()
            )
        }

        fn rel_path(&self) -> String {
            let mut parent = Loc::images().path().to_owned();
            parent.pop();
            self.path
                .strip_prefix(parent)
                .unwrap()
                .to_str()
                .unwrap()
                .to_string()
        }
    }

    impl From<PathBuf> for Photo {
        fn from(path: PathBuf) -> Self {
            Self {
                id: path
                    .file_stem()
                    .unwrap()
                    .to_str()
                    .unwrap()
                    .replace("_", "")
                    .replace("-", "_"),
                path,
            }
        }
    }

    pub async fn genetrate_index(n: Option<usize>) -> anyhow::Result<()> {
        let mut files = fs::read_dir(Loc::gallery_photos().path()).await?;
        let mut photos: Vec<Photo> = Vec::new();

        while let Some(entry) = files.next_entry().await? {
            let path = entry.path();
            if path.is_dir() {
                bail!("Gallery directory must not have subdirectories");
            } else if path.extension().unwrap().to_str().unwrap() != "jpg" {
                bail!(
                    "Unexpected file type in gallery directory: {}",
                    path.file_name().unwrap().to_str().unwrap()
                );
            } else {
                photos.push(path.into());
            }
        }

        let total_photos = photos.len();

        if let Some(n) = n {
            if n < total_photos {
                photos.shuffle(&mut thread_rng());
                photos.split_off(n).truncate(0);
            }
        }

        let mut requires: Vec<String> = Vec::with_capacity(total_photos * 2);
        let mut entries: Vec<String> = Vec::with_capacity(total_photos);

        for photo in photos {
            requires.push(photo.full_size_require());
            requires.push(photo.thumb_require());
            entries.push(photo.array_item());
        }

        let module = formatdoc!(
            "
              /* === GENERATED CONTENT === */

              {requires}

              let all = [
              {entries}
              ]
            ",
            requires = requires.join("\n"),
            entries = entries.join("\n"),
        );

        fs::write(Loc::gallery_photos_res(), module).await?;

        Ok(())
    }
}

pub mod url {
    use std::io;

    use clap::Clap;
    use hmac::{Hmac, Mac, NewMac};
    use serde::Serialize;
    use sha2::Sha256;
    use thiserror::Error;

    use crate::{
        services::cache::{CachableFile, Cache, CacheResult, ImageCache},
        Config, Env, Loc,
    };

    type HmacSha256 = Hmac<Sha256>;

    #[derive(Clap, Debug)]
    pub struct ImgUrlInput {
        #[clap(index = 1)]
        pub file: String,
        #[clap(long, short)]
        pub width: u32,
        #[clap(long, short)]
        pub height: u32,
        #[clap(long, short)]
        pub env: Env,
    }

    #[derive(Serialize, Debug)]
    struct ImgUrl {
        bucket: String,
        key: String,
        #[serde(skip_serializing_if = "Option::is_none")]
        edits: Option<ImgEdits>,
        #[serde(skip)]
        secret: String,
    }

    #[derive(Serialize, Debug)]
    struct ImgEdits {
        resize: ImgResize,
        jpeg: ImgJpeg,
    }

    #[derive(Serialize, Debug)]
    struct ImgResize {
        width: u32,
        height: u32,
        fit: ImgFit,
    }

    #[derive(Serialize, Debug)]
    struct ImgJpeg {
        quality: u32,
    }

    #[derive(Serialize, Debug)]
    #[serde(rename_all = "lowercase")]
    #[allow(dead_code)]
    enum ImgFit {
        Cover,
        Contain,
        Fill,
        Inside,
        Outside,
    }

    impl ImgUrl {
        pub fn new(input: &ImgUrlInput, config: &Config) -> Self {
            Self {
                bucket: config.AWS_S3_BUCKET().to_owned(),
                key: input.file.to_owned(),
                edits: if input.file.ends_with(".gif") {
                    None
                } else {
                    Some(ImgEdits {
                        resize: ImgResize {
                            width: input.width,
                            height: input.height,
                            fit: ImgFit::Cover,
                        },
                        jpeg: ImgJpeg {
                            quality: config.IMAGES_QUALITY(),
                        },
                    })
                },
                secret: config.AWS_IMG_SECRET().to_owned(),
            }
        }

        pub async fn sign(self, config: &Config) -> Result<String, ImgSignUrlError> {
            let params = json::to_vec(&self)?;
            let path = base64::encode_config(&params, base64::URL_SAFE);

            let mut mac = HmacSha256::new_from_slice(config.AWS_IMG_SECRET().as_bytes())
                .expect("HMAC can take key of any size");
            mac.update(format!("/{}", path).as_bytes());
            let signature = hex::encode(mac.finalize().into_bytes());

            let hash = {
                let file = CachableFile::new(Loc::image_file(&self.key));
                match Cache::fetch::<ImageCache>(&file).await? {
                    CacheResult::Hit(cache) => cache.hash,
                    CacheResult::Miss(data) => data.hash(),
                }
            };

            let url = format!(
                "https://{domain}/{path}?signature={signature}&version={version}",
                domain = config.IMAGES_DOMAIN(),
                path = path,
                signature = signature,
                version = hash
            );

            Ok(url)
        }
    }

    #[derive(Error, Debug)]
    pub enum ImgSignUrlError {
        #[error("Failed to serialize image params. {0}")]
        FailedToSerializeImgParams(#[from] json::Error),
        #[error("Failed to read hash of the source file: {0}")]
        FailedToComputeHash(#[from] io::Error),
    }

    pub async fn sign(input: &ImgUrlInput, config: &Config) -> Result<String, ImgSignUrlError> {
        let url = ImgUrl::new(input, config).sign(config).await?;
        Ok(url)
    }
}
