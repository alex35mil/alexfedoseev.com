use std::{
    fmt,
    path::{Path, PathBuf},
};

use pathdiff;
use steward::Location;

#[derive(Clone, Debug)]
pub struct Loc(PathBuf);

lazy_static! {
    static ref ROOT: Loc = Loc::find_root();
}

impl Loc {
    pub fn root() -> Self {
        ROOT.to_owned()
    }

    pub fn app() -> Self {
        ROOT.join("app")
    }

    pub fn app_pages() -> Self {
        Loc::app().join("pages")
    }

    pub fn blog_pages() -> Self {
        Loc::app_pages().join("blog")
    }

    pub fn blog_posts() -> Self {
        Loc::blog_pages().join("posts")
    }

    pub fn photo_pages() -> Self {
        Loc::app_pages().join("photo")
    }

    pub fn gallery_photos_res() -> Self {
        Loc::photo_pages().join("modules").join("GalleryPhotos.res")
    }

    pub fn env() -> Self {
        ROOT.join("env")
    }

    pub fn local_env() -> Self {
        Loc::env().join("local")
    }

    pub fn local_docker_compose() -> Self {
        Loc::local_env().join("docker-compose.yml")
    }

    pub fn local_ssl_certs() -> Self {
        Loc::local_env().join("certs")
    }

    pub fn local_env_file() -> Self {
        Loc::local_env().join(".env")
    }

    pub fn localstack_dir() -> Self {
        Loc::local_env().join(".aws")
    }

    pub fn localstack_data_dir() -> Self {
        Loc::localstack_dir().join("data")
    }

    pub fn localstack_recorded_api_calls() -> Self {
        Loc::localstack_data_dir().join("recorded_api_calls.json")
    }

    pub fn remote_env() -> Self {
        Loc::env().join("remote")
    }

    pub fn remote_env_file() -> Self {
        Loc::remote_env().join(".env")
    }

    pub fn images() -> Self {
        ROOT.join("images")
    }

    pub fn image_file<P: AsRef<Path>>(path: P) -> Self {
        Loc::images().join(path)
    }

    pub fn gallery_photos() -> Self {
        Loc::images().join("gallery")
    }

    pub fn node_modules() -> Self {
        ROOT.join("node_modules")
    }

    pub fn node_modules_bin() -> Self {
        Loc::node_modules().join(".bin")
    }

    pub fn cache() -> Self {
        ROOT.join(".cache")
    }

    pub fn next_cache() -> Self {
        ROOT.join(".next")
    }

    pub fn next_build() -> Self {
        ROOT.join("out")
    }

    pub fn cached_build() -> Self {
        ROOT.join(".cached")
    }

    pub fn file_cache(src: &Loc) -> Self {
        let mut file = src
            .path()
            .strip_prefix(Loc::images())
            .unwrap()
            .to_path_buf();
        file.set_file_name(format!(
            "{}.cache",
            file.file_name().unwrap().to_str().unwrap()
        ));
        Loc::cache().join(file)
    }

    pub fn vendor() -> Self {
        ROOT.join("vendor")
    }

    pub fn primitive_bin() -> Self {
        Loc::vendor().join("primitive")
    }

    pub fn bin() -> Self {
        Self(std::env::current_exe().unwrap())
    }
}

impl Loc {
    const ROOT_MARKER: &'static str = "Cargo.lock";

    fn find_root() -> Self {
        let cwd = std::env::current_dir().expect("Failed to get current directory of the process");
        Self(Self::traverse(cwd))
    }

    fn traverse(dir: PathBuf) -> PathBuf {
        if dir.join(Self::ROOT_MARKER).exists() {
            dir
        } else {
            Self::traverse(
                dir.parent()
                    .expect("Failed to get parent directory during root search")
                    .to_path_buf(),
            )
        }
    }

    fn join<P: AsRef<Path>>(&self, path: P) -> Self {
        Self(self.as_path().join(path))
    }

    pub fn exists(&self) -> bool {
        self.0.exists()
    }

    pub fn parent(&self) -> Option<Self> {
        self.0.parent().map(|x| Self(x.to_owned()))
    }

    pub fn path(&self) -> &PathBuf {
        &self.0
    }

    pub fn relative_to<P: AsRef<Path>>(&self, p: P) -> Self {
        Self(pathdiff::diff_paths(&self.0, p).unwrap())
    }
}

impl Location for Loc {
    fn apex() -> Self {
        Self::root()
    }

    fn as_path(&self) -> &PathBuf {
        &self.0
    }
}

impl AsRef<Path> for Loc {
    fn as_ref(&self) -> &Path {
        &self.0
    }
}

impl From<PathBuf> for Loc {
    fn from(path: PathBuf) -> Self {
        Self(path)
    }
}

impl fmt::Display for Loc {
    fn fmt(&self, f: &mut fmt::Formatter<'_>) -> fmt::Result {
        write!(f, "{}", self.path().to_str().unwrap())
    }
}
