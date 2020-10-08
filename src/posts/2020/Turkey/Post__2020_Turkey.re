open PostCover;
open PostCategory;

[@bs.module]
external cover: PostCover.src = "./images/20201001-DSC03210.jpg?preset=cover";

let title = "Turkey";
let slug = "turkey";
let year = "2020";
let date = "Oct 8";
let category = Travel;
let cover = Some({src: cover, credit: None, titleBgColor: Orange});
let loader = () => Module.import("./Post__2020_Turkey.mdx");
