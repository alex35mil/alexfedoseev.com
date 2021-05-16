open BlogPost

@module("images/posts/2015-09-12--isomorphic-react-with-rails/cover.jpg?preset=postCover")
external isomorphicReactWithRails_2015_09_12_cover: Image.fluid = "default"

@module("images/posts/2017-03-18--redux-tree/cover.jpg?preset=postCover")
external reduxTree_2017_03_18_cover: Image.fluid = "default"

@module("images/posts/2017-08-10--tableau/cover.jpg?preset=postCover")
external tableau_2017_08_10_cover: Image.fluid = "default"

@module("images/posts/2020-10-08--turkey/20201001-DSC03210.jpg?preset=postCover")
external turkey_2020_10_08_cover: Image.fluid = "default"

let dependencies: Js.Dict.t<Dependency.t> = {
  open Dependency
  open Next.Dynamic

  // It must be a function b/c each dynamic loader needs own object
  // I don't know why but if options object is reused,
  // React warns on server/client markup mismatch
  let loading = () => Next.Dynamic.options(~loading=() => <Spinner />, ())

  Js.Dict.fromArray([
    (
      "2021-05-15--error-not-error",
      {
        component: dynamic(
          () => Module.load("blog/posts/2021-05-15--error-not-error.mdx"),
          loading(),
        ),
        cover: None,
      },
    ),
    (
      "2021-04-11--home-inventory",
      {
        component: dynamic(
          () => Module.load("blog/posts/2021-04-11--home-inventory.mdx"),
          loading(),
        ),
        cover: None,
      },
    ),
    (
      "2020-10-31--cool-things-you-can-do-with-first-class-modules-in-reason-react",
      {
        component: dynamic(
          () =>
            Module.load(
              "blog/posts/2020-10-31--cool-things-you-can-do-with-first-class-modules-in-reason-react.mdx",
            ),
          loading(),
        ),
        cover: None,
      },
    ),
    (
      "2020-10-20--figuring-out-layouts-using-systems-of-linear-equations",
      {
        component: dynamic(
          () =>
            Module.load(
              "blog/posts/2020-10-20--figuring-out-layouts-using-systems-of-linear-equations.mdx",
            ),
          loading(),
        ),
        cover: None,
      },
    ),
    (
      "2020-10-08--turkey",
      {
        component: dynamic(() => Module.load("blog/posts/2020-10-08--turkey.mdx"), loading()),
        cover: Some({
          src: turkey_2020_10_08_cover,
          credit: None,
        }),
      },
    ),
    (
      "2020-01-04--safe-routing-in-reasonml",
      {
        component: dynamic(
          () => Module.load("blog/posts/2020-01-04--safe-routing-in-reasonml.mdx"),
          loading(),
        ),
        cover: None,
      },
    ),
    (
      "2020-01-01--safe-identifiers-in-reasonml",
      {
        component: dynamic(
          () => Module.load("blog/posts/2020-01-01--safe-identifiers-in-reasonml.mdx"),
          loading(),
        ),
        cover: None,
      },
    ),
    (
      "2019-06-10--minima",
      {
        component: dynamic(() => Module.load("blog/posts/2019-06-10--minima.mdx"), loading()),
        cover: None,
      },
    ),
    (
      "2018-03-22--eliminating-illegal-state-in-reasonml",
      {
        component: dynamic(
          () => Module.load("blog/posts/2018-03-22--eliminating-illegal-state-in-reasonml.mdx"),
          loading(),
        ),
        cover: None,
      },
    ),
    (
      "2018-03-13--reasonml-modules",
      {
        component: dynamic(
          () => Module.load("blog/posts/2018-03-13--reasonml-modules.mdx"),
          loading(),
        ),
        cover: None,
      },
    ),
    (
      "2017-08-10--tableau",
      {
        component: dynamic(() => Module.load("blog/posts/2017-08-10--tableau.mdx"), loading()),
        cover: Some({
          src: tableau_2017_08_10_cover,
          credit: None,
        }),
      },
    ),
    (
      "2017-03-18--redux-tree",
      {
        component: dynamic(() => Module.load("blog/posts/2017-03-18--redux-tree.mdx"), loading()),
        cover: Some({
          src: reduxTree_2017_03_18_cover,
          credit: Some({
            text: "veeterzy.com",
            url: Some("http://veeterzy.com"),
          }),
        }),
      },
    ),
    (
      "2017-03-13--enums-using-immutable-records-and-flow",
      {
        component: dynamic(
          () => Module.load("blog/posts/2017-03-13--enums-using-immutable-records-and-flow.mdx"),
          loading(),
        ),
        cover: None,
      },
    ),
    (
      "2017-02-28--year-of-development-with-redux-part-3",
      {
        component: dynamic(
          () => Module.load("blog/posts/2017-02-28--year-of-development-with-redux-part-3.mdx"),
          loading(),
        ),
        cover: None,
      },
    ),
    (
      "2017-01-20--year-of-development-with-redux-part-2",
      {
        component: dynamic(
          () => Module.load("blog/posts/2017-01-20--year-of-development-with-redux-part-2.mdx"),
          loading(),
        ),
        cover: None,
      },
    ),
    (
      "2017-01-10--year-of-development-with-redux-part-1",
      {
        component: dynamic(
          () => Module.load("blog/posts/2017-01-10--year-of-development-with-redux-part-1.mdx"),
          loading(),
        ),
        cover: None,
      },
    ),
    (
      "2016-01-11--yo-es6",
      {
        component: dynamic(() => Module.load("blog/posts/2016-01-11--yo-es6.mdx"), loading()),
        cover: None,
      },
    ),
    (
      "2015-09-12--isomorphic-react-with-rails",
      {
        component: dynamic(
          () => Module.load("blog/posts/2015-09-12--isomorphic-react-with-rails.mdx"),
          loading(),
        ),
        cover: Some({
          src: isomorphicReactWithRails_2015_09_12_cover,
          credit: Some({
            text: "Blueprint of Victory",
            url: Some(
              "https://commons.wikimedia.org/wiki/File:Blueprint_of_Victory_-_NARA_-_534555.jpg",
            ),
          }),
        }),
      },
    ),
  ])
}

