type t;

module Language = {
  type t;

  [@bs.module "prismjs"] external languages: Js.Dict.t(t) = "languages";
  let get = lang => languages->Js.Dict.unsafeGet(lang);
};

[@bs.module "prismjs"]
external highlight: (string, Language.t, string) => string = "highlight";
