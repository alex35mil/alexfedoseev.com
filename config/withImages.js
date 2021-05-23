module.exports = (nextConfig = {}) => {
  return {
    ...nextConfig,
    webpack(config, options) {
      config.module.rules.push({
        test: /images\/.*\.(jpe?g|png|gif|webp)$/,
        use: [
          {
            loader: "image-loader",
            options: {
              presets: {
                basic: {
                  srcsets: false,
                  placeholder: false,
                },
                basicWithPlaceholder: {
                  srcsets: false,
                  placeholder: true,
                },
                photo: {
                  srcsets: [
                    {type: "raw", label: "sm", width: 830},
                    {type: "raw", label: "md", width: 1024, fallback: true},
                    {type: "raw", label: "lg", width: 1500},
                    {type: "raw", label: "xl", width: 2500},
                  ],
                  placeholder: true,
                },
                postCover: {
                  srcsets: [
                    {
                      type: "w",
                      label: "fluid",
                      widths: [
                        840,
                        1024,
                        {value: 1366, fallback: true}, // also, used for social meta tags
                        1920,
                        2560,
                      ],
                    },
                  ],
                  placeholder: true,
                },
                postContent: {
                  srcsets: [
                    {type: "x", size: 880, fallback: true},
                  ],
                  placeholder: true,
                },
                postThumb: {
                  srcsets: [
                    {type: "x", size: 250},
                    {type: "x", size: 350},
                    {type: "x", size: 500, fallback: true},
                    {type: "x", size: {label: "700", width: 700, height: 600}},
                    {type: "w", label: "fluid", widths: [350, 400, 500, 700]},
                  ],
                  placeholder: true,
                },
                galleryThumb: {
                  srcsets: [
                    {type: "x", size: {label: "thumb", width: 350, height: 290}, fallback: true},
                  ],
                  placeholder: true,
                },
              },
            },
          },
        ],
      });

      if (typeof nextConfig.webpack === 'function') {
        return nextConfig.webpack(config, options);
      }

      return config;
    },
  };
}
