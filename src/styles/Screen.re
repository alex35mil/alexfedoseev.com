type t =
  | Small
  | Large;

[@bs.module "./Screen.js"] external small: string = "small";
let small = small;

[@bs.module "./Screen.js"] external large: string = "large";
let large = large;

[@bs.module "./Screen.js"] external touch: string = "touch";
let touch = touch;

[@bs.module "./Screen.js"] external mouse: string = "mouse";
let mouse = mouse;
