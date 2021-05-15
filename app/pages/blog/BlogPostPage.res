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

let getStaticProps = ctx => {
  open Next.GetStaticProps

  let posts = BlogPosts.read()
  let index =
    posts->Js.Array2.findIndex(post =>
      post.date->BlogPost.Date.year == ctx.params.year && post.slug == ctx.params.slug
    )

  switch index {
  | -1 =>
    failwith(
      `Impossible case: post is not found. Category: ${ctx.params.category}. Year: ${ctx.params.year}. Slug: ${ctx.params.slug}.`,
    )
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
        category: post.category->BlogPost.Category.formatForUrl,
        year: post.date->BlogPost.Date.year,
        slug: post.slug,
      },
    }),
    fallback: false,
  })
}

let defaultMetaImage: Image.basic = %raw("require('images/meta-blog.png?preset=basic')")

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
      | Some(cover) => cover.src->BlogPost.Cover.fallback
      }}
      ogType=#article
    />
    <Mdx.Provider components=Markdown.components>
      <BlogPostLayout
        key=post.slug
        title=post.title
        date=post.date
        category=post.category
        cover=dep.cover
        prevPost={prevPost->Js.Null.toOption}
        nextPost={nextPost->Js.Null.toOption}>
        <BlogPostContent />
      </BlogPostLayout>
    </Mdx.Provider>
  </>
}
