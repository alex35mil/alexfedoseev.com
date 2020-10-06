const fs = require("fs");
const path = require("path");
const babel = require("@babel/parser");
const glob = require("fast-glob");
const { Client } = require("fb-watchman");

const sources = require("../photo.json");

const root = process.cwd();
const photosDir = path.join(root, "src", "photos");
const photoFiles = path.join(photosDir, "files");
const PhotosRe = path.join(photosDir, "Photos.re");

const IS_PRODUCTION = process.env.NODE_ENV === "production";

const N = parseInt(process.argv[process.argv.length - 1], 10);

const shouldWatch = () => process.argv.includes("--watch") || process.argv.includes("-w");

const originalLetBinding = photoId => `photo_${photoId}`;
const thumbLetBinding = photoId => `photo_${photoId}_thumb`;

const mod = (requires, entries) =>
  `/* === GENERATED CONTENT === */

${requires}

let all = [|
${entries}
|];
`;

const write = () => {
  const photos = glob.sync(sources).map(photo => ({
    id: path
      .basename(photo, ".jpg")
      .toLowerCase()
      .replace("_", "")
      .replace("-", "_"),
    file: path.basename(photo),
  }));

  if (!!N) {
    shuffle(photos).splice(0, photos.length - N);
  }

  const requires = photos
    .map(photo => {
      const original = originalLetBinding(photo.id);
      const thumb = thumbLetBinding(photo.id);
      const path = `./files/${photo.file}`;
      return [
        `let ${original}: Photo.src = [%bs.raw "require('${path}?preset=photo')"];`,
        `let ${thumb}: Photo.thumb = [%bs.raw "require('${path}?preset=gridThumb')"];`,
      ].join("\n");
    })
    .join("\n");

  const entries = photos
    .map(photo => {
      const original = originalLetBinding(photo.id);
      const thumb = thumbLetBinding(photo.id);
      return `  ("${photo.id}"->Photo.Id.pack, ${original}, ${thumb}),`;
    })
    .join("\n");

  fs.writeFileSync(PhotosRe, mod(requires, entries), "utf8");
  console.log(`✅ Photos.re is written`);
};

const watch = () => {
  const client = new Client();

  client.capabilityCheck({ optional: [], required: ["relative_root"] }, (err, _res) => {
    if (err) {
      console.log("[ERROR]:", err);
      client.end();
      return;
    }

    client.command(["watch-project", root], (err, res) => {
      if (err) {
        console.error("[ERROR] Failed to watch project:", err);
        return;
      }

      if ("warning" in res) {
        console.log("[WARNING]:", res.warning);
      }

      console.log("Watching", res.watch);

      const SUBSCRIPTION_ID = "PHOTO";
      const SUBSCRIPTION_PARAMS = {
        expression: ["anyof", ...sources.map(src => ["match", src, "wholename"])],
        fields: ["name", "size", "exists", "type"],
      };

      if (res.relative_path) {
        SUBSCRIPTION_PARAMS.relative_root = res.relative_path;
      }

      client.command(["subscribe", res.watch, SUBSCRIPTION_ID, SUBSCRIPTION_PARAMS], (err, res) => {
        if (err) {
          console.error("[ERROR] Failed to subscribe:", err);
          return;
        }
      });

      client.on("subscription", res => {
        if (res.subscription !== SUBSCRIPTION_ID) return;
        write();
      });
    });
  });
};

function shuffle(arr) {
  for (let i = arr.length - 1; i > 0; i--) {
    const j = Math.floor(Math.random() * (i + 1));
    [arr[i], arr[j]] = [arr[j], arr[i]];
  }
  return arr;
}

if (shouldWatch()) {
  watch();
} else {
  write();
}
