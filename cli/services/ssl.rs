use tokio::fs;

use crate::{CmdEnv, Config, Done, Loc, Output};

pub async fn generate_certs(config: &Config) -> Output {
    fs::create_dir_all(Loc::local_ssl_certs()).await?;
    cmd!(
        exe: format!(
            "mkcert -cert-file {domain}.pem -key-file {domain}.key {domain} '*.{domain}'",
            domain = config.WEB_DOMAIN()
        ),
        env: CmdEnv::parent(),
        pwd: Loc::local_ssl_certs(),
        msg: "Generating local SSL certificates",
    )
    .run()
    .await?;
    Ok(Done::Bye)
}
