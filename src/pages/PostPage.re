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
    <PostLoader key=slug load={post.loader}>
      (
        ((module Content)) =>
          <Post title={post.title} year date={post.date}>
            <Content title={post.title} />
          </Post>
      )
    </PostLoader>
  | None => "404"->React.string // TODO: Error screen
  };
};
