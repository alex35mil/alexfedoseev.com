open ReactRouter;

type t =
  | Main
  | Inner(inner)
and inner =
  | Blog(blog)
  | Photo
  | Me
and blog =
  | Index
  | Post({
      year: string,
      slug: string,
    });

let main = "/"->Path.pack;
let blog = "/blog"->Path.pack;
let post = (~year: string, ~slug: string) =>
  {j|/blog/$year/$slug|j}->Path.pack;
let photo = "/photo"->Path.pack;
let me = "/me"->Path.pack;

let twitter = "https://twitter.com/AlexFedoseev"->Path.pack;
let github = "https://github.com/AlexFedoseev"->Path.pack;
let instagram = "https://instagram.com/AlexFedoseevPhoto"->Path.pack;
let facebook = "https://www.facebook.com/Alex.Fedoseev"->Path.pack;
let linkedin = "https://www.linkedin.com/in/AlexFedoseev"->Path.pack;

let src = "https://github.com/alexfedoseev/alexfedoseev.com"->Path.pack;

let minima = "https://minima.app"->Path.pack;

let reFormality = "https://github.com/MinimaHQ/re-formality"->Path.pack;
let reDnd = "https://github.com/MinimaHQ/re-dnd"->Path.pack;
let reCss = "https://github.com/MinimaHQ/re-css"->Path.pack;
let reClassnames = "https://github.com/MinimaHQ/re-classnames"->Path.pack;
let reDebouncer = "https://github.com/MinimaHQ/re-debouncer"->Path.pack;
let bsLog = "https://github.com/MinimaHQ/bs-log"->Path.pack;
let conform = "https://github.com/MinimaHQ/conform"->Path.pack;

let fromUrl = (url: ReactRouter.url) =>
  switch (url.path) {
  | [] => Main->Some
  | ["blog"] => Inner(Blog(Index))->Some
  | ["blog", year, slug] => Inner(Blog(Post({year, slug})))->Some
  | ["photo"] => Inner(Photo)->Some
  | ["me"] => Inner(Me)->Some
  | _ => None
  };
