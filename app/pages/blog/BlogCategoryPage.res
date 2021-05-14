type props = {
  category: string,
  posts: BlogPosts.byYear,
}

type params = {category: string}

let getStaticProps = ctx => {
  open Next.GetStaticProps

  Promise.resolve({
    props: {
      category: ctx.params.category
      ->BlogPost.Category.fromUrl
      ->Result.getExn
      ->BlogPost.Category.format,
      posts: BlogPosts.read()
      ->Array.keep(post => {
        post.category->BlogPost.Category.formatForUrl == ctx.params.category
      })
      ->BlogPosts.byYear,
    },
  })
}

let getStaticPaths = () => {
  open Next.GetStaticPaths

  Promise.resolve({
    paths: BlogPost.Category.all->Array.map(category => {
      params: {category: category->BlogPost.Category.formatForUrl},
    }),
    fallback: false,
  })
}

module Css = BlogCategoryPageStyles

let metaImage: Image.basic = %raw("require('images/meta-blog.png?preset=basic')")

@react.component
let default = (~category: string, ~posts: BlogPosts.byYear) => {
  <>
    <Head
      htmlTitle=Suffixed(`${category} blog`)
      socialTitle=Prefixed(`${category} blog`)
      description=Custom(`It's all about ${category}. Hi!`)
      image=metaImage.src
      ogType=#website
    />
    <div className=Css.container>
      <h1 className=Css.title> {category->React.string} </h1>
      <div className=Css.years>
        {posts
        ->Array.map(((year, posts)) =>
          <div key=year className=Css.yearContainer>
            {posts
            ->Array.mapWithIndex((idx, post) =>
              <div key=post.slug className=Css.post>
                <div className=Css.year>
                  <Layout.PrimarySidenote>
                    {switch idx {
                    | 0 => year->React.string
                    | _ => React.null
                    }}
                  </Layout.PrimarySidenote>
                </div>
                <div className=Css.postLink>
                  <Text.Ellipsis>
                    <Link
                      path={Route.post(~year, ~category=post.category, ~slug=post.slug)}
                      underline=WhenInteracted>
                      {post.title->React.string}
                    </Link>
                  </Text.Ellipsis>
                </div>
              </div>
            )
            ->React.array}
          </div>
        )
        ->React.array}
      </div>
    </div>
  </>
}
