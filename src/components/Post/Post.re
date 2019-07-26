module Css = PostStyles;

[@react.component]
let make = (~title, ~year, ~date, ~children) => {
  <Page>
    <div className=Css.container>
      <div className=Css.title>
        <div className=Css.date>
          <Layout.PrimarySidenote>
            {j|$(date), $(year)|j}->React.string
          </Layout.PrimarySidenote>
        </div>
        <Markdown.H1> title->React.string </Markdown.H1>
      </div>
      <div className=Css.content> children </div>
    </div>
  </Page>;
};
