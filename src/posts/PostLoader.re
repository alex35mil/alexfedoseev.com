module Component = {
  module type t = {
    [@bs.obj] external makeProps: (~key: string=?, unit) => {.} = "";
    let make: React.component({.});
  };
};

include Loadable.Make(Component);
