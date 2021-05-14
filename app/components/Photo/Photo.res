module Css = PhotoStyles

type id

module Id = {
  external pack: string => id = "%identity"
  external toString: id => string = "%identity"
  let eq = (x1, x2) => x1->toString == x2->toString
}

type rec src = {
  srcset: srcset,
  fallback: string,
  placeholder: string,
  width: int,
  height: int,
  aspectRatio: float,
  orientation: orientation,
}
and srcset = {
  sm: densities,
  md: densities,
  lg: densities,
  xl: densities,
}
and densities = {
  @as("@1x")
  x1: density,
  @as("@2x")
  x2: density,
  @as("@3x")
  x3: density,
}
and density = {
  src: string,
  width: float,
  height: float,
}
and orientation = [#landscape | #portrait | #square]

module Thumb = {
  type src

  @get external width: src => int = "width"
  @get external height: src => int = "height"
  @get external aspectRatio: src => float = "aspectRatio"
  @get @scope("srcset") external thumb: src => string = "thumb"
  @get external fallback: src => string = "fallback"
  @get external placeholder: src => string = "placeholder"

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
  let make = (~id, ~src, ~className, ~controlStyle=?, ~figureStyle=?, ~imgStyle=?, ~onClick) => {
    let photo = React.useRef(Js.Nullable.null)
    let placeholder = src->placeholder

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
          id={id->Id.toString}
          ref={photo->ReactDOM.Ref.domRef}
          src={src->fallback}
          srcSet={src->thumb}
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
