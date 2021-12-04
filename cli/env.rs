use std::{collections::HashMap, fmt, iter::FromIterator, str::FromStr};

use clap::{AppSettings, Clap};

use crate::Loc;

#[derive(Clap, Clone, PartialEq, Debug)]
#[clap(setting = AppSettings::SubcommandRequiredElseHelp)]
pub enum Env {
    #[clap(about = "Executes on development stack")]
    Dev,
    #[clap(about = "Executes on production stack")]
    Prod,
}

impl Env {
    pub fn file(&self) -> Loc {
        match self {
            Env::Dev => Loc::dev_env_file(),
            Env::Prod => Loc::prod_env_file(),
        }
    }
}

impl fmt::Display for Env {
    fn fmt(&self, f: &mut fmt::Formatter<'_>) -> fmt::Result {
        write!(
            f,
            "{}",
            match self {
                Self::Dev => "development",
                Self::Prod => "production",
            }
        )
    }
}

impl FromStr for Env {
    type Err = &'static str;

    fn from_str(s: &str) -> Result<Self, Self::Err> {
        match s {
            "dev" | "development" => Ok(Self::Dev),
            "prod" | "production" => Ok(Self::Prod),
            _ => Err("Unexpected env value. Allowed values: development, dev, production, prod."),
        }
    }
}

#[derive(Clone)]
pub struct Config {
    env: Env,
    data: HashMap<String, String>,
}

impl Config {
    fn load(env: Env) -> Self {
        #[allow(deprecated)] // it was undeprecated
        let data = HashMap::from_iter(
            dotenv::from_path_iter(env.file().path())
                .unwrap()
                .map(Result::unwrap),
        );

        Self { env, data }
    }

    pub fn env(&self) -> &Env {
        &self.env
    }

    fn get(&self, key: &str) -> Option<&String> {
        self.data.get(key)
    }

    #[allow(non_snake_case)]
    pub fn WEB_DOMAIN(&self) -> &str {
        self.get("WEB_DOMAIN").expect("WEB_DOMAIN is not set")
    }

    #[allow(non_snake_case)]
    pub fn IMAGES_DOMAIN(&self) -> &str {
        self.get("IMAGES_DOMAIN").expect("IMAGES_DOMAIN is not set")
    }

    #[allow(non_snake_case)]
    pub fn AWS_REGION(&self) -> &str {
        self.get("AWS_REGION").expect("AWS_REGION is not set")
    }

    #[allow(non_snake_case)]
    pub fn AWS_S3_BUCKET(&self) -> &str {
        self.get("AWS_S3_BUCKET").expect("AWS_S3_BUCKET is not set")
    }

    #[allow(non_snake_case)]
    pub fn AWS_ACCESS_KEY_ID(&self) -> &str {
        self.get("AWS_ACCESS_KEY_ID")
            .expect("AWS_ACCESS_KEY_ID is not set")
    }

    #[allow(non_snake_case)]
    pub fn AWS_SECRET_ACCESS_KEY(&self) -> &str {
        self.get("AWS_SECRET_ACCESS_KEY")
            .expect("AWS_SECRET_ACCESS_KEY is not set")
    }

    #[allow(non_snake_case)]
    pub fn AWS_IMG_SECRET(&self) -> &str {
        self.get("AWS_IMG_SECRET")
            .expect("AWS_IMG_SECRET is not set")
    }

    #[allow(non_snake_case)]
    pub fn TWITTER_HANDLE(&self) -> &str {
        self.get("TWITTER_HANDLE")
            .expect("TWITTER_HANDLE is not set")
    }

    #[allow(non_snake_case)]
    pub fn FACEBOOK_APP_ID(&self) -> &str {
        self.get("FACEBOOK_APP_ID")
            .expect("FACEBOOK_APP_ID is not set")
    }

    #[allow(non_snake_case)]
    pub fn GA_MEASUREMENT_ID(&self) -> &str {
        self.get("GA_MEASUREMENT_ID")
            .expect("GA_MEASUREMENT_ID is not set")
    }
}

impl From<Env> for Config {
    fn from(env: Env) -> Self {
        Config::load(env)
    }
}

impl From<&Env> for Config {
    fn from(env: &Env) -> Self {
        Config::load(env.to_owned())
    }
}
