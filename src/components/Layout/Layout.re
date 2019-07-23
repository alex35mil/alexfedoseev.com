module Css = LayoutStyles;

[@react.component]
let make = (~route: Route.inner, ~children) => {
  <div className=Css.container>
    <div className=Css.header>
      <div className=Css.logo>
        <Link path=Route.main underline=Never className=Css.logoLink>
          "Alex Fedoseev"->React.string
        </Link>
      </div>
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
    </div>
    children
    <div className=Css.footer>
      <div className=Css.footerSources>
        <A
          href=Route.src
          target=Blank
          underline=WhenInteracted
          className=Css.footerSourcesLink>
          <SrcIcon size=SM color=Gray />
          <span className=Css.footerText> "src"->React.string </span>
        </A>
      </div>
      <div className=Css.footerMainCol>
        <div className=Css.footerCopy>
          <span className=Css.footerText> {j|©|j}->React.string </span>
          <img
            src=[%bs.raw "require('meta/sign.png')"]
            className=Css.copySignature
          />
          <span className=Css.footerText>
            {
              let start =
                Posts.byYear
                ->Array.getUnsafe(Posts.byYear->Array.length - 1)
                ->fst;
              let current = Js.Date.(make()->getFullYear)->Float.toString;

              {j|$(start)—$(current)|j}->React.string;
            }
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
            <TwitterIcon size=SM color=Gray />
          </A.Box>
          <A.Box
            href=Route.github
            target=Blank
            className={Cn.make([Css.footerIconLink, Css.footerGithubIcon])}>
            <GithubIcon size=SM color=Gray />
          </A.Box>
          <A.Box
            href=Route.instagram
            target=Blank
            className={Cn.make([Css.footerIconLink, Css.footerInstagramIcon])}>
            <InstagramIcon size=SM color=Gray />
          </A.Box>
          <A.Box
            href=Route.facebook
            target=Blank
            className={Cn.make([Css.footerIconLink, Css.footerFacebookIcon])}>
            <FacebookIcon size=SM color=Gray />
          </A.Box>
          <A.Box
            href=Route.linkedin
            target=Blank
            className={Cn.make([Css.footerIconLink, Css.footerLinkedInIcon])}>
            <LinkedInIcon size=SM color=Gray />
          </A.Box>
        </div>
      </div>
    </div>
  </div>;
};

module Sidenote = {
  [@react.component]
  let make = (~children) => {
    <div className=Css.sidenote> children </div>;
  };
};
