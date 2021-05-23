let largeScreenRowGap = 24
let largeScreenColGap = 30
let largeScreenContentWidth = 700
let largeScreenLogoWidth = 120
let largeScreenLogoHeight = LogoStyles.height
let largeScreenRightColWidth = largeScreenContentWidth - largeScreenLogoWidth - largeScreenColGap

let smallScreenHeaderHeight = 25
let smallScreenRowGap = 22
let smallScreenHPad = 24
let smallScreenLogoWidth = 110
let smallScreenLogoHeight = Math.ceil(
  smallScreenLogoWidth->Float.fromInt *. LogoStyles.height /. LogoStyles.width,
)
