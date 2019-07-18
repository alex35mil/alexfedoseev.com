[@react.component]
let make = () => {
  let route = Router.useRouter();

  switch (route) {
  | Some(Main) => <MainPage />
  | Some(Blog) => <BlogPage />
  | Some(Post(slug)) => <PostPage slug />
  | None => "404"->React.string // TODO: Error screen
  };
};
