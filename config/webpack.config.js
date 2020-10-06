const fs = require("fs");
const path = require("path");
const webpack = require("webpack");
const HtmlPlugin = require("html-webpack-plugin");
const CssPlugin = require("mini-css-extract-plugin");
const OptimizeCssAssetsPlugin = require("optimize-css-assets-webpack-plugin");
const CompressionPlugin = require("compression-webpack-plugin");
const WebappPlugin = require("webapp-webpack-plugin");
const RobotstxtPlugin = require("robotstxt-webpack-plugin");
const { BundleAnalyzerPlugin } = require("webpack-bundle-analyzer");

const root = process.cwd();
const { NODE_ENV, ANALYZE } = process.env;

const isProduction = NODE_ENV === "production";
const withAnalyzer = ANALYZE === "true";

const config = {};

config.context = root;

config.mode = NODE_ENV;

config.entry = isProduction ? "./src/index.js" : "./src/index.hot.js";

config.output = isProduction
  ? {
      path: path.join(root, "build"),
      filename: "[name].[hash].js",
      chunkFilename: "[id].[hash].js",
    }
  : {
      path: "/",
      filename: "[name].js",
      chunkFilename: "[id].js",
    };

config.resolve = {
  alias: {
    components: path.join(root, "src", "components"),
    markdown: path.join(
      root,
      "src",
      "components",
      "Markdown",
      "Markdown.bs.js",
    ),
    styles: path.join(root, "src", "styles"),
    meta: path.join(root, "src", "meta"),
  },
};

config.resolveLoader = {
  alias: {
    "responsive-image-loader": path.join(
      __dirname,
      "loaders",
      "responsive-image-loader.js",
    ),
  },
};

config.devtool = isProduction ? false : "#cheap-module-eval-source-map";

config.optimization = {
  splitChunks: { chunks: "all" },
};

if (isProduction) {
  config.performance = {
    assetFilter: asset => /(js|css)\.gz$/.test(asset),
  };
}

config.plugins = [
  new webpack.EnvironmentPlugin([
    "NODE_ENV",
    "TWITTER_HANDLE",
    "FACEBOOK_APP_ID",
  ]),
  new HtmlPlugin({
    template: "./src/index.html",
    inject: true,
    minify: isProduction,
    chunksSortMode: "none", // due to weird bug somewhere in html-webpack-plugin
  }),
];

if (isProduction) {
  config.plugins.push(
    ...[
      new CssPlugin({
        filename: "[name].[hash].css",
        chunkFilename: "[id].[hash].css",
      }),
      new OptimizeCssAssetsPlugin({
        cssProcessor: require("cssnano"),
      }),
      new CompressionPlugin({
        deleteOriginalAssets: false,
      }),
      new RobotstxtPlugin({
        policy: [
          {
            userAgent: "*",
            disallow: null,
          },
        ],
      }),
      new WebappPlugin({
        logo: "./src/meta/favicon.png",
        prefix: "/",
        inject: true,
        favicons: {
          appName: "Alex Fedoseev",
          appDescription: null,
          developerName: null,
          developerURL: null,
          version: null,
          loadManifestWithCredentials: false,
          icons: {
            android: true,
            appleIcon: true,
            appleStartup: true,
            coast: true,
            favicons: true,
            firefox: true,
            windows: true,
            yandex: true,
          },
        },
      }),
    ],
  );

  if (withAnalyzer) {
    config.plugins.push(
      new BundleAnalyzerPlugin({
        analyzerMode: "server",
        defaultSizes: "gzip",
      }),
    );
  }
} else {
  config.plugins.unshift(...[new webpack.HotModuleReplacementPlugin()]);
}

config.module = {
  rules: [
    {
      test: /\.js$/,
      exclude: /node_modules/,
      use: [
        {
          loader: "babel-loader",
          options: { compact: isProduction },
        },
        {
          loader: "linaria/loader",
          options: { displayName: !isProduction },
        },
      ],
    },
    {
      test: /\.css$/,
      use: [
        isProduction ? CssPlugin.loader : "style-loader",
        {
          loader: "css-loader",
          options: { modules: "global" },
        },
      ],
    },
    {
      test: /\.mdx$/,
      use: ["babel-loader", "@mdx-js/loader"],
    },
    {
      test: /\.woff2?$/,
      use: {
        loader: "file-loader",
        options: {
          esModule: false,
        },
      },
    },
    {
      test: /\.(webp|png|jpe?g)$/,
      use: [
        {
          loader: "responsive-image-loader",
          options: {
            presets: {
              cover: {
                type: "fluid",
                sizes: [840, 1024, 1366, 1920, 2560],
                fallback: 1024,
              },
              inline: {
                type: "fixed",
                sizes: [880],
                fallback: 880,
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
              },
              gridThumb: {
                type: "fixed",
                sizes: [
                  { label: "thumb", width: 350, height: 290 },
                ],
                fallback: "thumb",
              },
              // TODO: Optimize more
              postThumb: {
                type: "fixed",
                sizes: [
                  { label: "thumb", width: 600, height: 500 },
                ],
                fallback: "thumb",
              },
            },
          },
        },
        {
          loader: "file-loader",
          options: {
            name: "[hash].[ext]",
            esModule: false,
          },
        },
        {
          loader: "image-webpack-loader",
          options: {
            disable: !isProduction,
            mozjpeg: { quality: 85 },
          },
        },
      ],
    },
    {
      test: /\.gif$/,
      use: {
        loader: "file-loader",
        options: {
          name: "[hash].[ext]",
          esModule: false,
        },
      },
    },
    {
      test: /\photoswipe\/dist\/default-skin\/default-skin\.svg$/,
      use: {
        loader: "url-loader",
        options: { limit: false },
      },
    },
  ],
};

if (!isProduction) {
  config.devServer = {
    hot: true,
    inline: true,
    historyApiFallback: true,
  };
}

module.exports = config;
