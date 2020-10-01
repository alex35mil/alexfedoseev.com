module Css = BlogCategoryPageStyles;

[@react.component]
let make = (~category: PostCategory.t) => {
  let posts =
    React.useMemo1(() => category->Posts.categoryByYear, [|category|]);

  <Page>
    <div className=Css.container>
      <h1 className=Css.title>
        {category->PostCategory.toString->String.capitalize_ascii->React.string}
      </h1>
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
                    </div>
                  )
                ->React.array}
             </div>
           )
         ->React.array}
      </div>
    </div>
  </Page>;
};
