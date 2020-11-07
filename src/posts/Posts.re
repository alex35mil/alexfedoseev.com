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
  Post__2020_CoolThingsYouCanDoWithFirstClassModulesInReasonReact.{
    title,
    slug,
    year,
    date,
    category,
    cover,
    loader,
  },
  Post__2020_FiguringOutLayoutsUsingSole.{
    title,
    slug,
    year,
    date,
    category,
    cover,
    loader,
  },
  Post__2020_Turkey.{title, slug, year, date, category, cover, loader},
  Post__2020_ReasonSafeRouting.{
    title,
    slug,
    year,
    date,
    category,
    cover,
    loader,
  },
  Post__2020_ReasonSafeIdentifiers.{
    title,
    slug,
    year,
    date,
    category,
    cover,
    loader,
  },
  // 2019
  Post__2019_Minima.{title, slug, year, date, category, cover, loader},
  // 2018
  Post__2018_ReasonEliminatingIllegalState.{
    title,
    slug,
    year,
    date,
    category,
    cover,
    loader,
  },
  Post__2018_ReasonModules.{title, slug, year, date, category, cover, loader},
  // 2017
  Post__2017_Tableau.{title, slug, year, date, category, cover, loader},
  Post__2017_ReduxTree.{title, slug, year, date, category, cover, loader},
  Post__2017_EnumsUsingImmutableRecordsAndFlow.{
    title,
    slug,
    year,
    date,
    category,
    cover,
    loader,
  },
  Post__2017_YearOfDevelopmentWithReduxPartIII.{
    title,
    slug,
    year,
    date,
    category,
    cover,
    loader,
  },
  Post__2017_YearOfDevelopmentWithReduxPartII.{
    title,
    slug,
    year,
    date,
    category,
    cover,
    loader,
  },
  Post__2017_YearOfDevelopmentWithReduxPartI.{
    title,
    slug,
    year,
    date,
    category,
    cover,
    loader,
  },
  // 2016
  Post__2016_YoES6.{title, slug, year, date, category, cover, loader},
  // 2015
  Post__2015_IsomorphicReactWithRails.{
    title,
    slug,
    year,
    date,
    category,
    cover,
    loader,
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
