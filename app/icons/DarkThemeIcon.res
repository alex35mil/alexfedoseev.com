@react.component
let make = (~title="Dark", ~size: Icon.size, ~color: Icon.color, ~className=?) => {
  let {ThemeContext.colors: theme} = React.useContext(ThemeContext.ctx)

  <Icon title size ?className>
    <path
      fill={color->Icon.color(~theme)}
      d="M10.975 1.44c0.549 0.308 1.066 0.694 1.533 1.159 2.736 2.738 2.736 7.173 0 9.909s-7.172 2.736-9.909 0c-0.466-0.467-0.852-0.985-1.159-1.533 2.668 1.494 6.106 1.11 8.375-1.159s2.654-5.707 1.16-8.376z"
    />
  </Icon>
}
