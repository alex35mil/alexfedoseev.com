open ReactRouter;

type t =
  | Main
  | Inner(inner)
and inner =
  | Blog([ | `Index | `Post(string)])
  | Photo
  | Me;

let main = "/"->Path.pack;
let blog = "/blog"->Path.pack;
let post = (~slug: string) => {j|/blog/$slug|j}->Path.pack;
let photo = "/photo"->Path.pack;
let me = "/me"->Path.pack;

let twitter = "https://twitter.com/alexfedoseev"->Path.pack;
let github = "https://github.com/alexfedoseev"->Path.pack;
let instagram = "https://instagram.com/alex_kiddo"->Path.pack;
let facebook = "https://www.facebook.com/alex.fedoseev"->Path.pack;
let linkedin = "https://www.linkedin.com/in/alexfedoseev"->Path.pack;

let src = "https://github.com/alexfedoseev/alexfedoseev.com"->Path.pack;

let minima = "https://minima.app"->Path.pack;

let reFormality = "https://github.com/minima-app/re-formality"->Path.pack;
let reDnd = "https://github.com/minima-app/re-dnd"->Path.pack;
let reCss = "https://github.com/minima-app/re-css"->Path.pack;
let reClassnames = "https://github.com/minima-app/re-classnames"->Path.pack;
let reDebouncer = "https://github.com/minima-app/re-debouncer"->Path.pack;
let bsLog = "https://github.com/minima-app/bs-log"->Path.pack;
let conform = "https://github.com/minima-app/conform"->Path.pack;

let fromUrl = (url: ReactRouter.url) =>
  switch (url.path) {
  | [] => Main->Some
  | ["blog"] => Inner(Blog(`Index))->Some
  | ["blog", slug] => Inner(Blog(`Post(slug)))->Some
  | ["photo"] => Inner(Photo)->Some
  | ["me"] => Inner(Me)->Some
  | _ => None
  };
