module Css = LinkStyles;

type underline =
  | Always
  | WhenInteracted
  | Never;

[@react.component]
let make =
    (
      ~path: ReactRouter.path,
      ~underline: underline,
      ~className="",
      ~onClick=?,
      ~children,
    ) => {
  <ReactRouter.Link
    path
    className=Cn.(
      Css.link
      + Css.text
      + (
        switch (underline) {
        | Always => Css.underlineAlways
        | WhenInteracted => Css.underlineWhenInteracted
        | Never => Css.underlineNever
        }
      )
      + className
    )
    ?onClick>
    children
  </ReactRouter.Link>;
};

module Box = {
  [@react.component]
  let make = (~path: ReactRouter.path, ~className="", ~onClick=?, ~children) => {
    <ReactRouter.Link
      path
      className=Cn.(Css.link + Css.box + Css.underlineNever + className)
      ?onClick>
      children
    </ReactRouter.Link>;
  };
};
