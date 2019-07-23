[@react.component]
let make = (~title="Info", ~size: Icon.size, ~color: Icon.color, ~className=?) => {
  <Icon title size ?className>
    <path
      fill={color->Icon.colorToString}
      d="M9.946 0c1.072 0 1.608 0.73 1.608 1.566 0 1.044-0.931 2.010-2.143 2.010-1.015 0-1.607-0.6-1.579-1.592 0-0.834 0.705-1.983 2.114-1.983zM6.647 16c-0.846 0-1.466-0.522-0.874-2.819l0.971-4.074c0.169-0.651 0.197-0.913 0-0.913-0.254 0-1.351 0.45-2.002 0.894l-0.422-0.704c2.058-1.749 4.425-2.774 5.441-2.774 0.846 0 0.986 1.018 0.564 2.584l-1.113 4.282c-0.197 0.756-0.113 1.017 0.085 1.017 0.254 0 1.086-0.314 1.903-0.966l0.48 0.651c-2.002 2.038-4.188 2.822-5.033 2.822z"
    />
  </Icon>;
};
