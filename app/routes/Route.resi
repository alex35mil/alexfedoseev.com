type t

external make: string => t = "%identity"
external unpack: t => string = "%identity"

let isMain: t => bool
let isBlog: t => bool
let isPhoto: t => bool
let isMe: t => bool

let main: t
let blog: t
let blogCategory: BlogPost.category => t
let post: (~year: string, ~category: BlogPost.category, ~slug: string) => t
let photo: t
let me: t

let twitter: t
let github: t
let instagram: t
let facebook: t

let src: t

let minima: t
let sherry: t

let reFormality: t
let reDnd: t
let reCss: t
let rescriptClassnames: t
let rescriptDebouncer: t
let rescriptLogger: t
let steward: t
let conform: t
