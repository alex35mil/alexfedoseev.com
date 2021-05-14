type props = {
  category: string,
  posts: BlogPosts.byYear,
}

type params = {category: string}

let getStaticProps: Next.GetStaticProps.t<props, params, unit>
let getStaticPaths: Next.GetStaticPaths.t<params>

@react.component
let default: (~category: string, ~posts: BlogPosts.byYear) => React.element
