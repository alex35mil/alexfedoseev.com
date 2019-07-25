const fs = require("fs");
const path = require("path");
const webpack = require("webpack");
const HtmlPlugin = require("html-webpack-plugin");

const root = process.cwd();

module.exports = {
  context: root,
  mode: "development",
  entry: "./src/index.hot.js",
  output: {
    path: "/",
    filename: "[name].js",
    chunkFilename: "[id].js",
  },
  resolve: {
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
  },
  devtool: "#cheap-module-eval-source-map",
  devServer: {
    hot: true,
    inline: true,
    historyApiFallback: true,
  },
  plugins: [
    new webpack.HotModuleReplacementPlugin(),
    new webpack.EnvironmentPlugin(["NODE_ENV"]),
    new HtmlPlugin({
      template: "./src/index.html",
      inject: true,
      chunksSortMode: "none", // due to weird bug somewhere in html-webpack-plugin
    }),
  ],
  module: {
    rules: [
      {
        test: /\.js$/,
        exclude: /node_modules/,
        use: [
          "babel-loader",
          {
            loader: "linaria/loader",
            options: { displayName: true },
          },
        ],
      },
      {
        test: /\.css$/,
        use: [
          "style-loader",
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
        use: "file-loader",
      },
      {
        test: /\.(webp|png|jpe?g)$/,
        use: {
          loader: "file-loader",
          options: { name: "[name]-[hash].[ext]" },
        },
      },
      {
        test: /\.gif$/,
        use: {
          loader: "file-loader",
          options: { name: "[name]-[hash].[ext]" },
        },
      },
    ],
  },
};
