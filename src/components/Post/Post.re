module Css = PostStyles;

[@react.component]
let make = (~children) => {
  <Page>
    <div className=Css.post>
      <Markdown> children </Markdown>
      <ReactRouter.Link path=Route.blog>
        "Back to blog"->React.string
      </ReactRouter.Link>
    </div>
  </Page>;
};
