[@bs.module "./ErrorBoundary.js"] [@react.component]
external make:
  (~error: ErrorPage.error, ~children: React.element) => React.element =
  "default";
