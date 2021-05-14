type t

module Language = {
  type t

  @module("prismjs") external languages: Js.Dict.t<t> = "languages"
  let get = lang => languages->Js.Dict.unsafeGet(lang)
}

@module("prismjs")
external highlight: (string, Language.t, string) => string = "highlight"
