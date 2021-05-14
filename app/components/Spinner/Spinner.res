module Css = SpinnerStyles

type state = Visibility.t

type action = Show

let reducer = (state: state, action): state =>
  switch (state, action) {
  | (Hidden, Show) => Shown
  | (Shown, Show) => state
  }

let delay = 200 // ms

@react.component
let make = () => {
  let (state, dispatch) = reducer->React.useReducer(Hidden)

  React.useEffect0(() => {
    let timeoutId = Js.Global.setTimeout(() => Show->dispatch, delay)
    Some(() => timeoutId->Js.Global.clearTimeout)
  })

  switch state {
  | Hidden => React.null
  | Shown => <div className=Css.container> {". . ."->React.string} </div>
  }
}
