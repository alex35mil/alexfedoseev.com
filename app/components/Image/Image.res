type id

type orientation = [#portrait | #landscape | #square]

module Id = {
  external pack: string => id = "%identity"
  external toString: id => string = "%identity"
  let eq = (x1, x2) => x1->toString == x2->toString
}

type basic = {
  src: string,
  width: int,
  height: int,
}

type basicWithPlaceholder = {
  src: string,
  width: int,
  height: int,
  placeholder: string,
}

type responsive<'srcsets> = {
  srcsets: 'srcsets,
  fallback: string,
  placeholder: string,
  width: int,
  height: int,
  aspectRatio: float,
  orientation: orientation,
}

type rec photo = {
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

type postCover = {fluid: string}

type postContent = {@as("880") w880: string}

type postThumb = {
  @as("250") w250: string,
  @as("350") w350: string,
  @as("500") w500: string,
  @as("700") w700: string,
  fluid: string,
}

type galleryThumb = {thumb: string}

module Css = ImageStyles

type state =
  | StandBy
  | Loading
  | Loaded

type size =
  | Original({width: int, height: int})
  | Scaled({
      containerClassName: option<string>,
      imgStyle: option<ReactDOM.style>,
      imgClassName: option<string>,
    })

type load =
  | Eager
  | Lazy

type rec loader =
  | Placeholder({src: string, transition: transition})
  | Spinner({transition: transition})
and transition =
  | Slow
  | Moderate
  | Fast

type action =
  | StartLoadingImage
  | ShowImage

let reducer = (state, action) =>
  switch action {
  | StartLoadingImage =>
    switch state {
    | StandBy => Loading
    | Loading
    | Loaded => state
    }
  | ShowImage =>
    switch state {
    | StandBy
    | Loading =>
      Loaded
    | Loaded => state
    }
  }

type _data = {
  width: option<string>,
  height: option<string>,
  containerClassName: string,
  containerStyle: option<ReactDOM.style>,
  imgClassName: string,
  imgStyle: option<ReactDOM.style>,
}

let buildImgClassName = (~status, ~transition, ~className) => {
  cx([
    Css.image,
    switch className {
    | Some(className) => className
    | None => ""
    },
    switch transition {
    | Some(Slow) => Css.transitionSlow
    | Some(Moderate) => Css.transitionModerate
    | Some(Fast) => Css.transitionFast
    | None => ""
    },
    switch status {
    | StandBy => ""
    | Loading => Css.loading
    | Loaded => Css.loaded
    },
  ])
}

@react.component
let make = (
  ~id=?,
  ~src,
  ~srcSet=?,
  ~size: size,
  ~sizes=?,
  ~alt=?,
  ~imgRef=?,
  ~load: load=Lazy,
  ~loader: option<loader>=?,
) => {
  let containerRef = React.useRef(Js.Nullable.null)
  let innerImgRef = React.useRef(Js.Nullable.null)

  let initialState = React.useMemo0(() =>
    switch load {
    | Lazy => StandBy
    | Eager => Loading
    }
  )

  let (state, dispatch) = reducer->React.useReducer(initialState)

  React.useEffect0(() => {
    let ref = switch imgRef {
    | Some(ref) => ref.React.current
    | None => innerImgRef.current
    }
    switch (state, ref->Js.Nullable.toOption) {
    | (Loading, Some(photo)) =>
      if {
        open Web.Dom
        photo->htmlImageElementFromElement->HtmlImageElement.complete
      } {
        ShowImage->dispatch
      }
    | (Loading, None)
    | (StandBy | Loaded, Some(_) | None) =>
      ignore()
    }
    None
  })

  React.useEffect1(() => {
    switch state {
    | Loading
    | Loaded =>
      None
    | StandBy =>
      switch containerRef.current->Js.Nullable.toOption {
      | Some(node) =>
        let observer = IntersectionObserver.make(entries => {
          let entry = entries->Array.getUnsafe(0)
          if entry->IntersectionObserver.Entry.isIntersecting {
            StartLoadingImage->dispatch
          }
        })
        observer->IntersectionObserver.observe(node)
        Some(() => observer->IntersectionObserver.disconnect)
      | None => None
      }
    }
  }, [state])

  let {
    width,
    height,
    containerClassName,
    containerStyle,
    imgClassName,
    imgStyle,
  } = React.useMemo3(() => {
    switch size {
    | Original({width, height}) =>
      let paddingBottom = {
        let v = Float.toString(height->Int.toFloat /. width->Int.toFloat *. 100.)
        `${v}%`
      }
      switch loader {
      | Some(Placeholder({src: placeholder, transition})) => {
          width: Some(width->Int.toString),
          height: Some(height->Int.toString),
          containerClassName: Css.sizedContainer,
          containerStyle: Some(
            ReactDOM.Style.make(
              ~backgroundImage=`url("${placeholder}")`,
              ~backgroundSize="cover",
              ~backgroundRepeat="no-repeat",
              ~backgroundPosition="50% 50%",
              ~paddingBottom,
              (),
            ),
          ),
          imgClassName: buildImgClassName(
            ~status=state,
            ~transition=Some(transition),
            ~className=Some(Css.sizedImage),
          ),
          imgStyle: None,
        }
      | Some(Spinner({transition})) => {
          width: Some(width->Int.toString),
          height: Some(height->Int.toString),
          containerClassName: Css.sizedContainer,
          containerStyle: Some(ReactDOM.Style.make(~paddingBottom, ())),
          imgClassName: buildImgClassName(
            ~status=state,
            ~transition=Some(transition),
            ~className=Some(Css.sizedImage),
          ),
          imgStyle: None,
        }
      | None => {
          width: Some(width->Int.toString),
          height: Some(height->Int.toString),
          containerClassName: Css.sizedContainer,
          containerStyle: Some(ReactDOM.Style.make(~paddingBottom, ())),
          imgClassName: buildImgClassName(
            ~status=state,
            ~transition=None,
            ~className=Some(Css.sizedImage),
          ),
          imgStyle: None,
        }
      }
    | Scaled({containerClassName, imgClassName, imgStyle}) =>
      let containerClassName = cx([
        Css.scaledContainer,
        containerClassName->Option.getWithDefault(""),
      ])
      switch loader {
      | Some(Placeholder({src: placeholder, transition})) => {
          width: None,
          height: None,
          containerClassName: containerClassName,
          containerStyle: Some(
            ReactDOM.Style.make(
              ~backgroundImage=`url("${placeholder}")`,
              ~backgroundSize="cover",
              ~backgroundRepeat="no-repeat",
              ~backgroundPosition="50% 50%",
              (),
            ),
          ),
          imgClassName: buildImgClassName(
            ~status=state,
            ~transition=Some(transition),
            ~className=imgClassName,
          ),
          imgStyle: imgStyle,
        }
      | Some(Spinner({transition})) => {
          width: None,
          height: None,
          containerClassName: containerClassName,
          containerStyle: None,
          imgClassName: buildImgClassName(
            ~status=state,
            ~transition=Some(transition),
            ~className=imgClassName,
          ),
          imgStyle: imgStyle,
        }
      | None => {
          width: None,
          height: None,
          containerClassName: containerClassName,
          containerStyle: None,
          imgClassName: buildImgClassName(~status=state, ~transition=None, ~className=imgClassName),
          imgStyle: imgStyle,
        }
      }
    }
  }, (state, size, loader))

  <div ref={containerRef->ReactDOM.Ref.domRef} className={containerClassName} style=?containerStyle>
    {switch state {
    | StandBy => React.null
    | Loading => <>
        <img
          ?id
          key={src}
          src={src}
          ?srcSet
          ?alt
          ref={switch imgRef {
          | Some(ref) => ref->ReactDOM.Ref.domRef
          | None => innerImgRef->ReactDOM.Ref.domRef
          }}
          ?width
          ?height
          className=imgClassName
          style=?imgStyle
          onLoad={_ => ShowImage->dispatch}
        />
        {switch loader {
        | Some(Spinner(_)) => <Spinner />
        | Some(Placeholder(_))
        | None => React.null
        }}
      </>
    | Loaded =>
      <img
        ?id
        key={src}
        src={src}
        ?srcSet
        ?sizes
        ?alt
        ref=?{imgRef->Option.map(ReactDOM.Ref.domRef)}
        ?width
        ?height
        className=imgClassName
        style=?imgStyle
      />
    }}
  </div>
}
