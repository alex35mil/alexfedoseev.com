type screen =
  | Small
  | Large

let smallMaxWidth = LayoutParams.largeScreenContentWidth + 80 // if you change this, don't forget to update global css

let small = `only screen and (max-width: ${smallMaxWidth->Int.toString}px)`
let large = `only screen and (min-width: ${(smallMaxWidth + 1)->Int.toString}px)`

let touch = `only screen and (hover: none)`
let mouse = `only screen and (hover: hover)`

let between = (x, y) =>
  `only screen and (min-width: ${x->Int.toString}px) and (max-width: ${y->Int.toString}px)`

let dprVar = `var(--dpr)`
let smallScreenVar = `var(--small-screen)`
let largeScreenVar = `var(--large-screen)`
