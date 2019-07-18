let useRouter = () => {
  let url = ReactRouter.useUrl();
  let urlRef = React.useRef(url);

  React.useEffect(() => {
    let prevUrl = urlRef->React.Ref.current;
    if (!url.path->List.eq(prevUrl.path, (==))) {
      ProgressBar.start();
    };
    urlRef->React.Ref.setCurrent(url);
    None;
  });

  url->Route.fromUrl;
};
