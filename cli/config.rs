use std::{collections::HashMap, iter::FromIterator};

use crate::{CmdEnv, Env};

#[derive(Clone)]
pub struct Config {
    env: Env,
    data: HashMap<String, String>,
}

impl Config {
    pub fn local() -> Self {
        Self::load(Env::Local)
    }

    pub fn remote() -> Self {
        Self::load(Env::Remote)
    }

    pub fn env(&self) -> &Env {
        &self.env
    }

    pub fn data(&self) -> &HashMap<String, String> {
        &self.data
    }

    fn load(env: Env) -> Self {
        #[allow(deprecated)] // it was undeprecated
        let data = HashMap::from_iter(
            dotenv::from_path_iter(env.file().path())
                .unwrap()
                .map(Result::unwrap),
        );
        Self { env, data }
    }

    #[allow(non_snake_case)]
    pub fn WEB_DOMAIN(&self) -> &str {
        self.data.get("WEB_DOMAIN").expect("WEB_DOMAIN is not set")
    }

    #[allow(non_snake_case)]
    pub fn IMAGES_DOMAIN(&self) -> &str {
        self.data
            .get("IMAGES_DOMAIN")
            .expect("IMAGES_DOMAIN is not set")
    }

    #[allow(non_snake_case)]
    pub fn AWS_REGION(&self) -> &str {
        self.data.get("AWS_REGION").expect("AWS_REGION is not set")
    }

    #[allow(non_snake_case)]
    pub fn AWS_ENDPOINT(&self) -> Option<&String> {
        self.data.get("AWS_ENDPOINT")
    }

    #[allow(non_snake_case)]
    pub fn AWS_S3_BUCKET(&self) -> &str {
        self.data
            .get("AWS_S3_BUCKET")
            .expect("AWS_S3_BUCKET is not set")
    }

    #[allow(non_snake_case)]
    pub fn AWS_ACCESS_KEY_ID(&self) -> &str {
        self.data
            .get("AWS_ACCESS_KEY_ID")
            .expect("AWS_ACCESS_KEY_ID is not set")
    }

    #[allow(non_snake_case)]
    pub fn AWS_SECRET_ACCESS_KEY(&self) -> &str {
        self.data
            .get("AWS_SECRET_ACCESS_KEY")
            .expect("AWS_SECRET_ACCESS_KEY is not set")
    }

    #[allow(non_snake_case)]
    pub fn IMGPROXY_KEY(&self) -> &str {
        self.data
            .get("IMGPROXY_KEY")
            .expect("IMGPROXY_KEY is not set")
    }

    #[allow(non_snake_case)]
    pub fn IMGPROXY_SALT(&self) -> &str {
        self.data
            .get("IMGPROXY_SALT")
            .expect("IMGPROXY_SALT is not set")
    }

    pub fn to_cmd_env(&self) -> CmdEnv {
        CmdEnv::new(self.data().to_owned())
    }
}

impl From<&Env> for Config {
    fn from(env: &Env) -> Self {
        match env {
            Env::Local => Config::local(),
            Env::Remote => Config::remote(),
        }
    }
}
