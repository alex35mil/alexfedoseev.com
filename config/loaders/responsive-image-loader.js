const path = require("path");
const lqip = require("lqip");
const sharp = require("sharp");
const loaderUtils = require("loader-utils");

const FLUID = "fluid";
const FIXED = "fixed";
const RAW = "raw";

const WIDTH = "width";
const HEIGHT = "height";

const LANDSCAPE = "landscape";
const PORTRAIT = "portrait";
const SQUARE = "square";

const DPR_1X = 1;
const DPR_2X = 2;
const DPR_3X = 3;
const DPR_1X_KEY = "@1x";
const DPR_2X_KEY = "@2x";
const DPR_3X_KEY = "@3x";

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

  if (![FLUID, FIXED, RAW].includes(preset.type)) {
    throw new Error(
      `[responsive-image-loader]: Unknown preset type "${preset.type}"`,
    );
  }

  if (!preset.fallback) {
    throw new Error(`[responsive-image-loader]: Fallback size is required`);
  }

  const dimensions = await sharp(image).metadata();
  const sizes = normalizeSizes(preset.sizes, dimensions);
  const aspectRatio = dimensions.width / dimensions.height;
  const orientation = aspectRatio > 1 ? LANDSCAPE : aspectRatio < 1 ? PORTRAIT : SQUARE;

  const sources = sizes.reduce(
    (dict, size) => ({
      ...dict,
      [size.label]: {
        value: size.value,
        dimension: size.dimension,
        densities: {
          [DPR_1X_KEY]: getRequire(
            request,
            getSizeForResizeLoader(size.value, size.dimension, DPR_1X),
          ),
          [DPR_2X_KEY]: getRequire(
            request,
            getSizeForResizeLoader(size.value, size.dimension, DPR_2X),
          ),
          [DPR_3X_KEY]: getRequire(
            request,
            getSizeForResizeLoader(size.value, size.dimension, DPR_3X),
          ),
        },
      },
    }),
    {},
  );

  const fallback = sources[preset.fallback].densities[DPR_1X_KEY];
  const placeholder = JSON.stringify(await lqip.base64(image));

  switch (preset.type) {
    case FLUID:
      return exportFluid(
        preset,
        sources,
        fallback,
        placeholder,
        dimensions,
        aspectRatio,
        orientation,
      );
    case FIXED:
      return exportFixed(
        preset,
        sources,
        fallback,
        placeholder,
        dimensions,
        aspectRatio,
        orientation,
      );
    case RAW:
      return exportRaw(
        preset,
        sources,
        fallback,
        placeholder,
        dimensions,
        aspectRatio,
        orientation,
      );
    default:
      throw new Error(
        `[responsive-image-loader]: Unknown preset type "${preset.type}"`,
      );
  }
};

function normalizeSizes(sizes, dimensions) {
  return sizes.map(entry => {
    if (typeof entry === "number") {
      return { label: entry.toString(), dimension: WIDTH, value: entry };
    } else {
      if (entry.width && !entry.height) {
        return { label: entry.label, dimension: WIDTH, value: entry.width };
      } else if (!entry.width && entry.height) {
        return { label: entry.label, dimension: HEIGHT, value: entry.height };
      } else if (entry.width && entry.height) {
        return dimensions.width > dimensions.height
          ? { label: entry.label, dimension: WIDTH, value: entry.width }
          : { label: entry.label, dimension: HEIGHT, value: entry.height };
      } else {
        throw new Error(
          `[responsive-image-loader]: Invalid size object: ${JSON.stringify(
            entry,
          )}`,
        );
      }
    }
  });
}

function getSizeForResizeLoader(value, dimension, dpr) {
  switch (dimension) {
    case WIDTH:
      return `${value * dpr}w`;
    case HEIGHT:
      return `${value * dpr}h`;
    default:
      throw new Error(
        `[responsive-image-loader]: Invalid dimension: ${dimension}`,
      );
  }
}

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

