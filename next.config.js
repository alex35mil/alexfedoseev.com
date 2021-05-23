const fs = require("fs");
const path = require("path");
const bsconfig = require("./bsconfig.json");

const withTM = require("next-transpile-modules")(["rescript"].concat(bsconfig["bs-dependencies"]));
const withMDX = require("./config/withMdx");
const withImages = require("./config/withImages");
const withLinaria = require("./config/withLinaria");

// There is an issue where webpack doesn't detect npm packages within node_modules when
// there is no dedicated package.json "main" entry + index.js file existent.
// This function will make sure that every ReScript dependency folder is conforming
// to webpack's resolve mechanism
//
// This will eventually be removed at some point, so keep an eye out for updates
// on our template repository.
function patchResDeps() {
  ["rescript"].concat(bsconfig["bs-dependencies"]).forEach((bsDep) => {
    fs.writeFileSync(`./node_modules/${bsDep}/index.js`, "");
    const json = require(`./node_modules/${bsDep}/package.json`);
    json.main = "index.js";
    fs.writeFileSync(
      `./node_modules/${bsDep}/package.json`,
      JSON.stringify(json, null, 2)
    );
  });
}
patchResDeps(); // update package.json and create empty `index.js` before transpiling

const { ROOT } = process.env;

const config = {
  target: "serverless",
  pageExtensions: ["jsx", "js"],
  env: {
    ENV: process.env.NODE_ENV,
    WEB_DOMAIN: process.env.WEB_DOMAIN,
    TWITTER_HANDLE: process.env.TWITTER_HANDLE,
    FACEBOOK_APP_ID: process.env.FACEBOOK_APP_ID,
    GA_MEASUREMENT_ID: process.env.GA_MEASUREMENT_ID,
  },
  future: {webpack5: true},
  webpack: (config, options) => {
    const { isServer } = options;

    if (!isServer) {
      config.resolve.fallback = {
        fs: false,
        path: false,
      };
    }

    config.resolveLoader.alias["image-loader"] = path.join(ROOT, "config", "image-loader.js");
    config.resolveLoader.alias["mdx-loader"] = path.join(ROOT, "config", "mdx-loader.js");

    return config
  },
};

module.exports = withLinaria(withMDX(withImages(withTM(config))));
