const cp = require("child_process");
const path = require("path");
const util = require('util');
const sharp = require("sharp");
const loaderUtils = require("loader-utils");

const exec = util.promisify(cp.exec);

const { ENV, BIN, IMAGES_DIR } = process.env;

const SRCSET = {
  W: "w",
  X: "x",
  RAW: "raw",
};

const DIMENSION = {
  WIDTH: "width",
  HEIGHT: "height",
};

const ORIENTATION = {
  LANDSCAPE: "landscape",
  PORTRAIT: "portrait",
  SQUARE: "square",
};

const DPR = {
  MAX: 3,
  ALL: () => [...Array(DPR.MAX + 1).keys()].slice(1),
  KEY: dpr => `@${dpr}x`,
};

module.exports = function(source) {
  return source;
};

module.exports.pitch = async function(request) {
  if (!this.resourceQuery) {
    throw new Error(`[image-loader] Preset is not provided for ${this.resourcePath}`);
  }

  let loc = path.relative(IMAGES_DIR, this.resourcePath);
  let dimensions = await sharp(this.resourcePath).metadata();
  let query = loaderUtils.parseQuery(this.resourceQuery);
  let options = loaderUtils.getOptions(this);
  let preset = options.presets[query.preset];

  if (!preset) {
    throw new Error(`[image-loader] Preset is not specified in the webpack config`);
  }

  if (preset.srcsets === undefined) {
    throw new Error(`[image-loader] srcsets is not set. Check preset "${query.preset}".`);
  }

  if (preset.srcsets === true) {
    throw new Error(`[image-loader] srcsets can't be set to true. It must be either an array of srcsets or false. Check preset "${query.preset}".`);
  }

  let placeholder = preset.placeholder ? await renderPlaceholder(loc) : null;

  if (preset.srcsets === false) {
    let url = await signUrl(loc, {width: dimensions.width, height: dimensions.height});
    return `module.exports = { src: ${JSON.stringify(url)}, placeholder: ${placeholder}, width: ${dimensions.width}, height: ${dimensions.height} }`;
  }

  let srcsets = {};
  let fallback = "";

  let dprs = DPR.ALL();

  for (let srcset of preset.srcsets) {
    if (!srcset.type) {
      throw new Error(`[image-loader] srcset type is required. Check preset "${query.preset}".`);
    }

    switch (srcset.type) {
      case SRCSET.X:
        let size = normalizeSize(srcset.size, dimensions);

        let urls = await Promise.all(
          dprs.map(dpr => signUrl(loc, calculateSize(size.value, size.dimension, dimensions, dpr))),
        );
        let result = zip(urls, dprs).map(([url, dpr]) => dpr === 1 ? url : `${url} ${dpr}x`).join(", ");

        if (srcset.fallback) {
          if (!!fallback) {
            throw new Error(`[image-loader] Multiple fallbacks. Check preset "${query.preset}".`);
          }

          fallback = urls[0];
        }

        if (!!srcsets[size.label]) {
          throw new Error(`[image-loader] Duplicated label "${size.label}". Check preset "${query.preset}".`);
        }

        srcsets[size.label] = result;

        break;

      case SRCSET.W:
        if (!srcset.label) {
          throw new Error(`[image-loader] srcset with type "w" must have a label. Check preset "${query.preset}".`);
        }

        let results = [];

        for (let item of srcset.widths) {
          let width = normalizeWidth(item);

          let urls = await Promise.all(
            dprs.map(dpr => signUrl(loc, calculateSize(width.value, DIMENSION.WIDTH, dimensions, dpr))),
          );
          let result = zip(urls, dprs).map(([url, dpr]) => `${url} ${width.value * dpr}w`).join(", ");

          if (width.fallback) {
            if (!!fallback) {
              throw new Error(`[image-loader] Multiple fallbacks. Check preset "${query.preset}".`);
            }

            fallback = urls[0];
          }

          results.push(result);
        }

        if (!!srcsets[srcset.label]) {
          throw new Error(`[image-loader] Duplicated label "${srcset.label}". Check preset "${query.preset}".`);
        }

        srcsets[srcset.label] = results.join(", ");

        break;

      case SRCSET.RAW:
        let dprset = {};

        for (let dpr of dprs) {
          let size = calculateSize(srcset.width, DIMENSION.WIDTH, dimensions, dpr);
          let src = await signUrl(loc, size);
          dprset[DPR.KEY(dpr)] = { ...size, src };
        }

        if (srcset.fallback) {
          if (!!fallback) {
            throw new Error(`[image-loader] Multiple fallbacks. Check preset "${query.preset}".`);
          }

          fallback = dprset[DPR.KEY(1)].src;
        }

        if (!srcset.label) {
          throw new Error(`[image-loader] srcset with type "raw" must have a label. Check preset "${query.preset}".`);
        }

        if (!!srcsets[srcset.label]) {
          throw new Error(`[image-loader] Duplicated label "${srcset.label}". Check preset "${query.preset}".`);
        }

        srcsets[srcset.label] = dprset;

        break;
      default:
        throw new Error(`[image-loader] Unknown srcset type "${srcset.type}". Check preset "${query.preset}".`);
    }
  }

  if (!fallback) {
    throw new Error(`[image-loader] Fallback size wasn't set. Check preset "${query.preset}".`);
  }

  let aspectRatio = dimensions.width / dimensions.height;
  let orientation = aspectRatio > 1 ? ORIENTATION.LANDSCAPE : aspectRatio < 1 ? ORIENTATION.PORTRAIT : ORIENTATION.SQUARE;

  return `module.exports = { srcsets: ${JSON.stringify(srcsets)}, fallback: ${JSON.stringify(fallback)}, placeholder: ${placeholder}, width: ${dimensions.width}, height: ${dimensions.height}, aspectRatio: ${aspectRatio}, orientation: "${orientation}" }`;
}

