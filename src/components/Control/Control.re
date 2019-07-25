module Css = ControlStyles;

[@react.component]
let make =
  React.forwardRef(
    (
      ~className="",
      ~disabled=false,
      ~onClick=?,
      ~onMouseDown=?,
      ~onKeyDown=?,
      ~onFocus=?,
      ~onBlur=?,
      ~children,
      theRef,
    ) =>
    <button
      type_="button"
      ref=?{theRef->Js.Nullable.toOption->Option.map(ReactDom.Ref.domRef)}
      disabled
      className={Cn.make([Css.control, className])}
      ?onClick
      ?onMouseDown
      ?onKeyDown
      ?onFocus
      ?onBlur>
      children
    </button>
  );
