import BlogPageRes from "app/pages/blog/BlogPage.bs.js";

export { getStaticProps } from "app/pages/blog/BlogPage.bs.js";

export default function BlogPage(props) {
  return <BlogPageRes {...props} />;
}
