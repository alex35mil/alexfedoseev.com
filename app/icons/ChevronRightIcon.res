@react.component
let make = (~title="Next", ~size: Icon.size, ~color: Icon.color, ~className=?) => {
  let {ThemeContext.colors: theme} = React.useContext(ThemeContext.ctx)

  <Icon title size ?className>
    <path
      fill={color->Icon.color(~theme)}
      d="M10.6 8l-5.713-5.936c-0.214-0.216-0.214-0.566 0-0.783 0.214-0.216 0.561-0.216 0.775 0l6.264 6.326c0.214 0.217 0.214 0.567 0 0.783l-6.264 6.326c-0.214 0.217-0.561 0.216-0.775 0s-0.214-0.566 0-0.783l5.713-5.934z"
    />
  </Icon>
}
