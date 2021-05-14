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
            CacheResult::Hit(cache) => Ok(Done::Output(cache.placeholder.into())),
            CacheResult::Miss(data) => {
                let placeholder = generate(&data.loc, input).await?;
                let image_cache = ImageCache::new(&data.hash, placeholder.to_owned());
                Cache::write(file, image_cache).await?;
                Ok(Done::Output(placeholder.into()))
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
            format!(
                "let {name}: Photo.src = %bs.raw(\"require('{path}?preset=photo')\")",
                name = self.full_size_binding(),
                path = self.rel_path(),
            )
        }

        pub fn thumb_require(&self) -> String {
            format!(
                "let {name}: Photo.thumb = %bs.raw(\"require('{path}?preset=galleryThumb')\")",
                name = self.thumb_binding(),
                path = self.rel_path(),
            )
        }

        pub fn array_item(&self) -> String {
            format!(
                "  (\"{id}\"->Photo.Id.pack, {full_size}, {thumb}),",
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
    use std::{io, path::PathBuf};

    use clap::Clap;
    use hex::FromHexError;
    use hmac::{Hmac, Mac, NewMac};
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

    #[derive(Error, Debug)]
    pub enum ImgProxySignUrlError {
        #[error("Failed to decode IMGPROXY_KEY hex value: {0}")]
        InvalidKey(FromHexError),
        #[error("Failed to decode IMGPROXY_SALT hex value: {0}")]
        InvalidSalt(FromHexError),
        #[error("Failed to read hash of the source file: {0}")]
        FailedToComputeHash(io::Error),
    }

    impl From<io::Error> for ImgProxySignUrlError {
        fn from(err: io::Error) -> Self {
            Self::FailedToComputeHash(err)
        }
    }

    pub async fn sign(
        input: &ImgUrlInput,
        config: &Config,
    ) -> Result<String, ImgProxySignUrlError> {
        let src = format!(
            "s3://{s3_bucket}/{file}",
            s3_bucket = config.AWS_S3_BUCKET(),
            file = input.file,
        );
        let ext = {
            let path = PathBuf::from(&input.file);
            let ext = path.extension().unwrap().to_str().unwrap();
            match ext {
                "gif" => "gif", // animated gifs
                _ => "webp",
            }
        };
        let path = format!(
            "/rs:{resize_type}:{width}:{height}:{enlarge}:{extend}/{src}.{ext}",
            resize_type = "auto",
            width = input.width,
            height = input.height,
            enlarge = 0,
            extend = 0,
            src = base64::encode_config(src.as_bytes(), base64::URL_SAFE_NO_PAD),
            ext = ext,
        );
        let decoded_key = match hex::decode(config.IMGPROXY_KEY()) {
            Ok(key) => key,
            Err(err) => return Err(ImgProxySignUrlError::InvalidKey(err)),
        };
        let decoded_salt = match hex::decode(config.IMGPROXY_SALT()) {
            Ok(salt) => salt,
            Err(err) => return Err(ImgProxySignUrlError::InvalidSalt(err)),
        };
        let mut hmac = HmacSha256::new_varkey(&decoded_key).unwrap();
        hmac.update(&decoded_salt);
        hmac.update(path.as_bytes());
        let signature = hmac.finalize().into_bytes();
        let signature = base64::encode_config(signature.as_slice(), base64::URL_SAFE_NO_PAD);
        let hash = {
            let file = CachableFile::new(Loc::image_file(&input.file));
            match Cache::fetch::<ImageCache>(&file).await? {
                CacheResult::Hit(cache) => cache.hash,
                CacheResult::Miss(data) => data.hash(),
            }
        };
        let url = format!(
            "https://{domain}/{signature}{path}?v={version}",
            domain = config.IMAGES_DOMAIN(),
            signature = signature,
            path = path,
            version = hash
        );
        Ok(url)
    }
}
