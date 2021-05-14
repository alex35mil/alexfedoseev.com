@react.component
let default = (~children) => {
  let router = Router.useRouter()

  <ThemeContext>
    <ScreenContext>
      {if router->Router.route->Route.isMain {
        children
      } else {
        <Layout> children </Layout>
      }}
    </ScreenContext>
  </ThemeContext>
}
