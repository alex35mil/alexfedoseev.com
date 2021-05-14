module Css = BadgeStyles

@react.component
let make = (~rotateOnHover=false, ~children) =>
  <div className={cx([Css.badge, rotateOnHover ? Css.hover : ""])}> children </div>
