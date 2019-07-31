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
        <div className=Css.photo />
        <div className=Css.aboutContent>
          <p>
            "Hi, I'm Alex, a full-stack developer interested in user experience, product development, statically typed languages and functional programming."
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
          "Stack"->React.string
        </Layout.PrimarySidenote>
        <div className=Css.content>
          <div className=Css.contentBlock>
            <div className=Css.contentSubheading>
              "Languages"->React.string
            </div>
            <ul className=Css.ul>
              <li> "ReasonML / OCaml"->React.string </li>
              <li> "Rust"->React.string </li>
              <li> "Go"->React.string </li>
              <li className=Css.meh> "JavaScript"->React.string </li>
              <li className=Css.meh> "Ruby"->React.string </li>
            </ul>
          </div>
          <div className=Css.contentBlock>
            <div className=Css.contentSubheading>
              "Technologies"->React.string
            </div>
            <ul className=Css.ul>
              <li> "React"->React.string </li>
              <li className=Css.meh> "Redux"->React.string </li>
              <li> "GraphQL"->React.string </li>
              <li> "Docker"->React.string </li>
              <li> "Kubernetes"->React.string </li>
            </ul>
          </div>
          <div className=Css.note>
            <sup> "*"->React.string </sup>
            " Crossed out items is something I prefer to avoid at this point"
            ->React.string
          </div>
        </div>
      </div>
      <div className=Css.row>
        <Layout.PrimarySidenote className=Css.rowLabel>
          "Products"->React.string
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
        </div>
      </div>
      <div className=Css.row>
        <Layout.PrimarySidenote className=Css.rowLabel>
          "OSS"->React.string
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
              underline=Always
              className={Cn.make([Css.link, Css.githubLink])}>
              <GithubIcon size=SM color=Gray />
              "Github"->React.string
            </A>
          </div>
          <div className=Css.linkRow>
            <A
              href=Route.twitter
              target=Blank
              underline=Always
              className={Cn.make([Css.link, Css.twitterLink])}>
              <TwitterIcon size=SM color=Gray />
              "Twitter"->React.string
            </A>
          </div>
          <div className=Css.linkRow>
            <A
              href=Route.instagram
              target=Blank
              underline=Always
              className={Cn.make([Css.link, Css.instagramLink])}>
              <InstagramIcon size=SM color=Gray />
              "Instagram"->React.string
            </A>
          </div>
          <div className=Css.linkRow>
            <A
              href=Route.facebook
              target=Blank
              underline=Always
              className={Cn.make([Css.link, Css.facebookLink])}>
              <FacebookIcon size=SM color=Gray />
              "Facebook"->React.string
            </A>
          </div>
          <div className=Css.linkRow>
            <A
              href=Route.linkedin
              target=Blank
              underline=Always
              className={Cn.make([Css.link, Css.linkedinLink])}>
              <LinkedInIcon size=SM color=Gray />
              "LinkedIn"->React.string
            </A>
          </div>
        </div>
      </div>
    </div>
  </Page>;
