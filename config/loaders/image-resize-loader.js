const sharp = require("sharp");
const loaderUtils = require("loader-utils");

module.exports = function(source) {
  if (this.cacheable) this.cacheable();

  const next = this.async();
  const options = loaderUtils.getOptions(this);
  const size = options.size;

  const value = parseInt(size.substring(0, size.length - 1), 10);
  const suffix = size.substring(size.length - 1);

  let dimension;
  switch (suffix) {
    case "w":
      dimension = { width: value };
      break;
    case "h":
      dimension = { height: value };
      break;
    default:
      throw new Error(`[image-resize-loader] Invalid size value: ${size}`);
  }

  sharp(source)
    .resize({ ...dimension, withoutEnlargement: true })
    .toBuffer()
    .then(image => next(null, image), error => next(error));
};

module.exports.raw = true;
