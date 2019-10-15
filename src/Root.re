include GlobalStyles;

Theme.setDefault();
ProgressBar.init();

[@react.component]
let default = () => {
  <ErrorBoundary error=Unknown>
    <Theme.Provider>
      <Mdx.Provider components=Markdown.components> <Shell /> </Mdx.Provider>
    </Theme.Provider>
  </ErrorBoundary>;
};
