open PostCover;
open PostCategory;

[@bs.module] external cover: PostCover.src = "./images/cover.jpg?preset=cover";

let title = "Tableau";
let slug = "tableau";
let year = "2017";
let date = "Aug 10";
let category = Dev;
let cover = Some({src: cover, credit: None, titleBgColor: Blue});
let loader = () => Module.import("./Post__2017_Tableau.mdx");
