[@react.component]
let make =
    (~title="Previous", ~size: Icon.size, ~color: Icon.color, ~className=?) => {
  <Icon title size ?className>
    <path
      fill={color->Icon.colorToString}
      d="M11.113 13.934c0.214 0.218 0.214 0.567 0 0.783s-0.561 0.217-0.775 0l-6.264-6.326c-0.214-0.216-0.214-0.566 0-0.783l6.264-6.326c0.214-0.216 0.561-0.216 0.775 0s0.214 0.567 0 0.783l-5.713 5.935 5.713 5.934z"
    />
  </Icon>;
};
