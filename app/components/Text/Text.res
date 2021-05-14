module Css = TextStyles

module Ellipsis = {
  @react.component
  let make = (~role=?, ~className="", ~onClick=?, ~children) =>
    <div ?role className={cx([Css.ellipsis, className])} ?onClick> children </div>
}
