module type Component = {module type t;};

let delay = 200;

module Make = (Component: Component) => {
  type state =
    | LoadingModule([ | `WithSpinner | `WithoutSpinner])
    | Ok((module Component.t))
    | Error;

  type action =
    | ShowSpinner
    | RenderComponent((module Component.t))
    | Fail;

  let reducer = (state, action) =>
    switch (action) {
    | ShowSpinner =>
      switch (state) {
      | LoadingModule(`WithoutSpinner) => LoadingModule(`WithSpinner)
      | LoadingModule(`WithSpinner)
      | Ok(_)
      | Error => state
      }
    | RenderComponent(component) => Ok(component)
    | Fail => Error
    };

  [@react.component]
  let make =
      (
        ~load: unit => Promise.t(Module.js),
        ~children: (module Component.t) => React.element,
      ) => {
    let (state, dispatch) =
      reducer->React.useReducer(LoadingModule(`WithoutSpinner));

    React.useEffect0(() => {
      let timeoutId =
        delay->Js.Global.setTimeout(() => ShowSpinner->dispatch, _);

      load()
      ->Module.fromJs
      ->Promise.wait(
          fun
          | Ok(component) => {
              timeoutId->Js.Global.clearTimeout;
              RenderComponent(component)->dispatch;
            }
          | Error(_) => Fail->dispatch,
        );

      Some(() => timeoutId->Js.Global.clearTimeout);
    });

    switch (state) {
    | LoadingModule(`WithoutSpinner) => React.null
    | LoadingModule(`WithSpinner) =>
      <Spinner size=LG color=Blue spread=true />
    | Ok(component) => component->children
    | Error => <ErrorPage error=Unknown />
    };
  };
};
