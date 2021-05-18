type t = string

external make: string => t = "%identity"
external unpack: t => string = "%identity"

let isMain = x => x == "/"
let isBlog = x => x->Js.String2.startsWith("/blog")
let isPhoto = x => x->Js.String2.startsWith("/photo")
let isMe = x => x->Js.String2.startsWith("/me")

let main = "/"
let blog = "/blog"
let blogCategory = (category: BlogPost.category) =>
  "/blog/" ++ category->BlogPost.Category.formatForUrl
let post = (~year: string, ~category: BlogPost.category, ~slug: string) =>
  `/blog/${category->BlogPost.Category.formatForUrl}/${year}/${slug}`
let photo = "/photo"
let me = "/me"

let twitter = "https://twitter.com/AlexFedoseev"
let github = "https://github.com/AlexFedoseev"
let instagram = "https://www.instagram.com/alex.fedoseev.photo/"
let facebook = "https://www.facebook.com/alex.fedoseev"

let src = "https://github.com/alexfedoseev/alexfedoseev.com"

let minima = "https://minima.app"
let sherry = "https://sherryapp.github.io"

let reFormality = "https://github.com/MinimaHQ/re-formality"
let reDnd = "https://github.com/MinimaHQ/re-dnd"
let reCss = "https://github.com/MinimaHQ/re-css"
let rescriptClassnames = "https://github.com/shakacode/rescript-classnames"
let rescriptDebouncer = "https://github.com/shakacode/rescript-debouncer"
let rescriptLogger = "https://github.com/shakacode/rescript-logger"
let steward = "https://github.com/alexfedoseev/steward"
let conform = "https://github.com/MinimaHQ/conform"
