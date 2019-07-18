[@react.component]
let make = (~slug: string) => {
  let post =
    Posts.all |> Js.Array.find((post: Posts.entry) => post.slug == slug);

  switch (post) {
  | Some(post) =>
    <PostLoader load={post.loader}>
      (((module Content)) => <Post> <Content title={post.title} /> </Post>)
    </PostLoader>
  | None => "404"->React.string // TODO: Error screen
  };
};
