module Link = {
  @module("next/link") @react.component
  external make: (
    ~href: string,
    ~_as: string=?,
    ~prefetch: bool=?,
    ~replace: option<bool>=?,
    ~shallow: option<bool>=?,
    ~passHref: option<bool>=?,
    ~children: React.element,
  ) => React.element = "default"
}

module Router = {
  module Events = {
    type t

    @send
    external on: (
      t,
      @string
      [
        | #routeChangeStart(string => unit)
        | #routeChangeComplete(string => unit)
        | #hashChangeComplete(string => unit)
      ],
    ) => unit = "on"

    @send
    external off: (
      t,
      @string
      [
        | #routeChangeStart(string => unit)
        | #routeChangeComplete(string => unit)
        | #hashChangeComplete(string => unit)
      ],
    ) => unit = "off"
  }

  type t = {
    route: string,
    asPath: string,
    events: Events.t,
    pathname: string,
    query: Js.Dict.t<string>,
  }

  type path = {
    pathname: string,
    query: Js.Dict.t<string>,
  }

  @module("next/router") external useRouter: unit => t = "useRouter"

  @send external push: (t, string) => unit = "push"
  @send external pushObj: (t, path) => unit = "push"

  @send external replace: (t, string) => unit = "replace"
  @send external replaceObj: (t, path) => unit = "replace"
}

module Head = {
  @module("next/head") @react.component
  external make: (~children: React.element) => React.element = "default"
}

module Dynamic = {
  @deriving(abstract)
  type options = {
    @optional
    ssr: bool,
    @optional
    loading: unit => React.element,
  }

  @module("next/dynamic")
  external dynamic: (unit => Promise.t<'a>, options) => 'a = "default"

  // HACK: JS module needs to be wrapped to be able to render it via ReScript JSX
  let fromJs = (x: 'a): 'a => {"make": x}->Obj.magic
}

module GetStaticProps = {
  type rec t<'props, 'params, 'previewData> = context<'props, 'params, 'previewData> => Promise.t<
    return<'props>,
  >

  and context<'props, 'params, 'previewData> = {
    params: 'params,
    preview: option<bool>,
    previewData: Js.Nullable.t<'previewData>,
  }

  and return<'props> = {props: 'props}
}

module GetStaticPaths = {
  type rec t<'params> = unit => Promise.t<return<'params>>

  and path<'params> = {params: 'params}

  and return<'params> = {
    paths: array<path<'params>>,
    fallback: bool,
  }
}
