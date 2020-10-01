type entry = {
  title: string,
  slug: string,
  year: string,
  date: string,
  category: PostCategory.t,
  cover: option(PostCover.t),
  loader: unit => Promise.t(Module.js),
};

let all = [|
  // 2020
  {
    slug: "reasonml-safe-routing",
    title: "ReasonML: Safe Routing",
    year: "2020",
    date: "Jan 4",
    category: Dev,
    cover: None,
    loader: () =>
      Module.import("./2020/ReasonSafeRouting/Post__ReasonSafeRouting.mdx"),
  },
  {
    slug: "reasonml-safe-identifiers",
    title: "ReasonML: Safe Identifiers",
    year: "2020",
    date: "Jan 1",
    category: Dev,
    cover: None,
    loader: () =>
      Module.import(
        "./2020/ReasonSafeIdentifiers/Post__ReasonSafeIdentifiers.mdx",
      ),
  },
  // 2019
  {
    slug: "minima",
    title: "Minima",
    year: "2019",
    date: "Jun 10",
    category: Dev,
    cover: None,
    loader: () => Module.import("./2019/Minima/Post__Minima.mdx"),
  },
  // 2018
  {
    slug: "reasonml-eliminating-illegal-state",
    title: "ReasonML: Eliminating illegal state",
    year: "2018",
    date: "Mar 22",
    category: Dev,
    cover: None,
    loader: () =>
      Module.import(
        "./2018/ReasonEliminatingIllegalState/Post__ReasonEliminatingIllegalState.mdx",
      ),
  },
  {
    slug: "reasonml-modules",
    title: "ReasonML: Modules",
    year: "2018",
    date: "Mar 13",
    category: Dev,
    cover: None,
    loader: () =>
      Module.import("./2018/ReasonModules/Post__ReasonModules.mdx"),
  },
  // 2017
  {
    slug: "tableau",
    title: "Tableau",
    year: "2017",
    date: "Aug 10",
    category: Dev,
    cover: PostTableau.cover->Some,
    loader: () => Module.import("./2017/Tableau/Post__Tableau.mdx"),
  },
  {
    slug: "redux-tree",
    title: "Redux Tree",
    year: "2017",
    date: "Mar 18",
    category: Dev,
    cover: PostReduxTree.cover->Some,
    loader: () => Module.import("./2017/ReduxTree/Post__ReduxTree.mdx"),
  },
  {
    slug: "enums-using-immutable-records-and-flow",
    title: "Bulletproof Enums using Immutable Records and Flow",
    year: "2017",
    date: "Mar 13",
    category: Dev,
    cover: None,
    loader: () =>
      Module.import(
        "./2017/EnumsUsingImmutableRecordsAndFlow/Post__EnumsUsingImmutableRecordsAndFlow.mdx",
      ),
  },
  {
    slug: "year-of-development-with-redux-part-3",
    title: "A Year of development with Redux. Part III",
    year: "2017",
    date: "Feb 28",
    category: Dev,
    cover: None,
    loader: () =>
      Module.import(
        "./2017/YearOfDevelopmentWithReduxPartIII/Post__YearOfDevelopmentWithReduxPartIII.mdx",
      ),
  },
  {
    slug: "year-of-development-with-redux-part-2",
    title: "A Year of development with Redux. Part II",
    year: "2017",
    date: "Jan 20",
    category: Dev,
    cover: None,
    loader: () =>
      Module.import(
        "./2017/YearOfDevelopmentWithReduxPartII/Post__YearOfDevelopmentWithReduxPartII.mdx",
      ),
  },
  {
    slug: "year-of-development-with-redux-part-1",
    title: "A Year of development with Redux. Part I",
    year: "2017",
    date: "Jan 10",
    category: Dev,
    cover: None,
    loader: () =>
      Module.import(
        "./2017/YearOfDevelopmentWithReduxPartI/Post__YearOfDevelopmentWithReduxPartI.mdx",
      ),
  },
  // 2016
  {
    slug: "yeoman-generator-es6",
    title: "Yo, ES6",
    year: "2016",
    date: "Jan 11",
    category: Dev,
    cover: None,
    loader: () => Module.import("./2016/YoES6/Post__YoES6.mdx"),
  },
  // 2015
  {
    slug: "isomorphic-react-with-rails",
    title: "Isomorphic React with Rails",
    year: "2015",
    date: "Sep 12",
    category: Dev,
    cover: Some(PostIsomorphicReactWithRails.cover),
    loader: () =>
      Module.import(
        "./2015/IsomorphicReactWithRails/Post__IsomorphicReactWithRails.mdx",
      ),
  },
|];

type byYear = array((string, array(entry)));

let byYear = (posts): byYear => {
  posts->Array.reduce([||], (acc, post) =>
    switch (acc->Array.get(acc->Array.length - 1)) {
    | None =>
      acc->Js.Array2.push((post.year, [|post|]))->ignore;
      acc;
    | Some((year, _posts)) when year != post.year =>
      acc->Js.Array2.push((post.year, [|post|]))->ignore;
      acc;
    | Some((_year, posts)) =>
      posts->Js.Array2.push(post)->ignore;
      acc;
    }
  );
};

let allByYear = () => all->byYear;

let categoryByYear = category =>
  all->Array.keep(post => PostCategory.(post.category == category))->byYear;
