type prism
type theme
type token
type line = array<token>

@module("prismjs") external prism: prism = "default"

module Token = {
  @get external content: token => string = "content"
}

module Highlight = {
  type linePropsArgs = {line: line, key: int}
  type tokenPropsArgs = {token: token, key: int}
  type lineProps = {className: string}
  type tokenProps = {
    className: string,
    children: React.element, // which is a string
  }

  type data = {
    className: string,
    style: ReactDOM.Style.t,
    tokens: array<line>,
    getLineProps: linePropsArgs => lineProps,
    getTokenProps: tokenPropsArgs => tokenProps,
  }

  module PrismReactRenderer = {
    @deriving(abstract)
    type props = {
      code: string,
      language: string,
      @as("Prism") prism: prism,
      // theme: theme,
      children: data => React.element,
    }

    let makeProps = (
      ~code: string,
      ~language: string,
      ~prism: prism,
      // ~theme: theme,
      ~children: data => React.element,
      _,
    ) =>
      props(
        ~code: string,
        ~language: string,
        ~prism: prism,
        // ~theme: theme,
        ~children: data => React.element,
      )

    @module("prism-react-renderer")
    external make: React.component<props> = "default"
  }

  @react.component
  let make = (~code: string, ~language: string, ~children: data => React.element) => {
    <PrismReactRenderer code language prism> {children} </PrismReactRenderer>
  }
}
