type error = [
  | #404
  | #500
]

@react.component
let default: (~error: error) => React.element
