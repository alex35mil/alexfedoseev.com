open Screen

include ReactContext.Make({
  type context = option<screen>
  let defaultValue = None
})

type state = option<screen>

type action = UpdateScreen(screen)

let reducer = (_, action) =>
  switch action {
  | UpdateScreen(nextScreen) => Some(nextScreen)
  }

@react.component
let make = (~children) => {
  let (state, dispatch) = reducer->React.useReducer(None)

  React.useEffect0(() => {
    let smallMq = {
      open Web.Dom
      window->Window.matchMedia(small, _)
    }
    let largeMq = {
      open Web.Dom
      window->Window.matchMedia(large, _)
    }

    let initialScreen = if largeMq->MediaQueryList.matches {
      Large
    } else {
      Small
    }

    UpdateScreen(initialScreen)->dispatch

    let smallUnsubscribe = smallMq->MediaQueryList.subscribe(mq => {
      if mq->MediaQueryList.matches {
        UpdateScreen(Small)->dispatch
      }
    })
    let largeUnsubscribe = largeMq->MediaQueryList.subscribe(mq => {
      if mq->MediaQueryList.matches {
        UpdateScreen(Large)->dispatch
      }
    })

    Some(
      () => {
        smallUnsubscribe()
        largeUnsubscribe()
      },
    )
  })

  <Provider value=state> children </Provider>
}
