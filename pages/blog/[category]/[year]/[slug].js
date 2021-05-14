import BlogPostPageRes from "app/pages/blog/BlogPostPage.bs.js";

export { getStaticProps, getStaticPaths } from "app/pages/blog/BlogPostPage.bs.js";

export default function BlogPostPage(props) {
  return <BlogPostPageRes {...props} />;
}
