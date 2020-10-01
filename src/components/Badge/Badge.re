module Css = BadgeStyles;

[@react.component]
let make = (~rotateOnHover=false, ~children) => {
  <div className=Cn.(Css.badge + Css.hover->on(rotateOnHover))>
    children
  </div>;
};
