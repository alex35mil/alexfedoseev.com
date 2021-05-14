use crate::{Cmd, CmdEnv, Done, Loc, Output};

fn check_node_cmd() -> Cmd {
    cmd! {
        exe: "node --version",
        env: CmdEnv::parent(),
        pwd: Loc::root(),
        msg: "Checking Node",
    }
}

fn check_npm_cmd() -> Cmd {
    cmd! {
        exe: "npm --version",
        env: CmdEnv::parent(),
        pwd: Loc::root(),
        msg: "Checking NPM",
    }
}

fn check_cargo_watch_cmd() -> Cmd {
    cmd! {
        exe: "cargo watch --version",
        env: CmdEnv::parent(),
        pwd: Loc::root(),
        msg: "Checking Cargo watch",
    }
}

fn check_docker_cmd() -> Cmd {
    cmd! {
        exe: "docker --version",
        env: CmdEnv::parent(),
        pwd: Loc::root(),
        msg: "Checking Docker",
    }
}

fn check_docker_compose_cmd() -> Cmd {
    cmd! {
        exe: "docker-compose --version",
        env: CmdEnv::parent(),
        pwd: Loc::root(),
        msg: "Checking Docker Compose",
    }
}

fn check_go_cmd() -> Cmd {
    cmd! {
        exe: "go version",
        env: CmdEnv::parent(),
        pwd: Loc::root(),
        msg: "Checking Go",
    }
}

fn check_mkcert_cmd() -> Cmd {
    cmd! {
        exe: "mkcert -version",
        env: CmdEnv::parent(),
        pwd: Loc::root(),
        msg: "Checking mkcert",
    }
}

pub async fn ensure_prerequisites() -> Output {
    if let Err(_) = check_node_cmd().run().await {
        bail!("Node is not installed. Install it from https://nodejs.org");
    }
    if let Err(_) = check_npm_cmd().run().await {
        bail!("NPM is not installed. Install it from https://www.npmjs.com");
    }
    if let Err(_) = check_cargo_watch_cmd().run().await {
        bail!(
            "Cargo watch is not installed. Install it from https://github.com/passcod/cargo-watch"
        );
    }
    if let Err(_) = check_docker_cmd().run().await {
        bail!("Docker is not installed. Install it from https://docs.docker.com/get-docker");
    }
    if let Err(_) = check_docker_compose_cmd().run().await {
        bail!("Docker Compose is not installed. Install it from https://docs.docker.com/compose/install/");
    }
    if let Err(_) = check_go_cmd().run().await {
        bail!("Go is not installed. Install it from https://golang.org/doc/install");
    }
    if let Err(_) = check_mkcert_cmd().run().await {
        bail!("mkcert is not installed. Install it from https://github.com/FiloSottile/mkcert");
    }

    Ok(Done::Bye)
}
