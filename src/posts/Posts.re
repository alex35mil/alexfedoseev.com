type entry = {
  title: string,
  slug: string,
  date: string,
  loader: unit => Promise.t(Module.js),
};

let from2019 = [|
  {
    slug: "minima",
    title: "Minima",
    date: "Jun 10",
    loader: () => Module.import("./2019/Minima/Post__Minima.mdx"),
  },
|];

let from2018 = [|
  {
    slug: "reasonml-eliminating-illegal-state",
    title: "ReasonML: Eliminating illegal state",
    date: "Mar 22",
    loader: () =>
      Module.import(
        "./2018/ReasonEliminatingIllegalState/Post__ReasonEliminatingIllegalState.mdx",
      ),
  },
  {
    slug: "reasonml-modules",
    title: "ReasonML: Modules",
    date: "Mar 13",
    loader: () =>
      Module.import("./2018/ReasonModules/Post__ReasonModules.mdx"),
  },
|];

let from2017 = [|
  {
    slug: "tableau",
    title: "Tableau",
    date: "Aug 10",
    loader: () => Module.import("./2017/Tableau/Post__Tableau.mdx"),
  },
  {
    slug: "redux-tree",
    title: "Redux Tree",
    date: "Mar 18",
    loader: () => Module.import("./2017/ReduxTree/Post__ReduxTree.mdx"),
  },
  {
    slug: "enums-using-immutable-records-and-flow",
    title: "Bulletproof Enums using Immutable Records and Flow",
    date: "Mar 13",
    loader: () =>
      Module.import(
        "./2017/EnumsUsingImmutableRecordsAndFlow/Post__EnumsUsingImmutableRecordsAndFlow.mdx",
      ),
  },
  {
    slug: "year-of-development-with-redux-part-3",
    title: "A Year of development with Redux. Part III",
    date: "Feb 28",
    loader: () =>
      Module.import(
        "./2017/YearOfDevelopmentWithReduxPartIII/Post__YearOfDevelopmentWithReduxPartIII.mdx",
      ),
  },
  {
    slug: "year-of-development-with-redux-part-2",
    title: "A Year of development with Redux. Part II",
    date: "Jan 20",
    loader: () =>
      Module.import(
        "./2017/YearOfDevelopmentWithReduxPartII/Post__YearOfDevelopmentWithReduxPartII.mdx",
      ),
  },
  {
    slug: "year-of-development-with-redux-part-1",
    title: "A Year of development with Redux. Part I",
    date: "Jan 10",
    loader: () =>
      Module.import(
        "./2017/YearOfDevelopmentWithReduxPartI/Post__YearOfDevelopmentWithReduxPartI.mdx",
      ),
  },
|];

let from2016 = [|
  {
    slug: "yeoman-generator-es6",
    title: "Yo, ES6",
    date: "Jan 11",
    loader: () => Module.import("./2016/YoES6/Post__YoES6.mdx"),
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
  ("2017", from2017),
  ("2016", from2016),
  ("2015", from2015),
|];

let all =
  byYear->Array.reduce([||], (acc, (_, posts)) => acc->Array.concat(posts));
