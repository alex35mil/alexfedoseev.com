include GlobalStyles;

ProgressBar.init();

[@react.component]
let default = () => {
  <ErrorBoundary error=Unknown>
    <Mdx.Provider components=Markdown.components> <Shell /> </Mdx.Provider>
  </ErrorBoundary>;
};
