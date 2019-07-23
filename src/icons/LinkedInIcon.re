[@react.component]
let make =
    (~title="LinkedIn", ~size: Icon.size, ~color: Icon.color, ~className=?) => {
  <Icon title size ?className>
    <path
      fill={color->Icon.colorToString}
      d="M6 6h2.767v1.418h0.040c0.385-0.691 1.327-1.418 2.732-1.418 2.921 0 3.461 1.818 3.461 4.183v4.817h-2.885v-4.27c0-1.018-0.021-2.329-1.5-2.329-1.502 0-1.732 1.109-1.732 2.255v4.344h-2.883v-9z"
    />
    <path fill={color->Icon.colorToString} d="M1 6h3v9h-3v-9z" />
    <path
      fill={color->Icon.colorToString}
      d="M4 3.5c0 0.828-0.672 1.5-1.5 1.5s-1.5-0.672-1.5-1.5c0-0.828 0.672-1.5 1.5-1.5s1.5 0.672 1.5 1.5z"
    />
  </Icon>;
};