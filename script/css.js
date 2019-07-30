const fs = require("fs");
const path = require("path");
const babel = require("@babel/parser");
const glob = require("fast-glob");
const { Client } = require("fb-watchman");

const sources = require("../css.json");

const root = process.cwd();

const shouldWatch = () =>
  process.argv.includes("--watch") || process.argv.includes("-w");

const extract = files => {
  const STRING = "string";
  const INT = "int";
  const FLOAT = "float";

  files
    .map(file => {
      const source = fs.readFileSync(file, "utf8");

      let ast;
      try {
        ast = babel.parse(source, { sourceType: "module" });
      } catch (error) {
        console.error(`❌ ${file}:`, error);
        return null;
      }

      const externals = ast.program.body.reduce((acc, node) => {
        const decl =
          node.declaration &&
          node.declaration.declarations &&
          node.declaration.declarations[0];

        if (
          decl &&
          node.type === "ExportNamedDeclaration" &&
          node.declaration.type === "VariableDeclaration" &&
          [
            "StringLiteral",
            "TemplateLiteral",
            "NumericLiteral",
            "TaggedTemplateExpression",
          ].includes(decl.init.type)
        ) {
          switch (decl.init.type) {
            case "StringLiteral":
            case "TemplateLiteral":
              return acc.concat({
                id: decl.id.name,
                type: STRING,
              });
            case "NumericLiteral":
              return acc.concat({
                id: decl.id.name,
                type: decl.init.extra.raw.includes(".") ? FLOAT : INT,
              });
            case "TaggedTemplateExpression":
              if (
                decl.init.tag &&
                decl.init.tag.name &&
                decl.init.tag.name === "css"
              ) {
                return acc.concat({
                  id: decl.id.name,
                  type: STRING,
                });
              } else {
                console.log("[WARNING]: Non-css TaggedTemplateExpression");
                console.log(decl);
                return acc;
              }
            default:
              return acc;
          }
        } else {
          return acc;
        }
      }, []);
      return { file, externals };
    })
    .forEach(css => {
      if (!css) return;

      const dir = path.dirname(css.file);
      const mod = path.basename(css.file, ".js");
      const file = `${dir}/${mod}.re`;
      const banner = "/* === GENERATED CONTENT === */\n\n";
      const externals = css.externals
        .map(
          external =>
            `[@bs.module "./${mod}.js"] external ${external.id}: ${external.type} = "${external.id}";\n` +
            `let ${external.id} = ${external.id};\n`,
        )
        .join("\n");

      fs.writeFileSync(file, banner + externals, "utf8");
      console.log(`✅ ${file}`);
    });
};

const cleanup = files => {
  files.forEach(fileJs => {
    const dir = path.dirname(fileJs);
    const mod = path.basename(fileJs, ".js");
    const fileRe = `${dir}/${mod}.re`;
    fs.unlink(fileRe, err => {
      if (err) {
        console.error("[ERROR] Failed to remove file:", err);
        return;
      }
      console.log(`🗑  ${fileRe}`);
    });
  });
};

const extractAll = () => {
  extract(glob.sync(sources));
};

const watchAll = () => {
  const client = new Client();

  client.capabilityCheck(
    { optional: [], required: ["relative_root"] },
    (err, _res) => {
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

        const SUBSCRIPTION_ID = "CSS";
        const SUBSCRIPTION_PARAMS = {
          expression: [
            "anyof",
            ...sources.map(src => ["match", src, "wholename"]),
          ],
          fields: ["name", "size", "exists", "type"],
        };

        if (res.relative_path) {
          SUBSCRIPTION_PARAMS.relative_root = res.relative_path;
        }

        client.command(
          ["subscribe", res.watch, SUBSCRIPTION_ID, SUBSCRIPTION_PARAMS],
          (err, res) => {
            if (err) {
              console.error("[ERROR] Failed to subscribe:", err);
              return;
            }
          },
        );

        client.on("subscription", res => {
          if (res.subscription !== SUBSCRIPTION_ID) return;
          const [updated, deleted] = res.files.reduce(
            ([updated, deleted], file) => {
              if (file.exists) {
                updated.push(file.name);
              } else {
                deleted.push(file.name);
              }
              return [updated, deleted];
            },
            [[], []],
          );
          if (updated.length > 0) extract(updated);
          if (deleted.length > 0) cleanup(deleted);
        });
      });
    },
  );
};

if (shouldWatch()) {
  watchAll();
} else {
  extractAll();
}
