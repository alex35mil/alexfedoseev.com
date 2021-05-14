use std::{fmt, str::FromStr};

use clap::Clap;

use crate::Loc;

#[derive(Clap, Clone, PartialEq, Debug)]
pub enum Env {
    #[clap(about = "Executes on local stack")]
    Local,
    #[clap(about = "Executes on remote stack")]
    Remote,
}

impl Env {
    pub fn file(&self) -> Loc {
        match self {
            Env::Local => Loc::local_env_file(),
            Env::Remote => Loc::remote_env_file(),
        }
    }
}

impl Default for Env {
    fn default() -> Self {
        Env::Local
    }
}

impl fmt::Display for Env {
    fn fmt(&self, f: &mut fmt::Formatter<'_>) -> fmt::Result {
        write!(
            f,
            "{}",
            match self {
                Self::Local => "local",
                Self::Remote => "remote",
            }
        )
    }
}

impl FromStr for Env {
    type Err = &'static str;

    fn from_str(s: &str) -> Result<Self, Self::Err> {
        match s {
            "local" => Ok(Self::Local),
            "remote" => Ok(Self::Remote),
            _ => Err("Unexpected env value. Allowed values: local, remote."),
        }
    }
}
