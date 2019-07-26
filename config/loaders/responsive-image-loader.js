const path = require("path");
const lqip = require("lqip");
const imageSize = require("image-size");
const loaderUtils = require("loader-utils");

const FLUID = "fluid";
const FIXED = "fixed";

const RESIZE_IMAGE_LOADER = path.join(__dirname, "image-resize-loader.js");

module.exports = function(source) {
  return source;
};

module.exports.pitch = async function(request) {
  if (!this.resourceQuery) return passthrough(request);

  const image = this.resourcePath;
  const query = loaderUtils.parseQuery(this.resourceQuery);
  const options = loaderUtils.getOptions(this);

  if (!Object.keys(options.presets).includes(query.preset)) {
    throw new Error(
      `[responsive-image-loader]: Unknown preset "${query.preset}"`,
    );
  }

  const preset = options.presets[query.preset];

  if (!preset.type) {
    throw new Error(`[responsive-image-loader]: Preset type is required`);
  }

  if (preset.type !== FLUID && preset.type !== FIXED) {
    throw new Error(
      `[responsive-image-loader]: Unknown preset type "${preset.type}"`,
    );
  }

  if (!preset.fallback) {
    throw new Error(`[responsive-image-loader]: Fallback size is required`);
  }

  const sources = preset.sizes.reduce(
    (dict, size) => ({
      ...dict,
      [size]: getRequire(request, size),
      [size * 2]: getRequire(request, size * 2),
      [size * 3]: getRequire(request, size * 3),
    }),
    {},
  );

  const dimensions = imageSize(image);
  const aspectRatio = dimensions.width / dimensions.height;

  const fallback = sources[preset.fallback];
  const placeholder = JSON.stringify(await lqip.base64(image));

  switch (preset.type) {
    case FLUID:
      return exportFluid(preset, sources, fallback, placeholder, dimensions, aspectRatio);
    case FIXED:
      return exportFixed(preset, sources, fallback, placeholder, dimensions, aspectRatio);
    default:
      throw new Error(
        `[responsive-image-loader]: Unknown preset type "${preset.type}"`,
      );
  }
};

function passthrough(request) {
  return `module.exports = require(${JSON.stringify("-!" + request)})`;
}

function getRequire(request, size) {
  const parsedRequest = request.split("!");
  const loaders = parsedRequest
    .slice(0, -1)
    .concat(`${RESIZE_IMAGE_LOADER}?size=${size}`);
  const image = parsedRequest[parsedRequest.length - 1];
  const resizedImage = "-!" + loaders.concat(image).join("!");
  return `require(${JSON.stringify(resizedImage)})`;
}

function exportFluid(preset, sources, fallback, placeholder, dimensions, aspectRatio) {
  const stringifiedSrcset = Object.keys(sources)
    .map(size => `${sources[size]} + ' ${size}w'`)
    .join(`+ ', ' + `);

  return `module.exports = { srcset: ${stringifiedSrcset}, fallback: ${fallback}, placeholder: ${placeholder}, width: ${dimensions.width}, height: ${dimensions.height}, aspectRatio: ${aspectRatio} }`;
}

function exportFixed(preset, sources, fallback, placeholder, dimensions, aspectRatio) {
  const srcsets = preset.sizes.reduce(
    (dict, size) => ({
      ...dict,
      [size]: `${sources[size]} + ', ' + ${sources[size * 2]} + ' 2x, ' + ${sources[size * 3]} + ' 3x'`,
    }),
    {},
  );
  const stringifiedSrcsets = preset.sizes
    .map(size => `${size}: ${srcsets[size]}`)
    .join(", ");
  return `module.exports = { srcset: { ${stringifiedSrcsets} }, fallback: ${fallback}, placeholder: ${placeholder}, width: ${dimensions.width}, height: ${dimensions.height}, aspectRatio: ${aspectRatio} }`;
}
