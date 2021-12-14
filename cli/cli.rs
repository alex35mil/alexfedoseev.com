use std::str;

use clap::{AppSettings, Clap};

use crate::{
    services::{
        aws::S3,
        cache::Cache,
        cargo, docker, go,
        img::{self, placeholder::PlaceholderInput, url::ImgUrlInput},
        next, npm, rescript, ssl, sys, vercel,
    },
    Config, Done, Env, Output, ProcessPool,
};

#[derive(Clap)]
#[clap(
    name = "blog",
    version = "1.0",
    author = "Alex Fedoseev <alex@fedoseev.mx>"
)]
#[clap(global_setting = AppSettings::ColoredHelp)]
pub enum Cli {
    #[clap(about = "Sets up local environment")]
    Setup,
    #[clap(about = "Resets local environment")]
    Reset,
    #[clap(about = "Updates this CLI")]
    Update,
    #[clap(about = "Runs local app")]
    Run(Env),
    #[clap(about = "Deploys the app")]
    Deploy,
    #[clap(name = "rescript", about = "ReScript commands")]
    ReScript(ReScriptCli),
    #[clap(about = "Next.js commands")]
    Next(NextCli),
    #[clap(about = "Docker commands")]
    Docker(DockerCli),
    #[clap(about = "Image commands")]
    Img(ImgCli),
    #[clap(about = "S3 commands")]
    S3(S3Cli),
    #[clap(about = "Cache commands")]
    Cache(CacheCli),
}

#[derive(Clap, Debug)]
#[clap(setting = AppSettings::SubcommandRequiredElseHelp)]
pub enum RunCli {
    #[clap(alias = "dev", about = "Runs development app")]
    Development,
    #[clap(alias = "prod", about = "Runs production app")]
    Production,
}

#[derive(Clap, Debug)]
#[clap(setting = AppSettings::SubcommandRequiredElseHelp)]
pub enum ReScriptCli {
    #[clap(about = "Builds ReScript app", setting = AppSettings::SubcommandRequiredElseHelp)]
    Build(Env),
    #[clap(about = "Watches ReScript app")]
    Watch,
    #[clap(about = "Cleans ReScript app")]
    Clean,
    #[clap(about = "Formats ReScript app")]
    Format,
    #[clap(about = "Converts ReScript app")]
    Convert,
}

#[derive(Clap, Debug)]
#[clap(setting = AppSettings::SubcommandRequiredElseHelp)]
pub enum NextCli {
    #[clap(about = "Starts Next.js development server")]
    Develop,
    #[clap(about = "Builds Next.js production app", setting = AppSettings::SubcommandRequiredElseHelp)]
    Build(Env),
    #[clap(about = "Starts Next.js production server")]
    Start,
    #[clap(about = "Exports static Next.js app", setting = AppSettings::SubcommandRequiredElseHelp)]
    Export(Env),
}

#[derive(Clap, Debug)]
#[clap(setting = AppSettings::SubcommandRequiredElseHelp)]
pub enum DockerCli {
    #[clap(about = "Docker Compose commands", setting = AppSettings::SubcommandRequiredElseHelp)]
    Compose(DockerComposeCli),
}

#[derive(Clap, Debug)]
#[clap(setting = AppSettings::SubcommandRequiredElseHelp)]
pub enum DockerComposeCli {
    #[clap(about = "Starts Docker Compose services")]
    Up,
    #[clap(about = "Builds Docker Compose services")]
    Build,
}

#[derive(Clap, Debug)]
#[clap(setting = AppSettings::SubcommandRequiredElseHelp)]
pub enum ImgCli {
    #[clap(about = "Renders image placeholder")]
    RenderPlaceholder(PlaceholderInput),
    #[clap(about = "Generates photo index for gallery")]
    GenerateIndex {
        #[clap(short, about = "Number of images")]
        n: Option<usize>,
    },
    #[clap(about = "Generates signed image URL")]
    SignUrl(ImgUrlInput),
}

#[derive(Clap, Debug)]
#[clap(setting = AppSettings::SubcommandRequiredElseHelp)]
pub enum S3Cli {
    #[clap(about = "Syncs files with S3 bucket", setting = AppSettings::SubcommandRequiredElseHelp)]
    Sync(Env),
    #[clap(alias = "ls", about = "Lists files in S3 bucket")]
    List {
        env: Env,
        #[clap(
            long,
            about = "If set, lists full S3 objects. Otherwise, prints links to images."
        )]
        detailed: bool,
    },
    #[clap(alias = "reset-dev", about = "Resets development S3 bucket")]
    ResetDevelopmentBucket,
    #[clap(alias = "empty-dev", about = "Empties development S3 bucket")]
    EmptyDevelopmentBucket,
}

#[derive(Clap, Debug)]
#[clap(setting = AppSettings::SubcommandRequiredElseHelp)]
pub enum CacheCli {
    #[clap(about = "Clear cache commands")]
    Clear(ClearCache),
}

#[derive(Clap, Debug)]
#[clap(setting = AppSettings::SubcommandRequiredElseHelp)]
pub enum ClearCache {
    #[clap(about = "Clears images cache")]
    Img,
    #[clap(about = "Clears build cache")]
    Build,
    #[clap(about = "Clears all caches")]
    All,
}

