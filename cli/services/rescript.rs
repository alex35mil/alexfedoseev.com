use crate::{Cmd, CmdEnv, Env, Loc, Process, PATH};

fn cmd_env() -> CmdEnv {
    CmdEnv::one("PATH", PATH::extend(Loc::node_modules_bin()))
}

pub fn build(env: &Env) -> Cmd {
    cmd! {
        exe: "rescript build",
        env: match env {
            Env::Local => cmd_env(),
            Env::Remote => cmd_env().insert("OCAMLPARAM", "_,warn-error=+a"),
        },
        pwd: Loc::root(),
        msg: "Building ReScript app",
    }
}

pub fn watch() -> Process {
    process! {
        tag: "rescript",
        cmd: cmd! {
            exe: "rescript build -w",
            env: cmd_env(),
            pwd: Loc::root(),
            msg: "Watching ReScript app",
        },
    }
}

pub fn clean() -> Cmd {
    cmd! {
        exe: "rescript clean",
        env: cmd_env(),
        pwd: Loc::root(),
        msg: "Cleaning ReScript app",
    }
}

pub fn format() -> Cmd {
    cmd! {
        exe: "rescript format -all",
        env: cmd_env(),
        pwd: Loc::root(),
        msg: "Formatting ReScript app",
    }
}

pub fn convert() -> Cmd {
    cmd! {
        exe: "rescript convert -all",
        env: cmd_env(),
        pwd: Loc::root(),
        msg: "Converting ReScript app",
    }
}
