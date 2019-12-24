module Css = LayoutStyles;

[@bs.module "styles/Layout.js"]
external largeScreenContentWidth: int = "largeScreenContentWidth";

[@bs.module "styles/Layout.js"]
external smallScreenHPad: int = "smallScreenHPad";

[@react.component]
let make = (~route: Route.inner, ~children) => {
  let {Theme.current: theme} = React.useContext(Theme.Context.x);

  // Make click outside work in Safari on iOS
  <div className=Css.container onClick=ignore>
    <div className=Css.header>
      <div className=Css.logo>
        <Link.Box path=Route.main className=Css.logoLink>
          <Logo className=Css.logoSvg />
        </Link.Box>
      </div>
      <div className=Css.mainCol>
        <div className=Css.navigation>
          {switch (route) {
           | Blog(_) =>
             <Link.Box
               path=Route.blog
               className={Cn.make([Css.navLink, Css.navLinkActive])}>
               "blog"->React.string
             </Link.Box>
           | Photo =>
             <Link.Box
               path=Route.photo
               className={Cn.make([Css.navLink, Css.navLinkActive])}>
               "photo"->React.string
             </Link.Box>
           | Me =>
             <Link.Box
               path=Route.me
               className={Cn.make([Css.navLink, Css.navLinkActive])}>
               "me"->React.string
             </Link.Box>
           }}
          <div className=Css.navSep />
          <div className=Css.restNavLinks>
            {switch (route) {
             | Blog(_) => React.null
             | _ =>
               <Link.Box
                 path=Route.blog
                 className={Cn.make([Css.navLink, Css.navLinkInactive])}>
                 "blog"->React.string
               </Link.Box>
             }}
            {switch (route) {
             | Photo => React.null
             | _ =>
               <Link.Box
                 path=Route.photo
                 className={Cn.make([Css.navLink, Css.navLinkInactive])}>
                 "photo"->React.string
               </Link.Box>
             }}
            {switch (route) {
             | Me => React.null
             | _ =>
               <Link.Box
                 path=Route.me
                 className={Cn.make([Css.navLink, Css.navLinkInactive])}>
                 "me"->React.string
               </Link.Box>
             }}
          </div>
        </div>
        <ThemeSwitch className=Css.themeSwitchHeader />
      </div>
    </div>
    children
    <div className=Css.footer>
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
      <div className=Css.footerMainCol>
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
          <Link
            path=Route.me underline=WhenInteracted className=Css.footerText>
            "Me"->React.string
          </Link>
        </div>
        <div className=Css.footerIcons>
          <A.Box
            href=Route.twitter
            target=Blank
            className={Cn.make([Css.footerIconLink, Css.footerTwitterIcon])}>
            <TwitterIcon size=SM color=Faded />
          </A.Box>
          <A.Box
            href=Route.github
            target=Blank
            className={Cn.make([Css.footerIconLink, Css.footerGithubIcon])}>
            <GithubIcon size=SM color=Faded />
          </A.Box>
          <A.Box
            href=Route.instagram
            target=Blank
            className={Cn.make([Css.footerIconLink, Css.footerInstagramIcon])}>
            <InstagramIcon size=SM color=Faded />
          </A.Box>
          <A.Box
            href=Route.facebook
            target=Blank
            className={Cn.make([Css.footerIconLink, Css.footerFacebookIcon])}>
            <FacebookIcon size=SM color=Faded />
          </A.Box>
          <A.Box
            href=Route.linkedin
            target=Blank
            className={Cn.make([Css.footerIconLink, Css.footerLinkedInIcon])}>
            <LinkedInIcon size=SM color=Faded />
          </A.Box>
        </div>
        <ThemeSwitch className=Css.themeSwitchFooter />
      </div>
    </div>
  </div>;
};

module PrimarySidenote = {
  [@react.component]
  let make = (~className="", ~children) => {
    <span className={Cn.make([Css.sidenote, Css.primarySidenote, className])}>
      children
    </span>;
  };
};

module SecondarySidenote = {
  [@react.component]
  let make = (~children) => {
    <span className={Cn.make([Css.sidenote, Css.secondarySidenote])}>
      children
    </span>;
  };
};
