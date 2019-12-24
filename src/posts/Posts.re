type entry = {
  title: string,
  slug: string,
  year: string,
  date: string,
  loader: unit => Promise.t(Module.js),
};

let all = [|
  // 2019
  {
    slug: "minima",
    title: "Minima",
    year: "2019",
    date: "Jun 10",
    loader: () => Module.import("./2019/Minima/Post__Minima.mdx"),
  },
  // 2018
  {
    slug: "reasonml-eliminating-illegal-state",
    title: "ReasonML: Eliminating illegal state",
    year: "2018",
    date: "Mar 22",
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
    loader: () =>
      Module.import("./2018/ReasonModules/Post__ReasonModules.mdx"),
  },
  // 2017
  {
    slug: "tableau",
    title: "Tableau",
    year: "2017",
    date: "Aug 10",
    loader: () => Module.import("./2017/Tableau/Post__Tableau.mdx"),
  },
  {
    slug: "redux-tree",
    title: "Redux Tree",
    year: "2017",
    date: "Mar 18",
    loader: () => Module.import("./2017/ReduxTree/Post__ReduxTree.mdx"),
  },
  {
    slug: "enums-using-immutable-records-and-flow",
    title: "Bulletproof Enums using Immutable Records and Flow",
    year: "2017",
    date: "Mar 13",
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
    loader: () => Module.import("./2016/YoES6/Post__YoES6.mdx"),
  },
  // 2015
  {
    slug: "isomorphic-react-with-rails",
    title: "Isomorphic React with Rails",
    year: "2015",
    date: "Sep 12",
    loader: () =>
      Module.import(
        "./2015/IsomorphicReactWithRails/Post__IsomorphicReactWithRails.mdx",
      ),
  },
|];

let byYear: ref(option(array((string, array(entry))))) = None->ref;

let byYear = () =>
  switch (byYear^) {
  | Some(x) => x
  | None =>
    let res =
      all->Array.reduce([||], (acc, post) => {
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
      });
    byYear := res->Some;
    res;
  };
