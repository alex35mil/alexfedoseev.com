type t<+'a> = Js.Promise.t<'a>
type error = Js.Promise.error

type result<'ok, 'error> = t<Result.t<'ok, 'error>>

external errorToString: error => string = "%identity"

@new
external make: ((@uncurry ~resolve: (. 'a) => unit, ~reject: (. exn) => unit) => unit) => t<'a> =
  "Promise"

@val @scope("Promise") external resolve: 'a => t<'a> = "resolve"
@val @scope("Promise") external reject: exn => t<'a> = "reject"

@val @scope("Promise")
external all: array<t<'a>> => t<array<'a>> = "all"
@val @scope("Promise")
external two: ((t<'a0>, t<'a1>)) => t<('a0, 'a1)> = "all"
@val @scope("Promise")
external three: ((t<'a0>, t<'a1>, t<'a2>)) => t<('a0, 'a1, 'a2)> = "all"
@val @scope("Promise")
external four: ((t<'a0>, t<'a1>, t<'a2>, t<'a3>)) => t<('a0, 'a1, 'a2, 'a3)> = "all"
@val @scope("Promise")
external five: ((t<'a0>, t<'a1>, t<'a2>, t<'a3>, t<'a4>)) => t<('a0, 'a1, 'a2, 'a3, 'a4)> = "all"
@val @scope("Promise")
external six: ((t<'a0>, t<'a1>, t<'a2>, t<'a3>, t<'a4>, t<'a5>)) => t<(
  'a0,
  'a1,
  'a2,
  'a3,
  'a4,
  'a5,
)> = "all"

@val @scope("Promise")
external race: array<t<'a>> => t<'a> = "race"

@send
external andThen: (t<'a>, @uncurry ('a => t<'b>)) => t<'b> = "then"

@send
external catch: (t<'a>, @uncurry (error => t<'a>)) => t<'a> = "catch"

let map = (x: t<'a>, fn: 'a => 'b): t<'b> => x->andThen(x => x->fn->resolve)

let tap = (x: t<'a>, fn: 'a => 'b): t<'a> =>
  x->andThen(x => {
    x->fn
    x->resolve
  })

let result = (x: t<'ok>): result<'ok, 'error> =>
  x->andThen(x => Result.Ok(x)->resolve)->catch(error => Result.Error(error)->resolve)

let mapResult = (x: t<'ok>, ~ok, ~error): result<'ok, 'error> =>
  x->andThen(x => Result.Ok(x->ok)->resolve)->catch(x => Result.Error(x->error)->resolve)

let mapOk = (x: result<'ok, 'error>, fn: 'ok => 'ok'): result<'ok', 'error> =>
  x->andThen(x =>
    switch x {
    | Result.Ok(x) => Result.Ok(x->fn)->resolve
    | Result.Error(x) => Result.Error(x)->resolve
    }
  )

let mapError = (x: result<'ok, 'error>, fn: 'error => 'error'): result<'ok, 'error'> =>
  x->andThen(x =>
    switch x {
    | Result.Ok(x) => Result.Ok(x)->resolve
    | Result.Error(x) => Result.Error(x->fn)->resolve
    }
  )

let wait = (x: result<'ok, 'error>, fn: Result.t<'ok, 'error> => unit): unit =>
  x->andThen(x => x->fn->resolve)->ignore
