let logoWidth = 120

let largeScreenRowGap = 24
let largeScreenColGap = 30
let largeScreenContentWidth = 700
let largeScreenLogoHeight = LogoStyles.height
let largeScreenRightColWidth = largeScreenContentWidth - logoWidth - largeScreenColGap

let smallScreenHeaderHeight = 25
let smallScreenRowGap = 22
let smallScreenHPad = 24
let smallScreenLogoHeight = Math.ceil(
  logoWidth->Float.fromInt *. LogoStyles.height /. LogoStyles.width,
)
