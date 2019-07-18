module Component = {
  module type t = {
    [@bs.obj]
    external makeProps:
      (~title: string, ~key: string=?, unit) => {. "title": string} =
      "";
    let make: React.component({. "title": string});
  };
};

include Loadable.Make(Component);
