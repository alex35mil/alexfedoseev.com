use std::{io, str::FromStr};

use tokio::fs;

use crate::{Cmd, CmdEnv, Config, Done, Env, Loc, Output, Process, PATH};

fn env(config: &Config) -> CmdEnv {
    config
        .to_cmd_env()
        .insert("PATH", PATH::extend(Loc::node_modules_bin()))
        .insert("ENV", config.env())
        .insert("BIN", Loc::bin())
        .insert("ROOT", Loc::root())
        .insert("IMAGES_DIR", Loc::images())
        .insert("BLOG_POSTS_DIR", Loc::blog_posts())
}

pub async fn validate_cache(env: &Env) -> Output {
    let last_built_env = match fs::read_to_string(Loc::cached_build()).await {
        Ok(val) => match Env::from_str(&val) {
            Ok(env) => Some(env),
            Err(err) => return Err(anyhow!(err)),
        },
        Err(err) => match err.kind() {
            io::ErrorKind::NotFound => None,
            _ => return Err(err.into()),
        },
    };

    match last_built_env {
        Some(last_built_env) if last_built_env == *env => (),
        Some(_) | None => {
            clean_cache().run().await?;
            clean_build().run().await?;
            fs::write(Loc::cached_build(), env.to_string()).await?;
        }
    }

    Ok(Done::Bye)
}

pub fn dev() -> Process {
    process! {
        tag: "next",
        cmd: cmd! {
            exe: "next dev",
            env: env(&Config::local()),
            pwd: Loc::root(),
            msg: "Running development Next.js server",
        }
    }
}

pub fn build(config: &Config) -> Cmd {
    cmd! {
        exe: "next build",
        env: env(config),
        pwd: Loc::root(),
        msg: "Building production Next.js app",
    }
}

pub fn start() -> Process {
    process! {
      tag: "next",
      cmd: cmd! {
          exe: "next start",
          env: env(&Config::local()),
          pwd: Loc::root(),
          msg: "Running production Next.js server",
      }
    }
}

pub fn export(config: &Config) -> Cmd {
    cmd! {
        exe: "next export",
        env: env(config),
        pwd: Loc::root(),
        msg: "Exportiung static Next.js app",
    }
}

fn clean_cache() -> Cmd {
    cmd! {
        exe: format!("rm -rf {}", Loc::next_cache().relative_to(Loc::root())),
        env: CmdEnv::empty(),
        pwd: Loc::root(),
        msg: "Removing Next.js cache",
    }
}

fn clean_build() -> Cmd {
    cmd! {
        exe: format!("rm -rf {}", Loc::next_build().relative_to(Loc::root())),
        env: CmdEnv::empty(),
        pwd: Loc::root(),
        msg: "Removing Next.js build",
    }
}
