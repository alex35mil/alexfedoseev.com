module Css = TextStyles;

module Ellipsis = {
  [@react.component]
  let make = (~role=?, ~className="", ~onClick=?, ~children) => {
    <div ?role className={Cn.make([Css.ellipsis, className])} ?onClick>
      children
    </div>;
  };
};
