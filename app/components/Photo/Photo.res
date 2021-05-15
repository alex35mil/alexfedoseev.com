module Css = PhotoStyles

module Thumb = {
  type rec src = Image.fixed<srcset>
  and srcset = {thumb: string}

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
  let make = (
    ~id,
    ~src: src,
    ~className,
    ~controlStyle=?,
    ~figureStyle=?,
    ~imgStyle=?,
    ~onClick,
  ) => {
    let photo = React.useRef(Js.Nullable.null)
    let placeholder = src.placeholder

    let baseFigureStyle = React.useMemo1(
      () =>
        ReactDOM.Style.make(
          ~backgroundImage=j`url("$(placeholder)")`,
          ~backgroundSize="cover",
          ~backgroundRepeat="no-repeat",
          ~backgroundPosition="50% 50%",
          (),
        ),
      [placeholder],
    )

    let (state, dispatch) = reducer->React.useReducer(Loading)

    React.useEffect0(() => {
      switch photo.current->Js.Nullable.toOption {
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

    <Control className={cx([Css.thumb, className])} style=?controlStyle onClick={_ => onClick()}>
      <figure
        style={figureStyle->Option.mapWithDefault(baseFigureStyle, style =>
          ReactDOM.Style.combine(style, baseFigureStyle)
        )}>
        <img
          id={id->Image.Id.toString}
          ref={photo->ReactDOM.Ref.domRef}
          src={src.fallback}
          srcSet={src.srcset.thumb}
          className={cx([
            Css.image,
            switch state {
            | Loading => Css.loadingImage
            | Loaded => Css.loadedImage
            },
          ])}
          style=?imgStyle
          onLoad={_ => ShowImage->dispatch}
        />
        <div className=Css.thumbOverlay />
      </figure>
    </Control>
  }
}

type thumb = Thumb.src