const zip = (a, b) => a.map((k, i) => [k, b[i]]);

function normalizeSize(size, dimensions) {
  if (typeof size === "number") {
    return { label: size.toString(), dimension: DIMENSION.WIDTH, value: size };
  } else {
    if (size.width && !size.height) {
      return { label: size.label, dimension: DIMENSION.WIDTH, value: size.width };
    } else if (!size.width && size.height) {
      return { label: size.label, dimension: DIMENSION.HEIGHT, value: size.height };
    } else if (size.width && size.height) {
      return dimensions.width > dimensions.height
        ? { label: size.label, dimension: DIMENSION.WIDTH, value: size.width }
        : { label: size.label, dimension: DIMENSION.HEIGHT, value: size.height };
    } else {
      throw new Error(`[image-loader] Invalid size object: ${JSON.stringify(size)}`);
    }
  }
}

function normalizeWidth(width) {
  if (typeof width === "number") {
    return { value: width, fallback: false };
  } else {
    return width;
  }
}

function calculateSize(value, dimension, dimensions, dpr) {
  let size = value * dpr;
  switch (dimension) {
    case DIMENSION.WIDTH:
      return size < dimensions.width
        ? {
            width: size,
            height: Math.round((size * dimensions.height) / dimensions.width),
          }
        : {
            width: dimensions.width,
            height: dimensions.height,
          };

    case DIMENSION.HEIGHT:
      return size < dimensions.height
        ? {
            width: Math.round((size * dimensions.width) / dimensions.height),
            height: size,
          }
        : {
            width: dimensions.width,
            height: dimensions.height,
          };

    default:
      throw new Error(`[image-loader] Unexpected dimension: ${dimension}`);
  }
}

async function signUrl(loc, {width, height}) {
  try {
    let { stdout } = await exec(
      `${BIN} img sign-url --width=${width} --height=${height} --env=${ENV} ${loc}`,
    );
    return stdout.trim();
  } catch (err) {
    throw new Error(`[image-loader] Failed to sign URL for ${loc}: ${err}`);
  }
}

async function renderPlaceholder(loc) {
  try {
    let { stdout } = await exec(`${BIN} img render-placeholder ${loc}`);
    let svg = encodeURIComponent(stdout.trim());
    return `"data:image/svg+xml,${svg}"`;
  } catch (err) {
    throw new Error(`[image-loader] Failed to render placeholder of ${loc}: ${err}`);
  }
}
