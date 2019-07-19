open ReactRouter;

type t =
  | Main
  | Blog
  | Post(string);

let main = "/"->Path.pack;
let blog = "/blog"->Path.pack;
let post = (~slug: string) => {j|/blog/$slug|j}->Path.pack;

let fromUrl = (url: ReactRouter.url) =>
  switch (url.path) {
  | [] => Main->Some
  | ["blog"] => Blog->Some
  | ["blog", slug] => Post(slug)->Some
  | _ => None
  };
