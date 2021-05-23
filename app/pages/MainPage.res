module Css = MainPageStyles

@module("images/meta.png?preset=basic") external metaImage: Image.basic = "default"

@module("images/me.png?preset=basicWithPlaceholder")
external photo: Image.basicWithPlaceholder = "default"

@react.component
let default = () => {
  <>
    <Head
      htmlTitle=Prefixed("Personal Site")
      socialTitle=Prefixed("Personal Site")
      description=Default
      image=metaImage.src
      ogType=#website
    />
    <div className=Css.container>
      <div className=Css.push />
      <div className=Css.content>
        <Image
          load=Eager
          src=photo.src
          size=Scaled({
            containerClassName: Some(Css.photoContainer),
            imgClassName: Some(Css.photo),
            imgStyle: None,
          })
          loader=Placeholder({src: photo.placeholder, transition: Slow})
        />
        <div className=Css.line />
        <div className=Css.headline>
          <div className=Css.logo> <Logo className=Css.logoSvg /> </div>
          <div className=Css.links>
            <div className=Css.nav>
              <Link.Box path=Route.blog className=Css.link> {"blog"->React.string} </Link.Box>
              <Link.Box path=Route.photo className=Css.link> {"photo"->React.string} </Link.Box>
              <Link.Box path=Route.me className=Css.link> {"me"->React.string} </Link.Box>
            </div>
            <div className=Css.diagonal />
            <div className=Css.social>
              <A.Box href=Route.twitter target=Blank className={cx([Css.icon, Css.twitterIcon])}>
                <TwitterIcon size=MD color=Faded />
              </A.Box>
              <A.Box href=Route.github target=Blank className={cx([Css.icon, Css.githubIcon])}>
                <GithubIcon size=MD color=Faded />
              </A.Box>
              <A.Box
                href=Route.instagram target=Blank className={cx([Css.icon, Css.instagramIcon])}>
                <InstagramIcon size=MD color=Faded />
              </A.Box>
            </div>
          </div>
        </div>
      </div>
      <ThemeSwitch className=Css.themeSwitch />
    </div>
  </>
}
