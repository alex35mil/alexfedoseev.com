type props = {
  tag: string,
  posts: BlogPosts.byYear,
}

type params = {tag: string}

let getStaticProps = ctx => {
  open Next.GetStaticProps

  Promise.resolve({
    props: {
      tag: ctx.params.tag->BlogPost.Tag.fromString->Result.getExn->BlogPost.Tag.toString,
      posts: BlogPosts.read()
      ->Array.keep(post => {
        post.tags->Array.getBy(tag => tag->BlogPost.Tag.toString == ctx.params.tag)->Option.isSome
      })
      ->BlogPosts.byYear,
    },
  })
}

let getStaticPaths = () => {
  open Next.GetStaticPaths

  Promise.resolve({
    paths: BlogPost.Tag.all->Array.map(tag => {
      params: {tag: tag->BlogPost.Tag.toString},
    }),
    fallback: false,
  })
}

module Css = BlogTagPageStyles

@module("images/meta-blog.png?preset=basic") external metaImage: Image.basic = "default"

@react.component
let default = (~tag: string, ~posts: BlogPosts.byYear) => {
  <>
    <Head
      htmlTitle=Suffixed(`#${tag} blog`)
      socialTitle=Prefixed(`#${tag} blog`)
      description=Custom(`It's all about #${tag}`)
      image=metaImage.src
      ogType=#website
    />
    <div className=Css.container>
      <h1 className=Css.title> {`#${tag}`->React.string} </h1> <BlogPostsLayout posts />
    </div>
  </>
}
