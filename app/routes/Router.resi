type t

let route: t => Route.t
let asPath: t => string

@module("next/router") external useRouter: unit => t = "useRouter"

@send external push: (t, Route.t) => unit = "push"
