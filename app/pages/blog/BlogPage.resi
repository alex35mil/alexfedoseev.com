type props = {posts: BlogPosts.byYear}

let getStaticProps: Next.GetStaticProps.t<props, unit, unit>

@react.component
let default: (~posts: BlogPosts.byYear) => React.element
