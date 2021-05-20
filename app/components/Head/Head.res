let siteName = "Alex Fedoseev"

type title =
  | SiteName
  | Prefixed(string)
  | Suffixed(string)
  | Naked(string)

type description = Default | Custom(string)

type ogType = [
  | #website
  | #profile
  | #article
]

let buildTitle = title =>
  switch title {
  | SiteName => siteName
  | Prefixed(title) => `${siteName} | ${title}`
  | Suffixed(title) => `${title} | ${siteName}`
  | Naked(title) => title
  }

@react.component
let make = (
  ~htmlTitle: title,
  ~socialTitle: title,
  ~description: description,
  ~image: string,
  ~ogType: ogType,
) => {
  let router = Router.useRouter()

  let htmlTitle = htmlTitle->buildTitle
  let socialTitle = socialTitle->buildTitle

  let description = switch description {
  | Default => "It's all about tech, travel & photography. Hi!"
  | Custom(value) => value
  }

  <Next.Head>
    <base href="/" />
    <title> {htmlTitle->React.string} </title>
    <meta name="description" content=description />
    <meta name="viewport" content="width=device-width, initial-scale=1" />
    <meta name="twitter:card" content="summary_large_image" />
    <meta name="twitter:site" content={Env.twitterHandle} />
    <meta name="twitter:creator" content={Env.twitterHandle} />
    <meta name="twitter:title" content=socialTitle />
    <meta name="twitter:description" content=description />
    <meta name="twitter:image" content=image />
    <meta property="og:type" content={(ogType :> string)} />
    <meta property="og:title" content=socialTitle />
    <meta property="og:description" content=description />
    <meta property="og:image" content=image />
    <meta property="article:author" content={Route.facebook->Route.unpack} />
    <meta property="og:url" content={`https://${Env.webDomain}${router.asPath}`} />
    <meta property="fb:app_id" content={Env.facebookAppId} />
    <link rel="shortcut icon" href="/favicon.ico" />
  </Next.Head>
}
