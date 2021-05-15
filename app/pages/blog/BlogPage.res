type props = {posts: BlogPosts.byYear}

let getStaticProps = _ => {
  open Next.GetStaticProps

  Promise.resolve({
    props: {
      posts: BlogPosts.read()->BlogPosts.byYear,
    },
  })
}

module Css = BlogPageStyles

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
              <div className=Css.links>
                <div className=Css.postLink>
                  <Text.Ellipsis>
                    <Link
                      path={Route.post(~year, ~category=post.category, ~slug=post.slug)}
                      underline=WhenInteracted>
                      {post.title->React.string}
                    </Link>
                  </Text.Ellipsis>
                </div>
                <Link.Box path={post.category->Route.blogCategory}>
                  <Badge rotateOnHover=true>
                    {post.category->BlogPost.Category.format->React.string}
                  </Badge>
                </Link.Box>
              </div>
            </div>
          )
          ->React.array}
        </div>
      )
      ->React.array}
    </div>
  </>
}
