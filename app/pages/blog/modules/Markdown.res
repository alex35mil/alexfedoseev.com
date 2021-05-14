open BlogPostLayout

// Exports to JS
let h1 = H1.make
let h2 = H2.make
let h3 = H3.make
let h4 = H4.make
let p = P.make
let a = A.make
let ol = Ol.make
let ul = Ul.make
let li = Li.make
let hr = Hr.make
let pre = Pre.make
let code = Code.make
let inlineCode = InlineCode.make

let inlineImage = InlineImage.make
let animatedGif = AnimatedGif.make
let photoGallery = PhotoGallery.make
let youtubeVideo = YoutubeVideo.make
let internalLink = InternalLink.make
let note = Note.make
let crossPostNote = CrossPostNote.make
let expandable = Expandable.make
let highlight = Highlight.make

// MDXProvider components
let components = {
  "h1": h1,
  "h2": h2,
  "h3": h3,
  "h4": h4,
  "p": p,
  "a": a,
  "ol": ol,
  "ul": ul,
  "li": li,
  "hr": hr,
  "pre": pre,
  "code": code,
  "inlineCode": inlineCode,
}
