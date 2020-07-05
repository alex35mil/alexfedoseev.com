module Css = MainPageStyles;

[@react.component]
let make = () => {
  <Page>
    <div className=Css.container>
      <div className=Css.push />
      <div className=Css.content>
        <div className=Css.photo />
        <div className=Css.line />
        <div className=Css.headline>
          <div className=Css.logo> <Logo className=Css.logoSvg /> </div>
          <div className=Css.links>
            <div className=Css.nav>
              <Link.Box path=Route.blog className=Css.link>
                "blog"->React.string
              </Link.Box>
              <Link.Box path=Route.photo className=Css.link>
                "photo"->React.string
              </Link.Box>
              <Link.Box path=Route.me className=Css.link>
                "me"->React.string
              </Link.Box>
            </div>
            <div className=Css.diagonal />
            <div className=Css.social>
              <A.Box
                href=Route.twitter
                target=Blank
                className={Cn.make([Css.icon, Css.twitterIcon])}>
                <TwitterIcon size=MD color=Faded />
              </A.Box>
              <A.Box
                href=Route.github
                target=Blank
                className={Cn.make([Css.icon, Css.githubIcon])}>
                <GithubIcon size=MD color=Faded />
              </A.Box>
            </div>
          </div>
        </div>
      </div>
      <ThemeSwitch className=Css.themeSwitch />
    </div>
  </Page>;
};
