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
                    <Layout.Sidenote>
                      {switch (idx) {
                       | 0 => year->React.string
                       | _ => React.null
                       }}
                    </Layout.Sidenote>
                    <div className=Css.link>
                      <Link
                        path={Route.post(~slug=post.slug)}
                        underline=WhenInteracted>
                        post.title->React.string
                      </Link>
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
