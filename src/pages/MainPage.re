module Css = MainPageStyles;

[@react.component]
let make = () => {
  <Page>
    <div className=Css.main>
      <div> "Main"->React.string </div>
      <div>
        <ReactRouter.Link path="/blog">
          "To Blog"->React.string
        </ReactRouter.Link>
      </div>
    </div>
  </Page>;
};
