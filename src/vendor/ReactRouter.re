module Path = {
  type t;

  external pack: string => t = "%identity";
  external unpack: t => string = "%identity";
};

type url = ReasonReactRouter.url;
type path = Path.t;

let push = (path: Path.t) => path->Path.unpack->ReasonReactRouter.push;

let useUrl = ReasonReactRouter.useUrl;

module Link = {
  [@react.component]
  let make = (~path: Path.t, ~className=?, ~onClick=?, ~children) => {
    <a
      href={path->Path.unpack}
      onClick={event => {
        onClick->Option.map(fn => event->fn)->ignore;
        if (!event->ReactEvent.Mouse.defaultPrevented
            && event->ReactEvent.Mouse.button == 0
            && !event->ReactEvent.Mouse.altKey
            && !event->ReactEvent.Mouse.ctrlKey
            && !event->ReactEvent.Mouse.metaKey
            && !event->ReactEvent.Mouse.shiftKey) {
          event->ReactEvent.Mouse.preventDefault;
          path->push;
        };
      }}
      ?className>
      children
    </a>;
  };
};
