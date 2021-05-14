pub mod compose {
    use std::{fmt, time::Duration};

    use clap::Clap;

    use crate::{Cmd, CmdEnv, Loc, Process};

    #[derive(Clap, Debug)]
    pub enum Service {
        #[clap(name = "nginx", about = "Restarts nginx service")]
        Nginx,
        #[clap(name = "aws", about = "Restarts aws service")]
        Aws,
        #[clap(name = "imgproxy", about = "Restarts imgproxy service")]
        ImgProxy,
    }

    impl Service {
        pub fn to_str(&self) -> &str {
            match self {
                Service::Nginx => "nginx",
                Service::Aws => "aws",
                Service::ImgProxy => "imgproxy",
            }
        }
    }

    impl fmt::Display for Service {
        fn fmt(&self, f: &mut fmt::Formatter<'_>) -> fmt::Result {
            write!(f, "{}", self.to_str())
        }
    }

    fn env() -> CmdEnv {
        CmdEnv::one("COMPOSE_PROJECT_NAME", "alexfedoseev_com")
    }

    pub fn build() -> Cmd {
        cmd! {
            exe: "docker-compose build",
            env: env(),
            pwd: Loc::local_env(),
            msg: "Building Docker Compose services",
        }
    }

    pub fn up() -> Process {
        process! {
            tag: "docker-compose",
            cmd: cmd! {
                exe: "docker-compose up --build",
                env: env(),
                pwd: Loc::local_env(),
                msg: "Running Docker Compose services",
            },
            timeout: Duration::from_secs(20),
        }
    }
}
