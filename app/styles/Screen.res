type screen =
  | Small
  | Large

let smallMaxWidth = 680

let large = `only screen and (min-width: ${(smallMaxWidth + 1)->Int.toString}px)`
let small = `only screen and (max-width: ${smallMaxWidth->Int.toString}px)`

let touch = `only screen and (hover: none)`
let mouse = `only screen and (hover: hover)`

let between = (x, y) =>
  `only screen and (min-width: ${x->Int.toString}px) and (max-width: ${y->Int.toString}px)`
