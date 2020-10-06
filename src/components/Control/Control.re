module Css = ControlStyles;

[@react.component]
let make =
  React.forwardRef(
    (
      ~id=?,
      ~className="",
      ~style=?,
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
      ?id
      type_="button"
      ref=?{theRef->Js.Nullable.toOption->Option.map(ReactDOM.Ref.domRef)}
      disabled
      className=Cn.(Css.control + className)
      ?style
      ?onClick
      ?onMouseDown
      ?onKeyDown
      ?onFocus
      ?onBlur>
      children
    </button>
  );
