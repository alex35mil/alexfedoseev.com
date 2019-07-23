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

let fromUrl = (url: ReactRouter.url) =>
  switch (url.path) {
  | [] => Main->Some
  | ["blog"] => Inner(Blog(`Index))->Some
  | ["blog", slug] => Inner(Blog(`Post(slug)))->Some
  | ["photo"] => Inner(Photo)->Some
  | ["me"] => Inner(Me)->Some
  | _ => None
  };
