type t = Next.Router.t

let route = (router: t) => router.pathname->Route.make
let asPath = (router: t) => router.asPath

@module("next/router") external useRouter: unit => t = "useRouter"

@send external push: (t, Route.t) => unit = "push"
