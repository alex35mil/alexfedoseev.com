type entry = {
  title: string,
  slug: string,
  loader: unit => Promise.t(Module.js),
};

let year2019 = [|
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

let all = Array.concatMany([|year2019|]);
