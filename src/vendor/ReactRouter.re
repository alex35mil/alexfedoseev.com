include ReasonReactRouter;

module Link = {
  [@react.component]
  let make = (~path: string, ~className=?, ~onClick=?, ~children) => {
    <a
      href=path
      onClick={event => {
        onClick->Option.map(fn => event->fn)->ignore;
        if (!event->ReactEvent.Mouse.defaultPrevented
            && event->ReactEvent.Mouse.button == 0
            && !event->ReactEvent.Mouse.altKey
            && !event->ReactEvent.Mouse.ctrlKey
            && !event->ReactEvent.Mouse.metaKey
            && !event->ReactEvent.Mouse.shiftKey) {
          event->ReactEvent.Mouse.preventDefault;
          path->ReasonReactRouter.push;
        };
      }}
      ?className>
      children
    </a>;
  };
};
