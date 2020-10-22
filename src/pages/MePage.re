module Css = MePageStyles;

module OssProject = {
  [@react.component]
  let make = (~name, ~link, ~description) => {
    <div className=Css.ossProject>
      <A href=link target=Blank underline=Always> name->React.string </A>
      <span className=Css.ossProjectColon> ":"->React.string </span>
      <span className=Css.ossProjectDescription>
        description->React.string
      </span>
    </div>;
  };
};

[@react.component]
let make = () =>
  <Page>
    <div className=Css.container>
      <div className=Css.about>
        <div />
        <div className=Css.aboutContent>
          <h1 className=Css.title> "Hi!"->React.string </h1>
          <p>
            "I'm Alex, a full-stack developer interested in user experience, product development, statically typed languages and functional programming."
            ->React.string
          </p>
          <p>
            "My previous background includes project management, digital marketing and web analytics."
            ->React.string
          </p>
          <p>
            "In my free time, I enjoy "->React.string
            <Link path=Route.photo underline=Always>
              "photography"->React.string
            </Link>
            "."->React.string
          </p>
        </div>
      </div>
      <div className=Css.row>
        <Layout.PrimarySidenote className=Css.rowLabel>
          "Tech Stack"->React.string
        </Layout.PrimarySidenote>
        <div className=Css.content>
          <p>
            "I use "->React.string
            <span className=Css.stackItem> "ReasonML"->React.string </span>
            " / "->React.string
            <span className=Css.stackItem> "OCaml"->React.string </span>
            " for making web clients. "->React.string
            <span className=Css.stackItem> "Rust"->React.string </span>
            " for everything on a server, as well as for DevOps/infrastructure needs. And "
            ->React.string
            <span className=Css.stackItem> "Swift"->React.string </span>
            " for macOS/iOS apps."->React.string
          </p>
          <p>
            "My go-to database is "->React.string
            <span className=Css.stackItem> "PostgreSQL"->React.string </span>
            ". Also, I have experience with "->React.string
            <span className=Css.stackItem> "CouchDB"->React.string </span>
            "."->React.string
          </p>
          <p>
            "I deploy using "->React.string
            <span className=Css.stackItem> "Docker"->React.string </span>
            ", "->React.string
            <span className=Css.stackItem> "Kubernetes"->React.string </span>
            " & "->React.string
            <span className=Css.stackItem> "AWS Fargate"->React.string </span>
            "."->React.string
          </p>
          <p>
            "A long time ago, I had a backend written in "->React.string
            <span className=Css.stackItem> "Go"->React.string </span>
            ", but due to it being unsafe in the context of GraphQL, I dropped it for Rust."
            ->React.string
          </p>
          <p>
            "In the beginning, I did "->React.string
            <span className=Css.stackItem> "Ruby"->React.string </span>
            " (a little) and "->React.string
            <span className=Css.stackItem> "JavaScript"->React.string </span>
            " (a lot). But not anymore."->React.string
          </p>
        </div>
      </div>
      <div className=Css.row>
        <Layout.PrimarySidenote className=Css.rowLabel>
          "Projects"->React.string
        </Layout.PrimarySidenote>
        <div className=Css.content>
          <div className=Css.contentBlock>
            <div className=Css.contentSubheading>
              <A href=Route.minima target=Blank underline=Always>
                "Minima"->React.string
              </A>
            </div>
            <div>
              "Project management app based on GTD methodology."->React.string
            </div>
          </div>
          <div className=Css.contentBlock>
            <div className=Css.contentSubheading>
              <A href=Route.sherry target=Blank underline=Always>
                "Sherry"->React.string
              </A>
            </div>
            <div>
              "A menubar app for macOS that simplifies file sharing via AWS S3."
              ->React.string
            </div>
          </div>
        </div>
      </div>
      <div className=Css.row>
        <Layout.PrimarySidenote className=Css.rowLabel>
          "Open Source"->React.string
        </Layout.PrimarySidenote>
        <div className=Css.content>
          <div className=Css.ossProjects>
            <OssProject
              name="re-formality"
              link=Route.reFormality
              description="Forms management for ReasonML"
            />
            <OssProject
              name="re-dnd"
              link=Route.reDnd
              description="Drag'n'Drop solution for ReasonML"
            />
            <OssProject
              name="re-css"
              link=Route.reCss
              description="Typed CSS spec for ReasonML"
            />
            <OssProject
              name="re-classnames"
              link=Route.reClassnames
              description="Classnames utility for ReasonML"
            />
            <OssProject
              name="re-debouncer"
              link=Route.reDebouncer
              description="Debouncer for ReasonML"
            />
            <OssProject
              name="bs-log"
              link=Route.bsLog
              description="Logging solution for ReasonML"
            />
            <OssProject
              name="conform"
              link=Route.conform
              description="Rust macro for transforming strings inside structs"
            />
          </div>
        </div>
      </div>
      <div className=Css.row>
        <Layout.PrimarySidenote className=Css.rowLabel>
          "Links"->React.string
        </Layout.PrimarySidenote>
        <div className=Css.links>
          <div className=Css.linkRow>
            <A
              href=Route.github
              target=Blank
              underline=WhenInteracted
              className=Cn.(Css.link + Css.githubLink)>
              <GithubIcon size=SM color=Faded className=Css.linkIcon />
              "Github"->React.string
            </A>
          </div>
          <div className=Css.linkRow>
            <A
              href=Route.twitter
              target=Blank
              underline=WhenInteracted
              className=Cn.(Css.link + Css.twitterLink)>
              <TwitterIcon size=SM color=Faded className=Css.linkIcon />
              "Twitter"->React.string
            </A>
          </div>
        </div>
      </div>
    </div>
  </Page>;
