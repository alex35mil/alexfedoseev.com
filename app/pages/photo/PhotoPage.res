open Px

module Css = PhotoPageStyles

module Thumb = {
  @react.component
  let make = (~id, ~src, ~box, ~onClick) =>
    <Photo.Thumb
      id
      src
      className=Css.thumb
      controlStyle={ReactDOM.Style.make(
        ~top=box->JustifiedLayout.Box.top->px,
        ~left=box->JustifiedLayout.Box.left->px,
        ~width=box->JustifiedLayout.Box.width->px,
        ~height=box->JustifiedLayout.Box.height->px,
        (),
      )}
      figureStyle={ReactDOM.Style.make(
        ~width=box->JustifiedLayout.Box.width->px,
        ~height=box->JustifiedLayout.Box.height->px,
        (),
      )}
      imgStyle={ReactDOM.Style.make(
        ~width=box->JustifiedLayout.Box.width->px,
        ~height=box->JustifiedLayout.Box.height->px,
        (),
      )}
      onClick
    />
}

let smallScreenContainerWidth = () => {
  open Web.Dom
  window->Window.innerWidth - LayoutParams.smallScreenHPad * 2
}

external initialBox: {..} => JustifiedLayout.box = "%identity"
let initialBox = box => {
  {
    "top": 0,
    "left": 0,
    "width": box->JustifiedLayout.Box.width,
    "height": box->JustifiedLayout.Box.height,
    "aspectRatio": box->JustifiedLayout.Box.aspectRatio,
  }->initialBox
}

@module("images/meta-photo.png?preset=basic") external metaImage: Image.basic = "default"

@react.component
let default = () => {
  let screen = React.useContext(ScreenContext.ctx)
  let router = Router.useRouter()

  let photos = React.useMemo0(() => GalleryPhotos.all->Array.shuffle)
  let photos = switch screen {
  | None => GalleryPhotos.all // using stable array on the very first render so static html matches client's one
  | Some(_) => photos // using shuffled array for the layout. probably, not the best ux though
  }

  let (containerWidth, setContainerWidth) = React.useState(() =>
    switch screen {
    | Some(Screen.Small) => smallScreenContainerWidth()
    | Some(Screen.Large) => LayoutParams.largeScreenContentWidth
    | None => 300 // initial width, number shouldn't really matter
    }
  )

  React.useEffect1(() => {
    switch screen {
    | Some(Screen.Small) => setContainerWidth(_ => smallScreenContainerWidth())
    | Some(Screen.Large) => setContainerWidth(_ => LayoutParams.largeScreenContentWidth)
    | None => () // won't ever happen on a server
    }
    None
  }, [screen])

  // TODO: It can be optimized by throttling updates and preventing unneccessary updates.
  React.useEffect2(() =>
    Subscription.onResize(_ =>
      switch screen {
      | Some(Screen.Small) => setContainerWidth(_ => smallScreenContainerWidth())
      | Some(Screen.Large) => setContainerWidth(_ => LayoutParams.largeScreenContentWidth)
      | None => () // won't ever happen on a server
      }
    )
  , (screen, setContainerWidth))

  let layout = React.useMemo1(
    () =>
      photos
      ->Array.map(((_, photo, _)) => photo.aspectRatio)
      ->JustifiedLayout.makeWithOptions(
        JustifiedLayout.makeOptions(~containerWidth, ~containerPadding=0, ~targetRowHeight=180, ()),
      ),
    [containerWidth],
  )

  let entries = React.useMemo1(
    () =>
      Array.zipBy(photos, layout->JustifiedLayout.Result.boxes, ((id, photo, thumb), box) => (
        id,
        photo,
        thumb,
        box,
      )),
    [layout],
  )

  let gridContainer = React.useRef(Js.Nullable.null)
  let galleryContainer = React.useRef(Js.Nullable.null)

  let gallery = Gallery.useGallery(
    entries->Array.map(((id, photo, _, _)) =>
      Gallery.Photo.make(~pid=id, ~msrc=photo.placeholder, ~srcset=photo.srcset, ())
    ),
  )

  let getThumbBoundsFn = React.useCallback2(index => {
    let (_, _, _, box) = entries->Array.getUnsafe(index)
    open Web.Dom
    gridContainer.current
    ->Js.Nullable.toOption
    ->Option.map(container => {
      let container = container->Element.getBoundingClientRect
      PhotoSwipe.ThumbBounds.make(
        ~x={
          open Web.Dom
          container->DomRect.left +. box->JustifiedLayout.Box.left
        },
        ~y={
          open Web.Dom
          container->DomRect.top +. window->Window.pageYOffset +. box->JustifiedLayout.Box.top
        },
        ~w=box->JustifiedLayout.Box.width,
      )
    })
  }, (entries, gridContainer))

  React.useEffect0(() => {
    switch PhotoSwipe.pidFromUrl() {
    | None => ()
    | Some(Ok(pid)) =>
      let pid = pid->Image.Id.pack
      switch entries->Js.Array2.findIndex(((id, _, _, _)) => id->Image.Id.eq(pid)) {
      | -1 => router->Router.push(Route.photo)
      | _ as index =>
        gallery.init(
          ~index,
          ~container=galleryContainer.current->Js.Nullable.toOption->Option.getExn,
          ~getThumbBoundsFn,
        )
      }
    | Some(Error()) => router->Router.push(Route.photo)
    }
    None
  })

  <>
    <Head
      htmlTitle=Suffixed("Photo")
      socialTitle=Prefixed("Photo")
      description=Custom("Photos I made along the way.")
      image=metaImage.src
      ogType=#website
    />
    <div
      ref={gridContainer->ReactDOM.Ref.domRef}
      className=Css.photos
      style={ReactDOM.Style.make(~height=layout->JustifiedLayout.Result.containerHeight->px, ())}>
      {entries
      ->Array.mapWithIndex((index, (id, _, thumb, box)) =>
        <Thumb
          id
          key={id->Image.Id.toString}
          src=thumb
          box={switch screen {
          | None => box->initialBox
          | Some(_) => box
          }}
          onClick={_ =>
            gallery.init(
              ~index,
              ~container=galleryContainer.current->Js.Nullable.toOption->Option.getExn,
              ~getThumbBoundsFn,
            )}
        />
      )
      ->React.array}
    </div>
    <Gallery ref=galleryContainer />
  </>
}
