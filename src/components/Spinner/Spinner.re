module Css = SpinnerStyles;

module Size = {
  type t =
    | LG;

  let factor =
    fun
    | LG => 0.75;

  let toPx =
    fun
    | LG => 30;
};

module Color = {
  type t =
    | Blue;
};

module Background = {
  type t =
    | White;
};

let px = value => value->Int.toString ++ "px";

[@react.component]
let make =
    (
      ~size: Size.t,
      ~color: Color.t,
      ~bg: option(Background.t)=?,
      ~spread: bool=false,
    ) => {
  let sizeFactor = size->Size.factor;
  let mappedSize = size->Size.toPx;
  let normalizedSize = mappedSize->float_of_int *. sizeFactor;
  let spinnerHeight = (normalizedSize /. 1.5)->int_of_float;
  let colMargin = normalizedSize > 15.0 ? 3 : 2;
  let colWidth = (normalizedSize *. 0.5)->int_of_float;
  let colHeight = normalizedSize->int_of_float;
  let colorClassName =
    switch (color) {
    | Blue => Css.blue
    };

  <div
    className=Cn.(
      spread
        ? Css.spreadedContainer
        : Css.container
          + (
            switch (bg) {
            | None => Css.transparentBg
            | Some(White) => Css.whiteBg
            }
          )
    )>
    <div className={spread ? Css.spreadedWrapper : Css.wrapper}>
      <div
        className=Css.spinner
        style={ReactDOM.Style.make(~height=spinnerHeight->px, ())}>
        <span
          className=Cn.(Css.col + Css.leftCol + colorClassName)
          style={ReactDOM.Style.make(
            ~width=colWidth->px,
            ~height=colHeight->px,
            (),
          )}
        />
        <span
          className=Cn.(Css.col + Css.middleCol + colorClassName)
          style={ReactDOM.Style.make(
            ~width=colWidth->px,
            ~height=colHeight->px,
            ~marginRight=colMargin->px,
            ~marginLeft=colMargin->px,
            (),
          )}
        />
        <span
          className=Cn.(Css.col + Css.rightCol + colorClassName)
          style={ReactDOM.Style.make(
            ~width=colWidth->px,
            ~height=colHeight->px,
            (),
          )}
        />
      </div>
    </div>
  </div>;
};
