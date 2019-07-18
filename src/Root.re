include GlobalStyles;

ProgressBar.init();

[@react.component]
let default = () => {
  <Mdx.Provider components=Markdown.components> <Shell /> </Mdx.Provider>;
};
