import BlogCategoryPageRes from "app/pages/blog/BlogCategoryPage.bs.js";

export { getStaticProps, getStaticPaths } from "app/pages/blog/BlogCategoryPage.bs.js";

export default function BlogCategoryPage(props) {
  return <BlogCategoryPageRes {...props} />;
}
