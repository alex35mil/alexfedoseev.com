module Css = LinkStyles

type underline =
  | Always
  | WhenInteracted
  | Never

@react.component
let make = (~path: Route.t, ~underline: underline, ~className="", ~onClick=?, ~children) =>
  <Next.Link href={path->Route.unpack}>
    <a
      className={cx([
        Css.link,
        Css.text,
        switch underline {
        | Always => Css.underlineAlways
        | WhenInteracted => Css.underlineWhenInteracted
        | Never => Css.underlineNever
        },
        className,
      ])}
      ?onClick>
      children
    </a>
  </Next.Link>

module Box = {
  @react.component
  let make = (~path: Route.t, ~className="", ~onClick=?, ~children) =>
    <Next.Link href={path->Route.unpack}>
      <a className={cx([Css.link, Css.box, Css.underlineNever, className])} ?onClick> children </a>
    </Next.Link>
}
