type entry = {
  title: string,
  slug: string,
  loader: unit => Promise.t(Module.js),
};

let from2018 = [|
  {
    slug: "post-1",
    title: "Post #1",
    loader: () => Module.import("./Post1/Post1.mdx"),
  },
  {
    slug: "post-2",
    title: "Post #2",
    loader: () => Module.import("./Post2/Post2.mdx"),
  },
|];

let from2019 = [|
  {
    slug: "post-1",
    title: "Post #1",
    loader: () => Module.import("./Post1/Post1.mdx"),
  },
  {
    slug: "post-2",
    title: "Post #2",
    loader: () => Module.import("./Post2/Post2.mdx"),
  },
|];

let byYear = [|("2019", from2019), ("2018", from2018)|];

let all =
  byYear->Array.reduce([||], (acc, (_, posts)) => acc->Array.concat(posts));
