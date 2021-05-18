module Css = MePageStyles

@module("images/meta-profile.png?preset=basic") external metaImage: Image.basic = "default"

@react.component
let default = () => {
  <>
    <Head
      htmlTitle=Suffixed("Profile")
      socialTitle=Prefixed("Profile")
      description=Default
      image=metaImage.src
      ogType=#profile
    />
    <div className=Css.container>
      <div className=Css.about>
        <div />
        <div className=Css.aboutContent>
          <h1 className=Css.title> {"Hi!"->React.string} </h1>
          <p>
            {"I'm Alex, a full-stack developer interested in user experience, product development, statically typed languages and functional programming."->React.string}
          </p>
          <p>
            {"My previous background includes project management, digital marketing and web analytics."->React.string}
          </p>
          <p>
            {"In my free time, I enjoy "->React.string}
            <Link path=Route.photo underline=Always> {"photography"->React.string} </Link>
            {"."->React.string}
          </p>
        </div>
      </div>
      <div className=Css.row>
        <Layout.PrimarySidenote className=Css.rowLabel>
          {"Tech Stack"->React.string}
        </Layout.PrimarySidenote>
        <div className=Css.content>
          <p>
            {"I use "->React.string}
            <span className=Css.stackItem> {"ReScript"->React.string} </span>
            {" / "->React.string}
            <span className=Css.stackItem> {"OCaml"->React.string} </span>
            {" for making web clients. "->React.string}
            <span className=Css.stackItem> {"Rust"->React.string} </span>
            {" for everything on a server, as well as for DevOps/infrastructure needs. And "->React.string}
            <span className=Css.stackItem> {"Swift"->React.string} </span>
            {" for macOS/iOS apps."->React.string}
          </p>
          <p>
            {"My go-to database is "->React.string}
            <span className=Css.stackItem> {"PostgreSQL"->React.string} </span>
            {". Also, I have experience with "->React.string}
            <span className=Css.stackItem> {"CouchDB"->React.string} </span>
            {"."->React.string}
          </p>
          <p>
            {"I deploy using "->React.string}
            <span className=Css.stackItem> {"Docker"->React.string} </span>
            {", "->React.string}
            <span className=Css.stackItem> {"Kubernetes"->React.string} </span>
            {" & "->React.string}
            <span className=Css.stackItem> {"AWS Fargate"->React.string} </span>
            {"."->React.string}
          </p>
          <p>
            {"A long time ago, I had a backend written in "->React.string}
            <span className=Css.stackItem> {"Go"->React.string} </span>
            {", but due to it being unsafe in the context of GraphQL, I dropped it for Rust."->React.string}
          </p>
          <p>
            {"In the beginning, I did "->React.string}
            <span className=Css.stackItem> {"Ruby"->React.string} </span>
            {" (a little) and "->React.string}
            <span className=Css.stackItem> {"JavaScript"->React.string} </span>
            {" (a lot). But not anymore."->React.string}
          </p>
        </div>
      </div>
      <div className=Css.row>
        <Layout.PrimarySidenote className=Css.rowLabel>
          {"Projects"->React.string}
        </Layout.PrimarySidenote>
        <div className=Css.content>
          <div className=Css.contentBlock>
            <div className=Css.contentSubheading>
              <A href=Route.minima target=Blank underline=Always> {"Minima"->React.string} </A>
            </div>
            <div> {"Project management app based on GTD methodology."->React.string} </div>
          </div>
          <div className=Css.contentBlock>
            <div className=Css.contentSubheading>
              <A href=Route.sherry target=Blank underline=Always> {"Sherry"->React.string} </A>
            </div>
            <div>
              {"A menubar app for macOS that simplifies file sharing via AWS S3."->React.string}
            </div>
          </div>
        </div>
      </div>
      <div className=Css.row>
        <Layout.PrimarySidenote className=Css.rowLabel>
          {"Open Source"->React.string}
        </Layout.PrimarySidenote>
        <div className=Css.content>
          <div className=Css.contentBlock>
            <div className=Css.contentSubheading>
              <A href=Route.reFormality target=Blank underline=Always>
                {"re-formality"->React.string}
              </A>
            </div>
            <div> {"Forms management for ReScript."->React.string} </div>
          </div>
          <div className=Css.contentBlock>
            <div className=Css.contentSubheading>
              <A href=Route.reDnd target=Blank underline=Always> {"re-dnd"->React.string} </A>
            </div>
            <div> {"Drag'n'Drop solution for ReScript."->React.string} </div>
          </div>
          <div className=Css.contentBlock>
            <div className=Css.contentSubheading>
              <A href=Route.reCss target=Blank underline=Always> {"re-css"->React.string} </A>
            </div>
            <div> {"Typed CSS spec for ReScript."->React.string} </div>
          </div>
          <div className=Css.contentBlock>
            <div className=Css.contentSubheading>
              <A href=Route.rescriptClassnames target=Blank underline=Always>
                {"rescript-classnames"->React.string}
              </A>
            </div>
            <div> {"Classnames utility for ReScript."->React.string} </div>
          </div>
          <div className=Css.contentBlock>
            <div className=Css.contentSubheading>
              <A href=Route.rescriptDebouncer target=Blank underline=Always>
                {"rescript-debouncer"->React.string}
              </A>
            </div>
            <div> {"Debouncer for ReScript."->React.string} </div>
          </div>
          <div className=Css.contentBlock>
            <div className=Css.contentSubheading>
              <A href=Route.rescriptLogger target=Blank underline=Always>
                {"rescript-logger"->React.string}
              </A>
            </div>
            <div> {"Logging solution for ReScript."->React.string} </div>
          </div>
          <div className=Css.contentBlock>
            <div className=Css.contentSubheading>
              <A href=Route.steward target=Blank underline=Always> {"steward"->React.string} </A>
            </div>
            <div> {"Task runner and process manager for Rust."->React.string} </div>
          </div>
          <div className=Css.contentBlock>
            <div className=Css.contentSubheading>
              <A href=Route.conform target=Blank underline=Always> {"conform"->React.string} </A>
            </div>
            <div> {"Rust macro for transforming strings inside structs."->React.string} </div>
          </div>
        </div>
      </div>
      <div className=Css.row>
        <Layout.PrimarySidenote className=Css.rowLabel>
          {"Links"->React.string}
        </Layout.PrimarySidenote>
        <div className=Css.links>
          <div className=Css.linkRow>
            <A
              href=Route.github
              target=Blank
              underline=WhenInteracted
              className={cx([Css.link, Css.githubLink])}>
              <GithubIcon size=SM color=Faded className=Css.linkIcon /> {"Github"->React.string}
            </A>
          </div>
          <div className=Css.linkRow>
            <A
              href=Route.twitter
              target=Blank
              underline=WhenInteracted
              className={cx([Css.link, Css.twitterLink])}>
              <TwitterIcon size=SM color=Faded className=Css.linkIcon /> {"Twitter"->React.string}
            </A>
          </div>
        </div>
      </div>
    </div>
  </>
}
