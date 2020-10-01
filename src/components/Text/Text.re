module Css = TextStyles;

module Ellipsis = {
  [@react.component]
  let make = (~role=?, ~className="", ~onClick=?, ~children) => {
    <div ?role className=Cn.(Css.ellipsis + className) ?onClick>
      children
    </div>;
  };
};
