type t =
  | Main
  | Blog
  | Post(string);

let main = "/";
let blog = "/blog";
let post = (~slug) => {j|/blog/$slug|j};

let fromUrl = (url: ReactRouter.url) =>
  switch (url.path) {
  | [] => Main->Some
  | ["blog"] => Blog->Some
  | ["blog", slug] => Post(slug)->Some
  | _ => None
  };
