let useRouter = () => {
  let url = ReactRouter.useUrl();
  let urlRef = React.useRef(url);

  React.useEffect(() => {
    let prevUrl = urlRef.current;
    if (!url.path->List.eq(prevUrl.path, (==))) {
      ProgressBar.start();
    };
    urlRef.current = url;
    None;
  });

  url->Route.fromUrl;
};
