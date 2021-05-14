import ErrorPageRes from "app/pages/ErrorPage.bs.js";

export default function Error500Page() {
  return <ErrorPageRes error={500} />;
}
