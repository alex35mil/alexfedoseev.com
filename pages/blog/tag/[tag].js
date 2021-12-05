import BlogTagPageRes from "app/pages/blog/BlogTagPage.bs.js";

export { getStaticProps, getStaticPaths } from "app/pages/blog/BlogTagPage.bs.js";

export default function BlogTagPage(props) {
  return <BlogTagPageRes {...props} />;
}
