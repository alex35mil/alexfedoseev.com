module Css = LayoutStyles;

[@bs.module "styles/Layout.js"]
external largeScreenContentWidth: int = "largeScreenContentWidth";

[@bs.module "styles/Layout.js"]
external smallScreenHPad: int = "smallScreenHPad";

[@react.component]
let make = (~route: Route.inner, ~children) => {
  let {Theme.current: theme} = React.useContext(Theme.Context.x);

  let blurOnClick =
    React.useCallback0(event => event->ReactEvent.Mouse.target##blur());

  // Make click outside work in Safari on iOS
  <div className=Css.container onClick=ignore>
    <div className=Css.header>
      <div className=Css.logo>
        <Link.Box path=Route.main className=Css.logoLink>
          <Logo className=Css.logoSvg />
        </Link.Box>
      </div>
      <div className=Css.navigation>
        <Link.Box
          path=Route.blog
          className=Cn.(
            Css.navLink
            + (
              switch (route) {
              | Blog(_) => Css.navLinkActive
              | Photo
              | Me => Css.navLinkInactive
              }
            )
          )
          onClick=blurOnClick>
          "blog"->React.string
        </Link.Box>
        <Link.Box
          path=Route.photo
          className=Cn.(
            Css.navLink
            + (
              switch (route) {
              | Photo => Css.navLinkActive
              | Blog(_)
              | Me => Css.navLinkInactive
              }
            )
          )
          onClick=blurOnClick>
          "photo"->React.string
        </Link.Box>
        <Link.Box
          path=Route.me
          className=Cn.(
            Css.navLink
            + (
              switch (route) {
              | Me => Css.navLinkActive
              | Blog(_)
              | Photo => Css.navLinkInactive
              }
            )
          )
          onClick=blurOnClick>
          "me"->React.string
        </Link.Box>
      </div>
      <ThemeSwitch className=Css.themeSwitchHeader />
    </div>
    children
    <div className=Css.footer>
      <div className=Css.footerNav>
        <Link
          path=Route.main underline=WhenInteracted className=Css.footerText>
          "Home"->React.string
        </Link>
        <Link
          path=Route.blog underline=WhenInteracted className=Css.footerText>
          "Blog"->React.string
        </Link>
        <Link
          path=Route.photo underline=WhenInteracted className=Css.footerText>
          "Photo"->React.string
        </Link>
        <Link path=Route.me underline=WhenInteracted className=Css.footerText>
          "Me"->React.string
        </Link>
      </div>
      <div className=Css.footerCopy>
        <span className=Css.footerText> {j|©|j}->React.string </span>
        {switch (theme) {
         | Light =>
           <img
             src=[%bs.raw "require('meta/sign-light.png')"]
             className=Css.copySignature
           />
         | Dark =>
           <img
             src=[%bs.raw "require('meta/sign-dark.png')"]
             className=Css.copySignature
           />
         }}
        <span className=Css.footerText>
          {let start =
             Posts.all->Array.getUnsafe(Posts.all->Array.length - 1).year;
           let current = Js.Date.(make()->getFullYear)->Float.toString;

           {j|$(start)—$(current)|j}->React.string}
        </span>
      </div>
      <div className=Css.footerSources>
        <A
          href=Route.src
          target=Blank
          underline=WhenInteracted
          className=Css.footerSourcesLink>
          <CodeIcon size=SM color=Faded />
          <span className=Css.footerText> "src"->React.string </span>
        </A>
      </div>
      <div className=Css.footerIcons>
        <A.Box
          href=Route.twitter
          target=Blank
          className=Cn.(Css.footerIconLink + Css.footerTwitterIcon)>
          <TwitterIcon size=SM color=Faded />
        </A.Box>
        <A.Box
          href=Route.github
          target=Blank
          className=Cn.(Css.footerIconLink + Css.footerGithubIcon)>
          <GithubIcon size=SM color=Faded />
        </A.Box>
      </div>
      <ThemeSwitch className=Css.themeSwitchFooter />
    </div>
  </div>;
};

module PrimarySidenote = {
  [@react.component]
  let make = (~className="", ~children) => {
    <span className=Cn.(Css.sidenote + Css.primarySidenote + className)>
      children
    </span>;
  };
};

module SecondarySidenote = {
  [@react.component]
  let make = (~className="", ~children) => {
    <span className=Cn.(Css.sidenote + Css.secondarySidenote + className)>
      children
    </span>;
  };
};
