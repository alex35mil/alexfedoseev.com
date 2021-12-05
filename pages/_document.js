import Document, { Html, Head, Main, NextScript } from "next/document";

import { script, gaMeasurementId as GA_MEASUREMENT_ID } from "app/modules/Ga.bs.js";

export default class Doc extends Document {
  render() {
    return (
      <Html lang="en">
        <Head>
          <script
            async
            src={`https://www.googletagmanager.com/gtag/js?id=${GA_MEASUREMENT_ID}`}
          />
          <script
            dangerouslySetInnerHTML={{ __html: script }}
          />
        </Head>
        <body>
          <Main />
          <NextScript />
        </body>
      </Html>
    );
  }
}
