[@react.component]
let make = () => {
  let route = Router.useRouter();

  switch (route) {
  | Some(Main) => <MainPage />
  | Some(Inner(route)) =>
    <ScreenSize>
      <Layout route>
        {switch (route) {
         | Blog(Index) => <BlogPage />
         | Blog(Post({year, slug})) => <PostPage year slug />
         | Photo => <PhotoPage />
         | Me => <MePage />
         }}
      </Layout>
    </ScreenSize>
  | None => <ErrorPage error=NotFound />
  };
};
