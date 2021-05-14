@react.component
let make = (~title, ~viewBoxWidth, ~viewBoxHeight, ~className, ~children) => {
  let id = `svg-title-${title}`
  let viewBox = `0 0 ${viewBoxWidth} ${viewBoxHeight}`

  <svg ariaLabelledby=id className viewBox xmlns="http://www.w3.org/2000/svg">
    <title id> {title->React.string} </title> children
  </svg>
}
