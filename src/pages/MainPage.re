module Css = MainPageStyles;

[@react.component]
let make = () => {
  <Page>
    <div className=Css.main>
      <div> "Main"->React.string </div>
      <div> <Link path=Route.blog> "To Blog"->React.string </Link> </div>
    </div>
  </Page>;
};
