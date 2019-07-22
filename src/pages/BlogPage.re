module Css = BlogPageStyles;

[@react.component]
let make = () => {
  <Page>
    <div className=Css.container>
      <div className=Css.header>
        <Link path=Route.main underline=Never className=Css.logo>
          "Alex Fedoseev"->React.string
        </Link>
        <div>
          <Link.Box path=Route.blog className=Css.sectionHeader>
            "blog"->React.string
          </Link.Box>
        </div>
      </div>
      <div className=Css.years>
        {Posts.byYear
         ->Array.map(((year, posts)) =>
             <div key=year className=Css.yearContainer>
               {posts
                ->Array.mapWithIndex((idx, post) =>
                    <div key={post.slug} className=Css.post>
                      <div className=Css.year>
                        {switch (idx) {
                         | 0 => year->React.string
                         | _ => React.null
                         }}
                      </div>
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
      <div className=Css.footer>
        <div />
        <div className=Css.copy>
          {
            let start =
              Posts.byYear
              ->Array.getUnsafe(Posts.byYear->Array.length - 1)
              ->fst;
            let current = Posts.byYear->Array.getUnsafe(0)->fst;

            {j|© $start—$current|j}->React.string;
          }
        </div>
      </div>
    </div>
  </Page>;
};
