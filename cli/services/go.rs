use crate::{Cmd, CmdEnv, Loc};

const PRIMITIVE_VERSION: &str = "0373c21";

pub fn vendor_primitive_cmd() -> Cmd {
    cmd! {
        exe: format!(
            "go get -u github.com/fogleman/primitive@{version}",
            version = PRIMITIVE_VERSION
        ),
        env: CmdEnv::one("GOBIN", Loc::vendor()),
        pwd: Loc::root(),
        msg: "Vendoring primitive",
    }
}