impl Cli {
    pub async fn run() -> Output {
        let cli = Cli::parse();

        match cli {
            Cli::Setup => {
                let config = Config::from(Env::Dev);

                sys::ensure_prerequisites().await?;
                ssl::generate_certs(&config).await?;
                npm::install().run().await?;
                docker::compose::build().run().await?;
                go::vendor_primitive_cmd().run().await?;

                Ok(Done::Bye)
            }

            Cli::Reset => {
                let config = Config::from(Env::Dev);

                sys::ensure_prerequisites().await?;
                ssl::generate_certs(&config).await?;
                npm::remove_node_modules().run().await?;
                npm::install().run().await?;
                docker::compose::build().run().await?;
                go::vendor_primitive_cmd().run().await?;
                S3::new(&config).sync().await?; // TODO: Handle by steward

                Ok(Done::Bye)
            }

            Cli::Update => {
                cargo::install().run().await?;
                Ok(Done::Bye)
            }

            Cli::Run(Env::Dev) => {
                let env = Env::Dev;

                next::validate_cache(&env).await?;
                rescript::build(&env).run().await?;
                ProcessPool::run(vec![rescript::watch(), next::dev()]).await?;
                Ok(Done::Bye)
            }

            Cli::Run(Env::Prod) => {
                let env = Env::Dev;
                let config = Config::from(&env);

                rescript::build(&env).run().await?;
                next::validate_cache(&env).await?;
                next::build(&config).run().await?;
                S3::new(&env.into()).sync().await?;
                ProcessPool::run(vec![next::start()]).await?;

                Ok(Done::Bye)
            }

            Cli::Deploy => {
                let env = Env::Prod;
                let config = Config::from(&env);

                img::gallery::genetrate_index(None).await?;
                rescript::clean().run().await?;
                next::validate_cache(&env).await?;
                rescript::build(&env).run().await?;
                next::build(&config).run().await?;
                next::export(&config).run().await?;
                S3::new(&config).sync().await?;
                vercel::deploy().run().await?;
                // TODO: invalidate cloudfront cache for updated images

                Ok(Done::Bye)
            }

            Cli::ReScript(ReScriptCli::Build(ref env)) => {
                rescript::build(env).run().await?;
                Ok(Done::Bye)
            }

            Cli::ReScript(ReScriptCli::Watch) => {
                rescript::watch().cmd().run().await?;
                Ok(Done::Bye)
            }

            Cli::ReScript(ReScriptCli::Clean) => {
                rescript::clean().run().await?;
                Ok(Done::Bye)
            }

            Cli::ReScript(ReScriptCli::Format) => {
                rescript::format().run().await?;
                Ok(Done::Bye)
            }

            Cli::ReScript(ReScriptCli::Convert) => {
                rescript::convert().run().await?;
                Ok(Done::Bye)
            }

            Cli::Next(NextCli::Develop) => {
                next::validate_cache(&Env::Dev).await?;
                next::dev().cmd().run().await?;
                Ok(Done::Bye)
            }

            Cli::Next(NextCli::Build(ref env)) => {
                let config: Config = env.into();

                next::validate_cache(env).await?;
                next::build(&config).run().await?;

                Ok(Done::Bye)
            }

            Cli::Next(NextCli::Start) => {
                let env = Env::Dev;
                let config = Config::from(&env);

                next::validate_cache(&env).await?;
                next::build(&config).run().await?;
                next::start().cmd().run().await?;

                Ok(Done::Bye)
            }

            Cli::Next(NextCli::Export(ref env)) => {
                let config: Config = env.into();

                next::validate_cache(env).await?;
                next::build(&config).run().await?;
                next::export(&config).run().await?;

                Ok(Done::Bye)
            }

            Cli::Docker(DockerCli::Compose(compose)) => match compose {
                DockerComposeCli::Up => {
                    docker::compose::up().cmd().run().await?;
                    Ok(Done::Bye)
                }
                DockerComposeCli::Build => {
                    docker::compose::build().run().await?;
                    Ok(Done::Bye)
                }
            },

            Cli::Img(ImgCli::GenerateIndex { n }) => {
                img::gallery::genetrate_index(n).await?;
                Ok(Done::Bye)
            }

            Cli::Img(ImgCli::SignUrl(input)) => {
                let config = Config::from(&input.env);
                let url = img::url::sign(&input, &config).await?;
                Ok(Done::Output(url))
            }

            Cli::Img(ImgCli::RenderPlaceholder(input)) => img::placeholder::render(&input).await,

            Cli::S3(S3Cli::ResetDevelopmentBucket) => {
                S3::new(&Env::Dev.into()).reset_bucket().await
            }

            Cli::S3(S3Cli::EmptyDevelopmentBucket) => {
                S3::new(&Env::Dev.into()).empty_bucket().await
            }

            Cli::S3(S3Cli::List { env, detailed }) => S3::new(&env.into()).list(detailed).await,

            Cli::S3(S3Cli::Sync(env)) => S3::new(&env.into()).sync().await,

            Cli::Cache(CacheCli::Clear(ClearCache::Img)) => {
                Cache::clear().await?;
                Ok(Done::Bye)
            }

            Cli::Cache(CacheCli::Clear(ClearCache::Build)) => {
                next::clear_cache().run().await?;
                next::clear_cached().run().await?;
                Ok(Done::Bye)
            }

            Cli::Cache(CacheCli::Clear(ClearCache::All)) => {
                Cache::clear().await?;
                next::clear_cache().run().await?;
                next::clear_cached().run().await?;
                Ok(Done::Bye)
            }
        }
    }
}
