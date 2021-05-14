type error = [
  | #404
  | #500
]

module Css = ErrorPageStyles

let metaImage: Image.basic = %raw("require('images/meta.png?preset=basic')")

@react.component
let default = (~error: error) => {
  <>
    {
      let error = switch error {
      | #404 => "Not Found"
      | #500 => "Error"
      }
      <Head
        htmlTitle={Suffixed(error)}
        socialTitle={Prefixed(error)}
        description=Default
        image=metaImage.src
        ogType=#website
      />
    }
    <div className=Css.container>
      <div className=Css.fourOFour>
        {switch error {
        | #404 => "404"->React.string
        | #500 => "Oops"->React.string
        }}
      </div>
      <div className=Css.line />
      <div className=Css.texts>
        <div className=Css.notFound>
          {switch error {
          | #404 => "This page could not be found"->React.string
          | #500 => "Something went wrong"->React.string
          }}
        </div>
        <Link path=Route.main underline=Always> {"Back to main"->React.string} </Link>
      </div>
    </div>
  </>
}
