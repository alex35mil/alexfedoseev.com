open Web.Dom;

[@bs.get] external matches: Window.mediaQueryList => bool = "matches";

[@bs.send]
external addListener:
  (Window.mediaQueryList, Window.mediaQueryList => unit) => unit =
  "addListener";

[@bs.send]
external removeListener:
  (Window.mediaQueryList, Window.mediaQueryList => unit) => unit =
  "removeListener";

let subscribe = (mq, handler) => {
  mq->addListener(handler);
  Some(() => mq->removeListener(handler));
};
