open PostCover;
open PostCategory;

[@bs.module] external cover: PostCover.src = "./images/cover.jpg?preset=cover";

let title = "Redux Tree";
let slug = "redux-tree";
let year = "2017";
let date = "Mar 18";
let category = Dev;
let cover =
  Some({
    src: cover,
    credit:
      Some({
        text: "veeterzy.com",
        url: Some("http://veeterzy.com"->ReactRouter.Path.pack),
      }),
    titleBgColor: Blue,
  });
let loader = () => Module.import("./Post__2017_ReduxTree.mdx");
