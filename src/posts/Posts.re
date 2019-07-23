type entry = {
  title: string,
  slug: string,
  date: string,
  loader: unit => Promise.t(Module.js),
};

let from2019 = [|
  {
    slug: "post-2019-1",
    title: "Lorem ipsum dolor sit amet",
    date: "Jun 10",
    loader: () => Module.import("./Post1/Post1.mdx"),
  },
  {
    slug: "post-2019-2",
    title: "Duis in magna mi",
    date: "March 07",
    loader: () => Module.import("./Post2/Post2.mdx"),
  },
|];

let from2018 = [|
  {
    slug: "post-2018-1",
    title: "Curabitur sed nisl sodales",
    date: "Apr 12",
    loader: () => Module.import("./Post1/Post1.mdx"),
  },
  {
    slug: "post-2018-2",
    title: "Etiam sit amet accumsan lorem",
    date: "Jan 21",
    loader: () => Module.import("./Post2/Post2.mdx"),
  },
|];

let from2015 = [|
  {
    slug: "isomorphic-react-with-rails",
    title: "Isomorphic React with Rails",
    date: "Sep 12",
    loader: () =>
      Module.import(
        "./2015/IsomorphicReactWithRails/Post__IsomorphicReactWithRails.mdx",
      ),
  },
|];

let byYear = [|
  ("2019", from2019),
  ("2018", from2018),
  ("2015", from2015),
|];

let all =
  byYear->Array.reduce([||], (acc, (_, posts)) => acc->Array.concat(posts));
