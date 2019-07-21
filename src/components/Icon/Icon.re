module Css = IconStyles;

type size =
  | SM;

type color =
  | Blue
  | Gray
  | White;

let colorToString =
  fun
  | Blue => Color.blue
  | Gray => Color.grayIcon
  | White => Color.white;

let viewBoxSize = "16";

[@react.component]
let make = (~title: string, ~size: size, ~className="", ~children) => {
  <Svg
    title
    viewBoxWidth=viewBoxSize
    viewBoxHeight=viewBoxSize
    className={Cn.make([
      Css.icon,
      switch (size) {
      | SM => Css.smSize
      },
      className,
    ])}>
    children
  </Svg>;
};
