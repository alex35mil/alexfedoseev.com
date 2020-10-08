open PostCover;
open PostCategory;

[@bs.module] external cover: PostCover.src = "./images/cover.jpg?preset=cover";

let title = "Isomorphic React with Rails";
let slug = "isomorphic-react-with-rails";
let year = "2015";
let date = "Sep 12";
let category = Dev;
let cover =
  Some({
    src: cover,
    credit:
      Some({
        text: "Blueprint of Victory",
        url:
          Some(
            "https://commons.wikimedia.org/wiki/File:Blueprint_of_Victory_-_NARA_-_534555.jpg"
            ->ReactRouter.Path.pack,
          ),
      }),
    titleBgColor: Blue,
  });
let loader = () => Module.import("./Post__2015_IsomorphicReactWithRails.mdx");
