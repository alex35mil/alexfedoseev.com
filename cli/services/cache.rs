use std::io;

use serde::{de::DeserializeOwned, Deserialize, Serialize};
use tokio::fs;

use crate::{FileData, FileHash, Loc};

pub struct Cache;

pub trait CacheEntry {
    fn hash(&self) -> String;
}

pub struct CachableFile {
    pub source: Loc,
    pub cache: Loc,
}

impl CachableFile {
    pub fn new(source: Loc) -> Self {
        let cache = Loc::file_cache(&source);
        Self { source, cache }
    }
}

pub enum CacheResult<T> {
    Hit(T),
    Miss(FileData),
}

impl Cache {
    pub async fn clear() -> Result<(), io::Error> {
        fs::remove_dir_all(Loc::cache()).await
    }

    pub async fn write<T: Serialize>(file: CachableFile, data: T) -> anyhow::Result<()> {
        let bytes = json::to_vec(&data)?;
        if !file.cache.exists() {
            fs::create_dir_all(file.cache.parent().unwrap()).await?;
        }
        fs::write(file.cache, bytes).await?;
        Ok(())
    }

    pub async fn fetch<T>(file: &CachableFile) -> Result<CacheResult<T>, io::Error>
    where
        T: CacheEntry + DeserializeOwned,
    {
        let data = FileData::try_read(file.source.to_owned()).await?;
        match Cache::try_read::<T>(file).await {
            Some(cache) if cache.hash() == data.hash() => Ok(CacheResult::Hit(cache)),
            Some(_) | None => Ok(CacheResult::Miss(data)),
        }
    }

    async fn try_read<T>(file: &CachableFile) -> Option<T>
    where
        T: CacheEntry + DeserializeOwned,
    {
        let data = FileData::try_read(file.cache.to_owned()).await.ok()?;
        let cache = json::from_slice::<T>(&data.bytes).ok()?;
        Some(cache)
    }
}

#[derive(Serialize, Deserialize)]
pub struct ImageCache {
    pub hash: String,
    pub placeholder: String, // NOTE: This doesn't include invalidation key for placeholder itself
                             //       in case if params passed to primitive changed. Not critical.
}

impl ImageCache {
    pub fn new(hash: &FileHash, placeholder: String) -> Self {
        Self {
            hash: hash.to_string(),
            placeholder,
        }
    }
}

impl CacheEntry for ImageCache {
    fn hash(&self) -> String {
        self.hash.to_owned()
    }
}
