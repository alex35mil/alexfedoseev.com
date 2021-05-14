module Provider = {
  @module("@mdx-js/react") @react.component
  external make: (~components: {..} as 'a, ~children: React.element) => React.element =
    "MDXProvider"
}
