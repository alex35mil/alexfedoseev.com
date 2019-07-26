[@react.component]
let make = () => {
  let route = Router.useRouter();

  switch (route) {
  | Some(Main) => <MainPage />
  | Some(Inner(route)) =>
    <ScreenSize>
      <Layout route>
        {switch (route) {
         | Blog(`Index) => <BlogPage />
         | Blog(`Post(slug)) => <PostPage slug />
         | Photo => <PhotoPage />
         | Me => <MePage />
         }}
      </Layout>
    </ScreenSize>
  | None => "404"->React.string // TODO: Error screen
  };
};
