module Css = PostStyles;

[@react.component]
let make = (~children) => {
  <Page>
    <div className=Css.post>
      <Markdown> children </Markdown>
      <TextLink path=Route.blog> "Back to blog"->React.string </TextLink>
    </div>
  </Page>;
};
