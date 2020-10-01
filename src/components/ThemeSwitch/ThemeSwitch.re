module Css = ThemeSwitchStyles;

[@react.component]
let make = (~className="") => {
  let theme = React.useContext(Theme.Context.x);

  <div className=Cn.(Css.container + className)>
    <input
      id="theme-switch"
      type_="checkbox"
      className=Css.input
      checked={
        switch (theme.current) {
        | Light => false
        | Dark => true
        }
      }
      onChange={event =>
        theme.set(event->ReactEvent.Form.target##checked ? Dark : Light)
      }
    />
    <label htmlFor="theme-switch" className=Css.label>
      <div className=Css.track />
      <div className=Css.control>
        <LightThemeIcon
          size=SM
          color=Faded
          className=Cn.(Css.icon + Css.lightIcon)
        />
        <DarkThemeIcon
          size=SM
          color=Faded
          className=Cn.(Css.icon + Css.darkIcon)
        />
      </div>
    </label>
  </div>;
};
