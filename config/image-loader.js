const cp = require("child_process");
const path = require("path");
const util = require('util');
const sharp = require("sharp");
const loaderUtils = require("loader-utils");

const exec = util.promisify(cp.exec);

const { ENV, BIN, IMAGES_DIR } = process.env;

const PRESET = {
  BASIC: "basic",
  FLUID: "fluid",
  FIXED: "fixed",
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
    throw new Error(`[image-loader] Preset is not provided in webpack config`);
  }

  if (!preset.type) {
    throw new Error(`[image-loader] Preset type is required`);
  }

  if (!Object.values(PRESET).includes(preset.type)) {
    throw new Error(`[image-loader] Unknown preset type "${preset.type}"`);
  }

  if (preset.type === PRESET.BASIC) {
    return await exportBasic(loc, preset, dimensions);
  }

  if (!preset.fallback) {
    throw new Error(`[image-loader] Fallback size is required`);
  }

  let sizes = normalizeSizes(preset.sizes, dimensions);
  let aspectRatio = dimensions.width / dimensions.height;
  let orientation = aspectRatio > 1 ? ORIENTATION.LANDSCAPE : aspectRatio < 1 ? ORIENTATION.PORTRAIT : ORIENTATION.SQUARE;

  let sources = sizes.reduce(
    (dict, size) => ({
      ...dict,
      [size.label]: {
        value: size.value,
        dimension: size.dimension,
      },
    }),
    {},
  );

  switch (preset.type) {
    case PRESET.FIXED:
      return await exportFixed(
        loc,
        preset,
        sources,
        dimensions,
        aspectRatio,
        orientation,
      );
    case PRESET.FLUID:
      return await exportFluid(
        loc,
        preset,
        sources,
        dimensions,
        aspectRatio,
        orientation,
      );
    case PRESET.RAW:
      return await exportRaw(
        loc,
        preset,
        sources,
        dimensions,
        aspectRatio,
        orientation,
      );
    default:
      throw new Error(`[image-loader] Unknown preset type "${preset.type}"`);
  }
}

async function exportBasic(loc, preset, dimensions) {
  let url = await signUrl(loc, {width: dimensions.width, height: dimensions.height});
  let placeholder = await renderPlaceholder(loc, preset.placeholder);
  return `module.exports = ${JSON.stringify({src: url, placeholder})}`;
}

async function exportFixed(
  loc,
  preset,
  sources,
  dimensions,
  aspectRatio,
  orientation,
) {
  let dprs = DPR.ALL();
  let srcs = Object.entries(sources);
  let presetFallback = preset.fallback.toString();

  let srcset = {};
  let fallback = "";

  for (let i = 0; i < srcs.length; i++) {
    let [label, source] = srcs[i];
    let urls = await Promise.all(
      dprs.map(dpr => signUrl(loc, calculateSize(source.value, source.dimension, dimensions, dpr))),
    );
    let html = zip(urls, dprs).map(([url, dpr]) => dpr === 1 ? url : `${url} ${dpr}x`).join(", ");

    if (label === presetFallback) fallback = urls[0];
    srcset[label] = html;
  }

  if (!fallback) {
    throw new Error(`[image-loader] Fallback image wasn't set: ${loc} (${preset.type})`);
  }

  let placeholder = await renderPlaceholder(loc, preset.placeholder);

  return `module.exports = { srcset: ${JSON.stringify(srcset)}, fallback: ${JSON.stringify(fallback)}, placeholder: ${placeholder}, width: ${dimensions.width}, height: ${dimensions.height}, aspectRatio: ${aspectRatio}, orientation: "${orientation}" }`;
}

async function exportFluid(
  loc,
  preset,
  sources,
  dimensions,
  aspectRatio,
  orientation,
) {
  let dprs = DPR.ALL();
  let srcs = Object.entries(sources);
  let presetFallback = preset.fallback.toString();

  let srcset = [];
  let fallback = "";

  for (let i = 0; i < srcs.length; i++) {
    let [label, source] = srcs[i];

    if (source.dimension === DIMENSION.HEIGHT) {
      throw new Error(`[image-loader] Fliud images must have dimension "width". Label: "${label}"`);
    }
    let urls = await Promise.all(
      dprs.map(dpr => signUrl(loc, calculateSize(source.value, source.dimension, dimensions, dpr))),
    );
    let html = zip(urls, dprs).map(([url, dpr]) => `${url} ${source.value * dpr}w`).join(", ");

    if (label === presetFallback) fallback = urls[0];
    srcset.push(html);
  }

  if (!fallback) {
    throw new Error(`[image-loader] Fallback image wasn't set: ${loc} (${preset.type})`);
  }

  let placeholder = await renderPlaceholder(loc, preset.placeholder);

  return `module.exports = { srcset: ${JSON.stringify(srcset.join(", "))}, fallback: ${JSON.stringify(fallback)}, placeholder: ${placeholder}, width: ${dimensions.width}, height: ${dimensions.height}, aspectRatio: ${aspectRatio}, orientation: "${orientation}" }`;
}

async function exportRaw(
  loc,
  preset,
  sources,
  dimensions,
  aspectRatio,
  orientation,
) {
  let dprs = DPR.ALL();
  let srcs = Object.entries(sources);
  let presetFallback = preset.fallback.toString();

  let srcset = {};
  let fallback = "";

  for (let i = 0; i < srcs.length; i++) {
    let [label, source] = srcs[i];

    let dprset = {};

    for (let dpr of dprs) {
      let size = calculateSize(source.value, source.dimension, dimensions, dpr);
      let src = await signUrl(loc, size);
      dprset[DPR.KEY(dpr)] = { ...size, src };
    }

    if (label === presetFallback) fallback = dprset[DPR.KEY(1)].src;
    srcset[label] = dprset;
  }

  if (!fallback) {
    throw new Error(`[image-loader] Fallback image wasn't set: ${loc} (${preset.type})`);
  }

  let placeholder = await renderPlaceholder(loc, preset.placeholder);

  return `module.exports = { srcset: ${JSON.stringify(srcset)}, fallback: ${JSON.stringify(fallback)}, placeholder: ${placeholder}, width: ${dimensions.width}, height: ${dimensions.height}, aspectRatio: ${aspectRatio}, orientation: "${orientation}" }`;
}

const zip = (a, b) => a.map((k, i) => [k, b[i]]);

function normalizeSizes(sizes, dimensions) {
  return sizes.map(entry => {
    if (typeof entry === "number") {
      return { label: entry.toString(), dimension: DIMENSION.WIDTH, value: entry };
    } else {
      if (entry.width && !entry.height) {
        return { label: entry.label, dimension: DIMENSION.WIDTH, value: entry.width };
      } else if (!entry.width && entry.height) {
        return { label: entry.label, dimension: DIMENSION.HEIGHT, value: entry.height };
      } else if (entry.width && entry.height) {
        return dimensions.width > dimensions.height
          ? { label: entry.label, dimension: DIMENSION.WIDTH, value: entry.width }
          : { label: entry.label, dimension: DIMENSION.HEIGHT, value: entry.height };
      } else {
        throw new Error(`[image-loader] Invalid size object: ${JSON.stringify(entry)}`);
      }
    }
  });
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

async function renderPlaceholder(loc, opts) {
  if (!opts) return null;
  try {
    let { stdout } = await exec(`${BIN} img render-placeholder ${loc}`);
    let svg = encodeURIComponent(stdout.trim());
    return `"data:image/svg+xml,${svg}"`;
  } catch (err) {
    throw new Error(`[image-loader] Failed to render placeholder of ${loc}: ${err}`);
  }
}
