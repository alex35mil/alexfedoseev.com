module Css = LinkStyles;

type target =
  | Self
  | Blank;

module Box = {
  [@react.component]
  let make =
      (~href: ReactRouter.path, ~target: target, ~className="", ~children) => {
    <a
      href={href->ReactRouter.Path.unpack}
      target=?{
        switch (target) {
        | Blank => Some("_blank")
        | Self => None
        }
      }
      rel=?{
        switch (target) {
        | Blank => Some("noopener")
        | Self => None
        }
      }
      className={Cn.make([Css.link, Css.underlineNever, className])}>
      children
    </a>;
  };
};
