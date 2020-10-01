open ReactRouter;

type t =
  | Main
  | Inner(inner)
and inner =
  | Blog(blog)
  | Photo
  | Me
and blog =
  | Index(blogIndex)
  | Post({
      year: string,
      category: string,
      slug: string,
    })
and blogIndex =
  | All
  | Category(PostCategory.t);

let main = "/"->Path.pack;
let blog = "/blog"->Path.pack;
let blogCategory = (category: PostCategory.t) =>
  ("/blog/" ++ category->PostCategory.toString)->Path.pack;
let post = (~year: string, ~category: string, ~slug: string) =>
  {j|/blog/$category/$year/$slug|j}->Path.pack;
let photo = "/photo"->Path.pack;
let me = "/me"->Path.pack;

let twitter = "https://twitter.com/AlexFedoseev"->Path.pack;
let github = "https://github.com/AlexFedoseev"->Path.pack;

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
  | ["blog"] => Inner(Blog(Index(All)))->Some
  | ["blog", category] =>
    switch (category->PostCategory.fromString) {
    | Ok(category) => Inner(Blog(Index(Category(category))))->Some
    | Error () => None
    }
  | ["blog", category, year, slug] =>
    Inner(Blog(Post({year, category, slug})))->Some
  | ["photo"] => Inner(Photo)->Some
  | ["me"] => Inner(Me)->Some
  | _ => None
  };
