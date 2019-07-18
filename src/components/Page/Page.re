[@react.component]
let make = (~children) => {
  React.useEffect0(() => {
    Web.Dom.(window->Window.scrollTo(0., 0., _));
    None;
  });

  React.useEffect(() => {
    Timer.onNextTick(() =>
      if (ProgressBar.started()) {
        ProgressBar.complete();
      }
    );
    None;
  });

  children;
};
