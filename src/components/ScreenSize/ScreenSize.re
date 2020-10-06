module Context = {
  type t = Screen.t;

  let x = React.createContext(Screen.Large);

  module Provider = {
    let make = x->React.Context.provider;
    [@bs.obj]
    external makeProps:
      (~value: t, ~children: React.element, ~key: string=?, unit) =>
      {
        .
        "value": t,
        "children": React.element,
      };
  };
};

type state = Screen.t;

type action =
  | UpdateScreen(Screen.t);

let reducer = (_, action) =>
  switch (action) {
  | UpdateScreen(nextScreen) => nextScreen
  };

[@react.component]
let make = (~children) => {
  let smallMq =
    React.useRef(Web.Dom.(window->Window.matchMedia(Screen.small, _)));
  let largeMq =
    React.useRef(Web.Dom.(window->Window.matchMedia(Screen.large, _)));

  let initialState =
    React.useMemo0(() =>
      if (largeMq.current->MediaQueryList.matches) {
        Screen.Large;
      } else {
        Screen.Small;
      }
    );

  let (state, dispatch) = reducer->React.useReducer(initialState);

  React.useEffect0(() =>
    smallMq.current
    ->MediaQueryList.subscribe(mq => {
        smallMq.current = mq;
        if (mq->MediaQueryList.matches) {
          UpdateScreen(Small)->dispatch;
        };
      })
  );

  React.useEffect0(() =>
    largeMq.current
    ->MediaQueryList.subscribe(mq => {
        largeMq.current = mq;
        if (mq->MediaQueryList.matches) {
          UpdateScreen(Large)->dispatch;
        };
      })
  );

  <Context.Provider value=state> children </Context.Provider>;
};
