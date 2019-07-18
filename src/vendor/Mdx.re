module Provider = {
  [@bs.module "@mdx-js/react"] [@react.component]
  external make:
    (~components: Js.t({..} as 'a), ~children: React.element) => React.element =
    "MDXProvider";
};
