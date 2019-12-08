module Css = BlogPageStyles;

[@react.component]
let make = () => {
  <Page>
    <div className=Css.years>
      {Posts.byYear
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
                    <div className=Css.link>
                      <Text.Ellipsis>
                        <Link
                          path={Route.post(~year, ~slug=post.slug)}
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
  </Page>;
};
