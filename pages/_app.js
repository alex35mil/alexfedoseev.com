import "app/styles/GlobalStyles.css";
import "app/themes/Theme.css";
import "app/pages/blog/modules/BlogPostLayoutStyles.css";
import "app/pages/photo/modules/GalleryStyles.css";

import Root from "app/Root.bs.js";

export default function App({ Component, pageProps }) {
  return <Root> <Component {...pageProps} /> </Root>;
}
