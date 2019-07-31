[@react.component]
let make = (~slug: string) => {
  let entry =
    Posts.byYear->BeltExt.Array.findAndThen(((year, posts)) => {
      let post =
        posts |> Js.Array.find((post: Posts.entry) => post.slug == slug);
      switch (post) {
      | Some(post) => `Return((year, post))
      | None => `Skip
      };
    });

  switch (entry) {
  | Some((year, post)) =>
    let index =
      Posts.all->Array.getIndexBy(entry => entry.slug == slug)->Option.getExn;

    <PostLoader key=slug load={post.loader}>
      (
        ((module Content)) =>
          <Post
            title={post.title}
            year
            date={post.date}
            prevPost={
              Posts.all->Array.get(index + 1)->Option.map(post => post.slug)
            }
            nextPost={
              Posts.all->Array.get(index - 1)->Option.map(post => post.slug)
            }>
            <Content title={post.title} />
          </Post>
      )
    </PostLoader>;
  | None => <ErrorPage error=NotFound />
  };
};
