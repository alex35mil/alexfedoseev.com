type props = {
  tag: string,
  posts: BlogPosts.byYear,
}

type params = {tag: string}

let getStaticProps: Next.GetStaticProps.t<props, params, unit>
let getStaticPaths: Next.GetStaticPaths.t<params>

@react.component
let default: (~tag: string, ~posts: BlogPosts.byYear) => React.element
