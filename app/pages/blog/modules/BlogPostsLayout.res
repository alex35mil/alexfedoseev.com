module Css = BlogPostsLayoutStyles

@react.component
let make = (~posts: BlogPosts.byYear) => {
  <div className=Css.years>
    {posts
    ->Array.map(((year, posts)) =>
      <div key=year className=Css.yearPosts>
        {posts
        ->Array.mapWithIndex((idx, post) =>
          <div key=post.slug className=Css.post>
            <div />
            <div className=Css.postTags>
              {post.tags
              ->Array.map(tag => {
                <Link
                  key={tag->BlogPost.Tag.toString}
                  path={tag->Route.blogTag}
                  underline=WhenInteracted
                  className=Css.postTag>
                  {tag->BlogPost.Tag.format->React.string}
                </Link>
              })
              ->React.array}
            </div>
            {switch idx {
            | 0 =>
              <div className=Css.yearContainer>
                <Layout.PrimarySidenote className=Css.year>
                  {year->React.string}
                </Layout.PrimarySidenote>
              </div>
            | _ => <div />
            }}
            <div className=Css.postLink>
              <Link path={Route.post(~slug=post.slug)} underline=WhenInteracted>
                {post.title->React.string}
              </Link>
            </div>
          </div>
        )
        ->React.array}
      </div>
    )
    ->React.array}
  </div>
}
