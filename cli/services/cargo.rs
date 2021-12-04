use crate::{Cmd, CmdEnv, Loc};

pub fn install() -> Cmd {
    cmd! {
        exe: "cargo install --locked --path .",
        env: CmdEnv::empty(),
        pwd: Loc::root(),
        msg: "Updating the CLI",
    }
}
