type props = {
  post: BlogPost.meta,
  prevPost: Js.null<BlogPost.meta>,
  nextPost: Js.null<BlogPost.meta>,
}

type params = {slug: string}

let getStaticProps = ctx => {
  open Next.GetStaticProps

  let posts = BlogPosts.read()
  let index = posts->Js.Array2.findIndex(post => post.slug == ctx.params.slug)

  switch index {
  | -1 => failwith(`Impossible case: post is not found. Slug: ${ctx.params.slug}.`)
  | index =>
    Promise.resolve({
      props: {
        post: posts->Array.getUnsafe(index),
        nextPost: index > 0 ? posts->Array.get(index - 1)->Js.Null.fromOption : Js.null,
        prevPost: index < posts->Array.length - 1
          ? posts->Array.get(index + 1)->Js.Null.fromOption
          : Js.null,
      },
    })
  }
}

let getStaticPaths = () => {
  open Next.GetStaticPaths

  let posts = BlogPosts.read()

  Promise.resolve({
    paths: posts->Array.map(post => {
      params: {
        slug: post.slug,
      },
    }),
    fallback: false,
  })
}

@module("images/meta-blog.png?preset=basic") external defaultMetaImage: Image.basic = "default"

@react.component
let default = (
  ~post: BlogPost.meta,
  ~prevPost: Js.null<BlogPost.meta>,
  ~nextPost: Js.null<BlogPost.meta>,
) => {
  let dep = BlogPosts.dependencies->Js.Dict.unsafeGet(post.key)
  let module(BlogPostContent) = dep.component->Next.Dynamic.fromJs

  <>
    <Head
      htmlTitle=Suffixed(post.title)
      socialTitle=Naked(post.title)
      description=Custom(post.description)
      image={switch dep.cover {
      | None => defaultMetaImage.src
      | Some(cover) => cover.src.fallback
      }}
      ogType=#article
    />
    <Mdx.Provider components=Markdown.components>
      <BlogPostLayout
        key=post.slug
        title=post.title
        date=post.date
        tags=post.tags
        cover=dep.cover
        prevPost={prevPost->Js.Null.toOption}
        nextPost={nextPost->Js.Null.toOption}>
        <BlogPostContent />
      </BlogPostLayout>
    </Mdx.Provider>
  </>
}
