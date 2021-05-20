type t = Next.Router.t

let route: t => Route.t

@module("next/router") external useRouter: unit => t = "useRouter"

@send external push: (t, Route.t) => unit = "push"
