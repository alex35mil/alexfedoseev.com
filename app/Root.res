@react.component
let default = (~children) => {
  let router = Router.useRouter()

  React.useEffect1(() => {
    router.events->Next.Router.Events.on(#routeChangeComplete(Ga.pageview))
    Some(
      () => {
        router.events->Next.Router.Events.off(#routeChangeComplete(Ga.pageview))
      },
    )
  }, [router.events])

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
