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
  | Shown =>
    <div className=Css.container>
      <span className={cx([Css.dot, Css.dot1])} />
      <span className={cx([Css.dot, Css.dot2])} />
      <span className={cx([Css.dot, Css.dot3])} />
      <span className={cx([Css.dot, Css.dot4])} />
      <span className={cx([Css.dot, Css.dot5])} />
      <span className={cx([Css.dot, Css.dot6])} />
    </div>
  }
}
