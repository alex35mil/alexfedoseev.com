const sharp = require("sharp");
const loaderUtils = require("loader-utils");

module.exports = function(source) {
  if (this.cacheable) this.cacheable();

  const next = this.async();
  const options = loaderUtils.getOptions(this);
  const width = parseInt(options.size, 10);

  sharp(source)
    .resize({ width, withoutEnlargement: true })
    .toBuffer()
    .then(image => next(null, image), error => next(error));
};

module.exports.raw = true;
