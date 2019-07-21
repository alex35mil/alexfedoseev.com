open ReactRouter;

type t =
  | Main
  | Blog
  | Post(string)
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

let fromUrl = (url: ReactRouter.url) =>
  switch (url.path) {
  | [] => Main->Some
  | ["blog"] => Blog->Some
  | ["blog", slug] => Post(slug)->Some
  | ["photo"] => Photo->Some
  | ["me"] => Me->Some
  | _ => None
  };
