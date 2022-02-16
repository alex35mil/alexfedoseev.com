open BlogPost

@module("images/posts/2015-09-12--isomorphic-react-with-rails/cover.jpg?preset=postCover")
external isomorphicReactWithRails_2015_09_12_cover: Image.responsive<Image.postCover> = "default"

@module("images/posts/2017-03-18--redux-tree/cover.jpg?preset=postCover")
external reduxTree_2017_03_18_cover: Image.responsive<Image.postCover> = "default"

@module("images/posts/2017-08-10--tableau/cover.jpg?preset=postCover")
external tableau_2017_08_10_cover: Image.responsive<Image.postCover> = "default"

@module("images/posts/2020-10-08--turkey/20201001-DSC03210.jpg?preset=postCover")
external turkey_2020_10_08_cover: Image.responsive<Image.postCover> = "default"

let dependencies: Js.Dict.t<Dependency.t> = {
  open Dependency
  open Next.Dynamic

  // It must be a function b/c each dynamic loader needs own object
  // I don't know why but if options object is reused,
  // React warns on server/client markup mismatch
  let loading = () => Next.Dynamic.options(~loading=() => <Spinner />, ())

  Js.Dict.fromArray([
    (
      "2022-02-16--nix-time",
      {
        component: dynamic(() => Module.load("blog/posts/2022-02-16--nix-time.mdx"), loading()),
        cover: None,
      },
    ),
    (
      "2021-12-11--reconsidered",
      {
        component: dynamic(() => Module.load("blog/posts/2021-12-11--reconsidered.mdx"), loading()),
        cover: None,
      },
    ),
    (
      "2021-06-05--sending-bytes",
      {
        component: dynamic(
          () => Module.load("blog/posts/2021-06-05--sending-bytes.mdx"),
          loading(),
        ),
        cover: None,
      },
    ),
    (
      "2021-05-30--responsive-images-and-cumulative-layout-shift",
      {
        component: dynamic(
          () =>
            Module.load("blog/posts/2021-05-30--responsive-images-and-cumulative-layout-shift.mdx"),
          loading(),
        ),
        cover: None,
      },
    ),
    (
      "2021-05-29--lazy-loading-images-with-rescript",
      {
        component: dynamic(
          () => Module.load("blog/posts/2021-05-29--lazy-loading-images-with-rescript.mdx"),
          loading(),
        ),
        cover: None,
      },
    ),
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
      "2020-10-31--cool-things-you-can-do-with-first-class-modules-in-rescript-react",
      {
        component: dynamic(
          () =>
            Module.load(
              "blog/posts/2020-10-31--cool-things-you-can-do-with-first-class-modules-in-rescript-react.mdx",
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
      "2020-10-08--turkey-2020",
      {
        component: dynamic(() => Module.load("blog/posts/2020-10-08--turkey-2020.mdx"), loading()),
        cover: Some({
          src: turkey_2020_10_08_cover,
          credit: None,
        }),
      },
    ),
    (
      "2020-01-04--safe-routing-in-rescript",
      {
        component: dynamic(
          () => Module.load("blog/posts/2020-01-04--safe-routing-in-rescript.mdx"),
          loading(),
        ),
        cover: None,
      },
    ),
    (
      "2020-01-01--safe-identifiers-in-rescript",
      {
        component: dynamic(
          () => Module.load("blog/posts/2020-01-01--safe-identifiers-in-rescript.mdx"),
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
      "2018-03-22--eliminating-illegal-state-in-rescript",
      {
        component: dynamic(
          () => Module.load("blog/posts/2018-03-22--eliminating-illegal-state-in-rescript.mdx"),
          loading(),
        ),
        cover: None,
      },
    ),
    (
      "2018-03-13--rescript-modules",
      {
        component: dynamic(
          () => Module.load("blog/posts/2018-03-13--rescript-modules.mdx"),
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
  let files = Node.Fs.readdirSync(Env.blogPostsDir)->SortArray.stableSortBy((a, b) =>
    if a > b {
      -1
    } else if a < b {
      1
    } else {
      0
    }
  )

  let posts = files->Array.map(file => {
    let name = file->Node.Path.basename_ext(".mdx")
    let path = `${Env.blogPostsDir}/${file}`
    let (date, slug) = switch name->Js.String2.split("--") {
    | [date, slug] => (date->Date.parse, slug)
    | _ => failwith(`Blog post at ${path}: Invalid file name.`)
    }
    let (title, description, tags) = {
      let mod = path->Node.Fs.readFileSync(#utf8)->GrayMatter.parse
      switch mod.data->Js.Json.decodeObject {
      | None => failwith(`Blog post at ${path}: meta data is not found.`)
      | Some(dict) => {
          let title = switch dict->Js.Dict.get("title") {
          | None => failwith(`Blog post at ${path}: \`title\` property is not set.`)
          | Some(json) =>
            switch json->Js.Json.decodeString {
            | None => failwith(`Blog post at ${path}: \`title\` property is not a string.`)
            | Some(title) => title
            }
          }
          let description = switch dict->Js.Dict.get("description") {
          | None => failwith(`Blog post at ${path}: \`description\` property is not set.`)
          | Some(json) =>
            switch json->Js.Json.decodeString {
            | None => failwith(`Blog post at ${path}: \`description\` property is not a string.`)
            | Some(description) => description
            }
          }
          let tags = switch dict->Js.Dict.get("tags") {
          | None => failwith(`Blog post at ${path}: \`tags\` property is not set.`)
          | Some(json) =>
            switch json->Js.Json.decodeString {
            | None => failwith(`Blog post at ${path}: \`tags\` property is not a string.`)
            | Some(tags) =>
              tags
              ->Js.String2.split(",")
              ->Array.map(tag => {
                switch tag->Js.String.trim->Tag.fromString {
                | Ok(tag) => tag
                | Error() => failwith(`Blog post at ${path}: unexpected tag "${tag}"`)
                }
              })
            }
          }
          (title, description, tags)
        }
      }
    }
    {
      Meta.title: title,
      description: description,
      slug: slug,
      date: date,
      tags: tags,
      key: name,
    }
  })

  let buf: array<BlogPost.Meta.t> = []
  posts->Js.Array2.forEach(post => {
    let dup = buf->Array.getBy(post' => post'.slug == post.slug)
    switch dup {
    | None => buf->Js.Array2.push(post)->ignore
    | Some(dup) => failwith(`Posts with the same slug: \`${dup.key}\` &  \`${post.key}\``)
    }
  })

  posts
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
