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
      styles: path.join(root, "src", "styles"),
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
    ],
  },
};
