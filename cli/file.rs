use std::{convert::TryFrom, ffi::OsStr, fmt, io};

use md5::Digest;
use tokio::{
    fs,
    io::{AsyncReadExt, BufReader},
};

use crate::Loc;

#[derive(Clone, Debug)]
pub struct FileHash(Digest);

impl FileHash {
    pub fn bytes(&self) -> [u8; 16] {
        self.0 .0
    }
}

impl From<Digest> for FileHash {
    fn from(digest: Digest) -> Self {
        Self(digest)
    }
}

impl fmt::Display for FileHash {
    fn fmt(&self, f: &mut fmt::Formatter) -> fmt::Result {
        write!(f, "{:x}", self.0)
    }
}

#[derive(Debug)]
pub enum FileFormat {
    // Js,
    // Css,
    Jpg,
    Png,
    Gif,
    // Webp,
    // Svg,
    // Ico,
    // Woff,
    // Woff2,
    // Json,
    // Webapp,
}

impl FileFormat {
    pub fn content_type(&self) -> &'static str {
        match self {
            // Self::Js => "application/javascript",
            // Self::Css => "text/css",
            Self::Jpg => "image/jpeg",
            Self::Png => "image/png",
            Self::Gif => "image/gif",
            // Self::Webp => "image/webp",
            // Self::Svg => "image/svg+xml",
            // Self::Ico => "image/x-icon",
            // Self::Woff => "font/woff",
            // Self::Woff2 => "font/woff2",
            // Self::Json => "application/json",
            // Self::Webapp => "application/manifest+json",
        }
    }
}

impl TryFrom<&OsStr> for FileFormat {
    type Error = ();

    fn try_from(ext: &OsStr) -> Result<Self, Self::Error> {
        match ext.to_str() {
            Some(ext) => match ext.to_lowercase().as_ref() {
                // "js" => Ok(Self::Js),
                // "css" => Ok(Self::Css),
                "jpg" | "jpeg" => Ok(Self::Jpg),
                "png" => Ok(Self::Png),
                "gif" => Ok(Self::Gif),
                // "webp" => Ok(Self::Webp),
                // "svg" => Ok(Self::Svg),
                // "ico" => Ok(Self::Ico),
                // "woff" => Ok(Self::Woff),
                // "woff2" => Ok(Self::Woff2),
                // "json" => Ok(Self::Json),
                // "webapp" => Ok(Self::Webapp),
                _ => Err(()),
            },
            None => Err(()),
        }
    }
}

#[derive(Debug)]
pub struct FileData {
    pub loc: Loc,
    pub bytes: Vec<u8>,
    pub length: usize,
    pub hash: FileHash,
}

impl FileData {
    pub fn hash(&self) -> String {
        self.hash.to_string()
    }

    pub async fn try_read(path: Loc) -> Result<Self, io::Error> {
        let contents = fs::File::open(&path).await?;
        let mut reader = BufReader::new(contents);
        let mut bytes = vec![];
        let length = reader.read_to_end(&mut bytes).await?;
        let hash = md5::compute(&bytes);

        Ok(Self {
            loc: path,
            bytes,
            length,
            hash: hash.into(),
        })
    }
}
