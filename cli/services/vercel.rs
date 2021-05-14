use crate::{Cmd, CmdEnv, Loc};

pub fn deploy() -> Cmd {
    cmd! {
        exe: "vercel --prod",
        env: CmdEnv::empty(),
        pwd: Loc::root(),
        msg: "Deploying Next.js app",
    }
}
