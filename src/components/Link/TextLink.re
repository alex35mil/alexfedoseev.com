module Css = LinkStyles;

[@react.component]
let make = (~path: ReactRouter.path, ~className="", ~onClick=?, ~children) => {
  <ReactRouter.Link
    path className={Cn.make([Css.link, Css.text, className])} ?onClick>
    children
  </ReactRouter.Link>;
};
