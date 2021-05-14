type props = {
  post: BlogPost.meta,
  prevPost: Js.null<BlogPost.meta>,
  nextPost: Js.null<BlogPost.meta>,
}

type params = {
  year: string,
  slug: string,
  category: string,
}

let getStaticProps: Next.GetStaticProps.t<props, params, unit>
let getStaticPaths: Next.GetStaticPaths.t<params>

@react.component
let default: (
  ~post: BlogPost.meta,
  ~prevPost: Js.null<BlogPost.meta>,
  ~nextPost: Js.null<BlogPost.meta>,
) => React.element
