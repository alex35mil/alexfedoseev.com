open Web.Dom

@get external matches: Window.mediaQueryList => bool = "matches"

@send
external addListener: (Window.mediaQueryList, Window.mediaQueryList => unit) => unit = "addListener"

@send
external removeListener: (Window.mediaQueryList, Window.mediaQueryList => unit) => unit =
  "removeListener"

let subscribe = (mq, handler) => {
  mq->addListener(handler)
  () => mq->removeListener(handler)
}
