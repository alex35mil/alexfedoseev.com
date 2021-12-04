#![allow(clippy::enum_variant_names)]

#[macro_use]
extern crate anyhow;
#[macro_use]
extern crate steward;
#[macro_use]
extern crate indoc;
#[macro_use]
extern crate lazy_static;

mod cli;
mod env;
mod file;
mod loc;
mod result;
mod services;
mod timer;

use std::process;

use crate::{
    cli::Cli,
    env::{Config, Env},
    file::{FileData, FileFormat, FileHash},
    loc::Loc,
    result::{Done, Output},
    timer::Timer,
};

pub type Cmd = steward::Cmd<Loc>;
pub type CmdEnv = steward::Env;
pub type Process = steward::Process<Loc>;
pub type ProcessPool = steward::ProcessPool;
pub type PATH = steward::env::PATH;

#[tokio::main]
async fn main() {
    let timer = Timer::start();

    match Cli::run().await {
        Ok(Done::Output(data)) => {
            let spent = timer.finish();
            println!("{}", data);
            eprintln!("\n✨  Done in {}.", spent);
            process::exit(0);
        }
        Ok(Done::Bye) => {
            let spent = timer.finish();
            eprintln!("\n✨  Done in {}.", spent);
            process::exit(0);
        }
        Err(err) => {
            eprintln!("\n❌  {}", err);
            process::exit(1);
        }
    }
}