function exportFluid(
  preset,
  sources,
  fallback,
  placeholder,
  dimensions,
  aspectRatio,
  orientation,
) {
  const stringifiedSrcset = Object.entries(sources)
    .reduce((acc, [label, source]) => {
      if (source.dimension === HEIGHT) {
        throw new Error(
          `[responsive-image-loader]: Fliud images must have dimension "width". Label: "${label}"`,
        );
      }
      [
        [DPR_1X_KEY, DPR_1X],
        [DPR_2X_KEY, DPR_2X],
        [DPR_3X_KEY, DPR_3X],
      ].forEach(([key, dpr]) => {
        acc.push(`${source.densities[key]} + ' ${source.value * dpr}w'`);
      });
      return acc;
    }, [])
    .join(`+ ', ' + `);

  return `module.exports = { srcset: ${stringifiedSrcset}, fallback: ${fallback}, placeholder: ${placeholder}, width: ${dimensions.width}, height: ${dimensions.height}, aspectRatio: ${aspectRatio}, orientation: "${orientation}" }`;
}

function exportFixed(
  preset,
  sources,
  fallback,
  placeholder,
  dimensions,
  aspectRatio,
  orientation,
) {
  const srcsets = Object.entries(sources).reduce(
    (dict, [label, source]) => ({
      ...dict,
      [label]: `${source.densities[DPR_1X_KEY]} + ', ' + ${source.densities[DPR_2X_KEY]} + ' 2x, ' + ${source.densities[DPR_3X_KEY]} + ' 3x'`,
    }),
    {},
  );
  const stringifiedSrcsets = Object.entries(srcsets)
    .map(([label, srcset]) => `${label}: ${srcset}`)
    .join(", ");
  return `module.exports = { srcset: { ${stringifiedSrcsets} }, fallback: ${fallback}, placeholder: ${placeholder}, width: ${dimensions.width}, height: ${dimensions.height}, aspectRatio: ${aspectRatio}, orientation: "${orientation}" }`;
}

function exportRaw(
  preset,
  sources,
  fallback,
  placeholder,
  dimensions,
  aspectRatio,
  orientation,
) {
  const getActualDimensions = (value, dimension, dpr) => {
    let size = value * dpr;
    switch (dimension) {
      case WIDTH:
        return size < dimensions.width
          ? {
              width: size,
              height: (size * dimensions.height) / dimensions.width,
            }
          : {
              width: dimensions.width,
              height: dimensions.height,
            };

      case HEIGHT:
        return size < dimensions.height
          ? {
              width: (size * dimensions.width) / dimensions.height,
              height: size,
            }
          : {
              width: dimensions.width,
              height: dimensions.height,
            };

      default:
        throw new Error(
          `[responsive-image-loader]: Invalid dimension: ${dimension}`,
        );
    }
  };

  const srcsets = Object.entries(sources).reduce(
    (dict, [label, source]) => ({
      ...dict,
      [label]: {
        [DPR_1X_KEY]: {
          src: sources[label].densities[DPR_1X_KEY],
          ...getActualDimensions(source.value, source.dimension, DPR_1X),
        },
        [DPR_2X_KEY]: {
          src: sources[label].densities[DPR_2X_KEY],
          ...getActualDimensions(source.value, source.dimension, DPR_2X),
        },
        [DPR_3X_KEY]: {
          src: sources[label].densities[DPR_3X_KEY],
          ...getActualDimensions(source.value, source.dimension, DPR_3X),
        },
      },
    }),
    {},
  );

  const getStringifiedDensity = (key, entry) => {
    return `"${key}": { src: ${entry.src}, width: ${entry.width}, height: ${entry.height} }`;
  };

  const stringifiedSrcsets = Object.entries(srcsets)
    .map(([label, srcset]) => {
      const dpr1x = getStringifiedDensity(DPR_1X_KEY, srcset[DPR_1X_KEY]);
      const dpr2x = getStringifiedDensity(DPR_2X_KEY, srcset[DPR_2X_KEY]);
      const dpr3x = getStringifiedDensity(DPR_3X_KEY, srcset[DPR_3X_KEY]);
      return `${label}: { ${dpr1x}, ${dpr2x}, ${dpr3x} }`;
    })
    .join(", ");

  return `module.exports = { srcset: { ${stringifiedSrcsets} }, fallback: ${fallback}, placeholder: ${placeholder}, width: ${dimensions.width}, height: ${dimensions.height}, aspectRatio: ${aspectRatio}, orientation: "${orientation}" }`;
}
