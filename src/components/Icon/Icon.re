module Css = IconStyles;

type size =
  | SM
  | MD
  | LG;

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

module type Component = {
  [@bs.obj]
  external makeProps:
    (
      ~title: string=?,
      ~size: size,
      ~color: color,
      ~className: string=?,
      ~key: string=?,
      unit
    ) =>
    {
      .
      "title": option(string),
      "size": size,
      "color": color,
      "className": option(string),
    } =
    "";
  let make:
    {
      .
      "title": option(string),
      "size": size,
      "color": color,
      "className": option(string),
    } =>
    React.element;
};

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
      | MD => Css.mdSize
      | LG => Css.lgSize
      },
      className,
    ])}>
    children
  </Svg>;
};
