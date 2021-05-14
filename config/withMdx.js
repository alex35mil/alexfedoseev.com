module.exports = (nextConfig = {}) => {
  return {
    ...nextConfig,
    webpack(config, options) {
      config.module.rules.push({
        test: /\.mdx$/,
        use: [
          options.defaultLoaders.babel,
          "@mdx-js/loader",
          "mdx-loader",
        ],
      });

      if (typeof nextConfig.webpack === 'function') {
        return nextConfig.webpack(config, options);
      }

      return config;
    },
  };
}
