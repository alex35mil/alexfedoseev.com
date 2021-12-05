type props = {posts: BlogPosts.byYear}

let getStaticProps = _ => {
  open Next.GetStaticProps

  Promise.resolve({
    props: {
      posts: BlogPosts.read()->BlogPosts.byYear,
    },
  })
}

@module("images/meta-blog.png?preset=basic") external metaImage: Image.basic = "default"

@react.component
let default = (~posts: BlogPosts.byYear) => {
  <>
    <Head
      htmlTitle=Suffixed("Blog")
      socialTitle=Prefixed("Blog")
      description=Default
      image=metaImage.src
      ogType=#website
    />
    <BlogPostsLayout posts />
  </>
}
