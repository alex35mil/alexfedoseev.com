[@bs.module] external cover: PostCover.src = "./images/cover.jpg?preset=cover";

let cover = {
  PostCover.src: cover,
  credit:
    Some({
      text: "veeterzy.com",
      url: Some("http://veeterzy.com"->ReactRouter.Path.pack),
    }),
  titleBgColor: Blue,
};
