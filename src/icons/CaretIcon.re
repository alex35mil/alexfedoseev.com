[@react.component]
let make =
    (~title="Caret", ~size: Icon.size, ~color: Icon.color, ~className=?) => {
  let {Theme.colors: theme} = React.useContext(Theme.Context.x);

  <Icon title size ?className>
    <path fill={color->Icon.color(~theme)} d="M3.5 6l4.5 4.5 4.5-4.5h-9z" />
  </Icon>;
};
