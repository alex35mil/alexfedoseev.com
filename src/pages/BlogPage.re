module Css = BlogPageStyles;

[@react.component]
let make = () => {
  let posts = React.useMemo0(() => Posts.allByYear());

  <Page>
    <div className=Css.years>
      {posts
       ->Array.map(((year, posts)) =>
           <div key=year className=Css.yearContainer>
             {posts
              ->Array.mapWithIndex((idx, post) =>
                  <div key={post.slug} className=Css.post>
                    <div className=Css.year>
                      <Layout.PrimarySidenote>
                        {switch (idx) {
                         | 0 => year->React.string
                         | _ => React.null
                         }}
                      </Layout.PrimarySidenote>
                    </div>
                    <div className=Css.links>
                      <div className=Css.postLink>
                        <Text.Ellipsis>
                          <Link
                            path={Route.post(
                              ~year,
                              ~category=post.category->PostCategory.toString,
                              ~slug=post.slug,
                            )}
                            underline=WhenInteracted>
                            post.title->React.string
                          </Link>
                        </Text.Ellipsis>
                      </div>
                      <Link.Box path={post.category->Route.blogCategory}>
                        <Badge rotateOnHover=true>
                          {post.category->PostCategory.toString->React.string}
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
  </Page>;
};
