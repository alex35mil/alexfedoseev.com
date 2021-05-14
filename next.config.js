const fs = require("fs");
const path = require("path");
const bsconfig = require("./bsconfig.json");

const withTM = require("next-transpile-modules")(["rescript"].concat(bsconfig["bs-dependencies"]));
const withMDX = require("./config/withMdx");
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

    config.module.rules.push({
      test: /images\/.*\.(jpe?g|png|gif|webp)$/,
      use: [
        {
          loader: "image-loader",
          options: {
            presets: {
              basic: {
                type: "basic",
                placeholder: false,
              },
              basicWithPlaceholder: {
                type: "basic",
                placeholder: true,
              },
              photo: {
                type: "raw",
                sizes: [
                  { label: "sm", width: 830 },
                  { label: "md", width: 1024 },
                  { label: "lg", width: 1500 },
                  { label: "xl", width: 2500 },
                ],
                fallback: "md",
                placeholder: true,
              },
              postCover: {
                type: "fluid",
                sizes: [840, 1024, 1366, 1920, 2560],
                fallback: 1366, // also, used for social meta tags
                placeholder: true,
              },
              postContent: {
                type: "fixed",
                sizes: [880],
                fallback: 880,
                placeholder: true,
              },
              // TODO: Optimize more
              postThumb: {
                type: "fixed",
                sizes: [
                  { label: "thumb", width: 600, height: 500 },
                ],
                fallback: "thumb",
                placeholder: true,
              },
              galleryThumb: {
                type: "fixed",
                sizes: [
                  { label: "thumb", width: 350, height: 290 },
                ],
                fallback: "thumb",
                placeholder: true,
              },
            },
          },
        },
      ],
    });

    return config
  },
};

module.exports = withTM(withLinaria(withMDX(config)));
