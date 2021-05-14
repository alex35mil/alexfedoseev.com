module Css = LayoutStyles

@react.component
let make = (~children) => {
  let router = Router.useRouter()
  let route = router->Router.route

  let {ThemeContext.current: theme} = React.useContext(ThemeContext.ctx)

  let blurOnClick = React.useCallback0(event => (event->ReactEvent.Mouse.target)["blur"](.))

  // Make click outside work in Safari on iOS
  <div className=Css.container onClick=ignore>
    <div className=Css.header>
      <div className=Css.logo>
        <Link.Box path=Route.main className=Css.logoLink> <Logo className=Css.logoSvg /> </Link.Box>
      </div>
      <div className=Css.navigation>
        <Link.Box
          path=Route.blog
          className={cx([
            Css.navLink,
            route->Route.isBlog ? Css.navLinkActive : Css.navLinkInactive,
          ])}
          onClick=blurOnClick>
          {"blog"->React.string}
        </Link.Box>
        <Link.Box
          path=Route.photo
          className={cx([
            Css.navLink,
            route->Route.isPhoto ? Css.navLinkActive : Css.navLinkInactive,
          ])}
          onClick=blurOnClick>
          {"photo"->React.string}
        </Link.Box>
        <Link.Box
          path=Route.me
          className={cx([Css.navLink, route->Route.isMe ? Css.navLinkActive : Css.navLinkInactive])}
          onClick=blurOnClick>
          {"me"->React.string}
        </Link.Box>
      </div>
      <ThemeSwitch className=Css.themeSwitchHeader />
    </div>
    children
    <div className=Css.footer>
      <div className=Css.footerNav>
        <Link path=Route.main underline=WhenInteracted className=Css.footerText>
          {"Home"->React.string}
        </Link>
        <Link path=Route.blog underline=WhenInteracted className=Css.footerText>
          {"Blog"->React.string}
        </Link>
        <Link path=Route.photo underline=WhenInteracted className=Css.footerText>
          {"Photo"->React.string}
        </Link>
        <Link path=Route.me underline=WhenInteracted className=Css.footerText>
          {"Me"->React.string}
        </Link>
      </div>
      <div className=Css.footerCopy>
        <span className=Css.footerText> {j`©`->React.string} </span>
        {switch theme {
        | Light =>
          <img
            src=%raw("require('images/sign-light.png?preset=basic').src")
            className=Css.copySignature
          />
        | Dark =>
          <img
            src=%raw("require('images/sign-dark.png?preset=basic').src") className=Css.copySignature
          />
        }}
        <span className=Css.footerText>
          {
            let start = "2015"
            let current = Js.Date.make()->Js.Date.getFullYear->Float.toString

            `${start}—${current}`->React.string
          }
        </span>
      </div>
      <div className=Css.footerSources>
        <A href=Route.src target=Blank underline=WhenInteracted className=Css.footerSourcesLink>
          <CodeIcon size=SM color=Faded />
          <span className=Css.footerText> {"src"->React.string} </span>
        </A>
      </div>
      <div className=Css.footerIcons>
        <A.Box
          href=Route.twitter
          target=Blank
          className={cx([Css.footerIconLink, Css.footerTwitterIcon])}>
          <TwitterIcon size=SM color=Faded />
        </A.Box>
        <A.Box
          href=Route.github target=Blank className={cx([Css.footerIconLink, Css.footerGithubIcon])}>
          <GithubIcon size=SM color=Faded />
        </A.Box>
        <A.Box
          href=Route.instagram
          target=Blank
          className={cx([Css.footerIconLink, Css.footerInstagramIcon])}>
          <InstagramIcon size=SM color=Faded />
        </A.Box>
      </div>
      <ThemeSwitch className=Css.themeSwitchFooter />
    </div>
  </div>
}

module PrimarySidenote = {
  @react.component
  let make = (~className="", ~children) =>
    <span className={cx([Css.sidenote, Css.primarySidenote, className])}> children </span>
}

module SecondarySidenote = {
  @react.component
  let make = (~className="", ~children) =>
    <span className={cx([Css.sidenote, Css.secondarySidenote, className])}> children </span>
}
