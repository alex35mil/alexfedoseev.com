module Css = MainPageStyles

module Photo = {
  type photo

  let photo: photo = %raw("require('images/me.png?preset=basicWithPlaceholder')")

  @get external src: photo => string = "src"
  @get external placeholder: photo => string = "placeholder"

  type state =
    | Loading
    | Loaded

  type action = ShowImage

  let reducer = (state, action) =>
    switch action {
    | ShowImage =>
      switch state {
      | Loading => Loaded
      | Loaded => state
      }
    }

  @react.component
  let make = () => {
    let photoRef = React.useRef(Js.Nullable.null)

    let (state, dispatch) = reducer->React.useReducer(Loading)

    React.useEffect0(() => {
      switch photoRef.current->Js.Nullable.toOption {
      | Some(photo)
        if {
          open Web.Dom
          photo->htmlImageElementFromElement->HtmlImageElement.complete
        } =>
        ShowImage->dispatch
      | Some(_)
      | None => ()
      }
      None
    })

    <div className=Css.photoContainer>
      <div
        className={cx([Css.photo, Css.photoPlaceholder])}
        style={React.useMemo0(() =>
          ReactDOM.Style.make(
            ~backgroundImage=`url(${photo->placeholder})`,
            ~backgroundSize="cover",
            ~backgroundRepeat="no-repeat",
            ~backgroundPosition="50% 50%",
            (),
          )
        )}
      />
      <img
        src={photo->src}
        ref={photoRef->ReactDOM.Ref.domRef}
        className={cx([
          Css.photo,
          Css.photoOriginal,
          switch state {
          | Loading => Css.loadingPhoto
          | Loaded => Css.loadedPhoto
          },
        ])}
        onLoad={_ => ShowImage->dispatch}
      />
    </div>
  }
}

let metaImage: Image.basic = %raw("require('images/meta.png?preset=basic')")

@react.component
let default = () => {
  <>
    <Head
      htmlTitle=Prefixed("Personal Site")
      socialTitle=Prefixed("Personal Site")
      description=Default
      image=metaImage.src
      ogType=#website
    />
    <div className=Css.container>
      <div className=Css.push />
      <div className=Css.content>
        <Photo />
        <div className=Css.line />
        <div className=Css.headline>
          <div className=Css.logo> <Logo className=Css.logoSvg /> </div>
          <div className=Css.links>
            <div className=Css.nav>
              <Link.Box path=Route.blog className=Css.link> {"blog"->React.string} </Link.Box>
              <Link.Box path=Route.photo className=Css.link> {"photo"->React.string} </Link.Box>
              <Link.Box path=Route.me className=Css.link> {"me"->React.string} </Link.Box>
            </div>
            <div className=Css.diagonal />
            <div className=Css.social>
              <A.Box href=Route.twitter target=Blank className={cx([Css.icon, Css.twitterIcon])}>
                <TwitterIcon size=MD color=Faded />
              </A.Box>
              <A.Box href=Route.github target=Blank className={cx([Css.icon, Css.githubIcon])}>
                <GithubIcon size=MD color=Faded />
              </A.Box>
              <A.Box
                href=Route.instagram target=Blank className={cx([Css.icon, Css.instagramIcon])}>
                <InstagramIcon size=MD color=Faded />
              </A.Box>
            </div>
          </div>
        </div>
      </div>
      <ThemeSwitch className=Css.themeSwitch />
    </div>
  </>
}
