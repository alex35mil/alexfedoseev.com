module Css = MainPageStyles;

[@react.component]
let make = () => {
  <Page>
    <div className=Css.container>
      <div className=Css.photo />
      <div className=Css.line />
      <div className=Css.headline>
        <div className=Css.name> "Alex Fedoseev"->React.string </div>
        <div className=Css.links>
          <div className=Css.nav>
            <Link path=Route.blog className=Css.link>
              "blog"->React.string
            </Link>
            <Link path=Route.photo className=Css.link>
              "photo"->React.string
            </Link>
            <Link path=Route.me className=Css.link> "me"->React.string </Link>
          </div>
          <div className=Css.diagonal />
          <div className=Css.social>
            <Anchor href=Route.twitter target=Blank className=Css.icon>
              <TwitterIcon size=SM color=Gray />
            </Anchor>
            <Anchor href=Route.github target=Blank className=Css.icon>
              <GithubIcon size=SM color=Gray />
            </Anchor>
            <Anchor href=Route.instagram target=Blank className=Css.icon>
              <InstagramIcon size=SM color=Gray />
            </Anchor>
          </div>
        </div>
      </div>
    </div>
  </Page>;
};
