module Css = PostStyles;

[@react.component]
let make = (~title, ~year, ~date, ~children) => {
  <Page>
    <div className=Css.container>
      <div className=Css.title>
        <Layout.Sidenote>
          {j|$(date), $(year)|j}->React.string
        </Layout.Sidenote>
        <Markdown.H1> title->React.string </Markdown.H1>
      </div>
      <div className=Css.post> <div /> <Markdown> children </Markdown> </div>
    </div>
  </Page>;
};
