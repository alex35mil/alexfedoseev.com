[@react.component]
let make =
    (~title="Caret", ~size: Icon.size, ~color: Icon.color, ~className=?) => {
  <Icon title size ?className>
    <path fill={color->Icon.colorToString} d="M3.5 6l4.5 4.5 4.5-4.5h-9z" />
  </Icon>;
};