// TODO: Make async
let read = (): array<Meta.t> => {
  let posts = Node.Fs.readdirSync(Env.blogPostsDir)->SortArray.stableSortBy((a, b) =>
    if a > b {
      -1
    } else if a < b {
      1
    } else {
      0
    }
  )

  posts->Array.map(post => {
    let name = post->Node.Path.basename_ext(".mdx")
    let path = `${Env.blogPostsDir}/${post}`
    let (date, slug) = switch name->Js.String2.split("--") {
    | [date, slug] => (date->Date.parse, slug)
    | _ => failwith(`Blog post at ${path}: Invalid file name.`)
    }
    let (title, description, category) = {
      let mod = path->Node.Fs.readFileSync(#utf8)->GrayMatter.parse
      switch mod.data->Js.Json.decodeObject {
      | None => failwith(`Blog post at ${path}: meta data is not found.`)
      | Some(dict) => {
          let title = switch dict->Js.Dict.get("title") {
          | None => failwith(`Blog post at ${path}: title is not set.`)
          | Some(json) =>
            switch json->Js.Json.decodeString {
            | None => failwith(`Blog post at ${path}: title is not a string.`)
            | Some(title) => title
            }
          }
          let category = switch dict->Js.Dict.get("category") {
          | None => failwith(`Blog post at ${path}: category is not set.`)
          | Some(json) =>
            switch json->Js.Json.decodeString {
            | None => failwith(`Blog post at ${path}: category is not a string.`)
            | Some(category) =>
              switch category->Category.fromFormatted {
              | Ok(category) => category
              | Error() => failwith(`Blog post at ${path}: unexpected category "${category}"`)
              }
            }
          }
          let description = switch dict->Js.Dict.get("description") {
          | None => failwith(`Blog post at ${path}: seo.description is not set.`)
          | Some(json) =>
            switch json->Js.Json.decodeString {
            | None => failwith(`Blog post at ${path}: seo.description is not a string.`)
            | Some(description) => description
            }
          }
          (title, description, category)
        }
      }
    }
    {
      Meta.title: title,
      description: description,
      slug: slug,
      date: date,
      category: category,
      key: name,
    }
  })
}

type byYear = array<(string, array<Meta.t>)>

let byYear = (posts: array<Meta.t>): byYear =>
  posts->Array.reduce([], (acc, post) => {
    let postYear = post.date->Date.year
    switch acc->Array.get(acc->Array.length - 1) {
    | None =>
      acc->Js.Array2.push((postYear, [post]))->ignore
      acc
    | Some((year, _posts)) if year != postYear =>
      acc->Js.Array2.push((postYear, [post]))->ignore
      acc
    | Some((_year, posts)) =>
      posts->Js.Array2.push(post)->ignore
      acc
    }
  })
