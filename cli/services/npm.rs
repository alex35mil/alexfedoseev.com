use crate::{Cmd, CmdEnv, Loc};

pub fn install() -> Cmd {
    cmd! {
        exe: "npm install",
        env: CmdEnv::empty(),
        pwd: Loc::root(),
        msg: "Installing NPM dependencies",
    }
}

pub fn remove_node_modules() -> Cmd {
    cmd! {
        exe: "rm -rf node_modules",
        env: CmdEnv::empty(),
        pwd: Loc::root(),
        msg: "Removing node_modules",
    }
}
