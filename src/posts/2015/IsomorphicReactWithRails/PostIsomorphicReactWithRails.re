[@bs.module] external cover: PostCover.src = "./images/cover.jpg?preset=cover";

let cover = {
  PostCover.src: cover,
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
};
