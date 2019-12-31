[@react.component]
let make = (~year: string, ~slug: string) => {
  let index =
    Posts.all->Array.getIndexBy(entry =>
      entry.year == year && entry.slug == slug
    );

  switch (index) {
  | Some(index) =>
    let post = Posts.all->Array.getUnsafe(index);

    <PostLoader key=slug load={post.loader}>
      (
        ((module Content)) =>
          <Post
            title={post.title}
            year
            date={post.date}
            prevPost={
              Posts.all
              ->Array.get(index + 1)
              ->Option.map(post =>
                  Post.Footer.{year: post.year, slug: post.slug}
                )
            }
            nextPost={
              Posts.all
              ->Array.get(index - 1)
              ->Option.map(post =>
                  Post.Footer.{year: post.year, slug: post.slug}
                )
            }>
            <Content />
          </Post>
      )
    </PostLoader>;
  | None => <ErrorPage error=NotFound />
  };
};
