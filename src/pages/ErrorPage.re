module Css = ErrorPageStyles;

type error =
  | NotFound
  | Unknown;

[@react.component]
let make = (~error: error) => {
  <Page>
    <div className=Css.container>
      <div className=Css.fourOFour>
        {switch (error) {
         | NotFound => "404"->React.string
         | Unknown => "Oops"->React.string
         }}
      </div>
      <div className=Css.line />
      <div className=Css.texts>
        <div className=Css.notFound>
          {switch (error) {
           | NotFound => "Not Found"->React.string
           | Unknown => "Something went wrong"->React.string
           }}
        </div>
        <Link path=Route.main underline=Always>
          "Back to main"->React.string
        </Link>
      </div>
    </div>
  </Page>;
};
