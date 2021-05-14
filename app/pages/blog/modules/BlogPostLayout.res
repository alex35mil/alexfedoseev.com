module Css = BlogPostLayoutStyles

module PostContext = {
  type t = {
    year: string,
    category: BlogPost.category,
    slug: string,
  }

  include ReactContext.Make({
    type context = t
    let defaultValue = {year: "", category: ""->Obj.magic, slug: ""}
  })
}

module PhotoGalleryContext = {
  type t = {container: React.ref<Js.nullable<Dom.element>>}

  include ReactContext.Make({
    type context = t
    let defaultValue = {
      container: {
        React.current: Js.Nullable.null,
      },
    }
  })
}

module Row = {
  @react.component
  let make = (~className, ~children) => <div className={cx([Css.row, className])}> children </div>
}

module ExpandedRow = {
  @react.component
  let make = (~className, ~children) =>
    <div className={cx([Css.expandedRow, className])}> children </div>
}

module RowWithSidenoteText = {
  @react.component
  let make = (~text, ~className, ~smallScreenVisibility: Visibility.t, ~children) =>
    <div
      className={cx([
        Css.row,
        switch smallScreenVisibility {
        | Shown => Css.rowWithSidenote
        | Hidden => Css.rowWithHiddenSidenoteOnSmallScreens
        },
        className,
      ])}>
      <Layout.SecondarySidenote
        className={cx([
          Css.rowSidenote,
          switch smallScreenVisibility {
          | Shown => ""
          | Hidden => Css.rowSidenoteHiddenOnSmallScreens
          },
        ])}>
        {text->React.string}
      </Layout.SecondarySidenote>
      children
    </div>
}

module RowWithSidenoteIcon = {
  @react.component
  let make = (
    ~icon: module(Icon.Component),
    ~className,
    ~smallScreenVisibility: Visibility.t,
    ~children,
  ) => {
    let module(Icon) = icon
    <div className={cx([Css.row, Css.rowWithSidenote, className])}>
      <Layout.SecondarySidenote
        className={cx([
          Css.rowSidenote,
          switch smallScreenVisibility {
          | Shown => ""
          | Hidden => Css.rowSidenoteHiddenOnSmallScreens
          },
        ])}>
        <Icon size=MD color=Faded />
      </Layout.SecondarySidenote>
      children
    </div>
  }
}

module H1 = {
  @react.component
  let make = (~className="", ~children) => <h1 className={cx([Css.h1, className])}> children </h1>
}

module H2 = {
  @react.component
  let make = (~children) =>
    <RowWithSidenoteText text="##" className=Css.h2Row smallScreenVisibility=Hidden>
      <h2 className=Css.h2> children </h2>
    </RowWithSidenoteText>
}

module H3 = {
  @react.component
  let make = (~children) =>
    <RowWithSidenoteText text="###" className=Css.h3Row smallScreenVisibility=Hidden>
      <h3 className=Css.h3> children </h3>
    </RowWithSidenoteText>
}

module H4 = {
  @react.component
  let make = (~children) =>
    <RowWithSidenoteText text="####" className=Css.h4Row smallScreenVisibility=Hidden>
      <h4 className=Css.h4> children </h4>
    </RowWithSidenoteText>
}

module P = {
  @react.component
  let make = (~children) => <Row className=Css.pRow> <p className=Css.p> children </p> </Row>
}

module A = {
  @react.component
  let make = (~href, ~children) => <A href target=Blank underline=Always> children </A>
}

module InternalLink = {
  @react.component
  let make = (~path, ~children) => <Link path underline=Always> children </Link>
}

module Ol = {
  @react.component
  let make = (~children) =>
    <Row className=Css.listRow> <ol className={cx([Css.list, Css.ol])}> children </ol> </Row>
}

module Ul = {
  @react.component
  let make = (~children) =>
    <Row className=Css.listRow> <ul className={cx([Css.list, Css.ul])}> children </ul> </Row>
}

module Li = {
  @react.component
  let make = (~children) => <li className=Css.li> children </li>
}

module Hr = {
  @react.component
  let make = () => <Row className=Css.hrRow> <hr className=Css.hr /> </Row>
}

module Pre = {
  @react.component
  let make = (~children) =>
    <ExpandedRow className=Css.codeRow> <pre className=Css.pre> children </pre> </ExpandedRow>
}

module Code = {
  let filePragma = "// @file: "
  let indexOfFirstFileNameChar = filePragma->Js.String2.indexOf(":") + 2
  let languageRegExp = %re("/language-/")

  @react.component
  let make = (~className, ~children as source) => {
    let language = React.useMemo0(() =>
      className->Option.map(cn => {
        let label = cn->Js.String.replaceByRe(languageRegExp, "", _)
        let language = switch label {
        // Looks like Reason syntax works pretty well
        | "rescript" => "reason"
        | _ => label
        }
        (language, label)
      })
    )
    let (source, file) = React.useMemo0(() =>
      if source->Js.String2.startsWith(filePragma) {
        let indexOfFirstCodeChar = switch source->Js.String2.indexOf("\n") {
        | -1 => None
        | _ as x =>
          switch source->Js.String2.charAt(x + 1) {
          | "\n" => Some(x + 2)
          | _ => Some(x + 1)
          }
        }

        switch indexOfFirstCodeChar {
        | None => (source, None)
        | Some(x) =>
          let trimmedSource = source->Js.String2.sliceToEnd(~from=x)
          let file =
            source->Js.String2.slice(~from=indexOfFirstFileNameChar, ~to_=x)->Js.String2.trim
          (trimmedSource, Some(file))
        }
      } else {
        (source, None)
      }
    )
    let code = React.useMemo0(() =>
      switch language {
      | Some((language, _)) =>
        open Prism
        source->highlight(language->Language.get, language)
      | None => source
      }
    )

    <>
      {switch (language, file) {
      | (Some((_, label)), None) =>
        <div className={cx([Css.codeLabelsRow, Css.codeLabelsRowWithoutFile])}>
          <div className={cx([Css.codeLabel, Css.languageLabel])}> {label->React.string} </div>
        </div>
      | (Some((_, label)), Some(file)) =>
        <div className={cx([Css.codeLabelsRow, Css.codeLabelsRowWithFile])}>
          <div className={cx([Css.codeLabel, Css.fileLabel])}> {file->React.string} </div>
          <div className={cx([Css.codeLabel, Css.languageLabel])}> {label->React.string} </div>
        </div>
      | (None, Some(file)) =>
        <div className={cx([Css.codeLabelsRow, Css.codeLabelsRowWithFile])}>
          <div className={cx([Css.codeLabel, Css.fileLabel])}> {file->React.string} </div>
        </div>
      | (None, None) => React.null
      }}
      <code className=Css.code dangerouslySetInnerHTML={"__html": code} />
    </>
  }
}

module InlineCode = {
  @react.component
  let make = (~children) => <code className=Css.inlineCode> children </code>
}

module Note = {
  @react.component
  let make = (~children) =>
    <RowWithSidenoteIcon icon=module(InfoIcon) className=Css.noteRow smallScreenVisibility=Shown>
      <div className=Css.note> children </div>
    </RowWithSidenoteIcon>
}

module CrossPostNote = {
  @react.component
  let make = (~children) =>
    <RowWithSidenoteIcon
      icon=module(CrossPostIcon) className=Css.crossPostNoteRow smallScreenVisibility=Shown>
      <div className=Css.crossPostNote> children </div>
    </RowWithSidenoteIcon>
}

module Highlight = {
  @react.component
  let make = (~children) =>
    <Row className=Css.highlightRow> <div className=Css.highlight> children </div> </Row>
}

module CoverImage = {
  type status =
    | Loading
    | Loaded

  type state = {
    status: status,
    parallaxFactor: float,
  }

  type action =
    | ShowImage
    | UpdateParallaxFactor(float)

  let reducer = (state, action) =>
    switch action {
    | ShowImage =>
      switch state.status {
      | Loading => {...state, status: Loaded}
      | Loaded => state
      }
    | UpdateParallaxFactor(parallaxFactor) => {...state, parallaxFactor: parallaxFactor}
    }

  @react.component
  let make = (~src, ~credit: option<BlogPost.Cover.credit>, ~title: string) => {
    let screen = React.useContext(ScreenContext.ctx)
    let image = React.useRef(Js.Nullable.null)
    let placeholder = src->BlogPost.Cover.placeholder

    let (state, dispatch) = reducer->React.useReducer({status: Loading, parallaxFactor: 0.})

    React.useEffect0(() => {
      switch image.current->Js.Nullable.toOption {
      | Some(image)
        if {
          open Web.Dom
          image->htmlImageElementFromElement->HtmlImageElement.complete
        } =>
        ShowImage->dispatch
      | Some(_)
      | None => ()
      }
      None
    })

    React.useEffect2(() =>
      switch screen {
      | None
      | Some(Small) =>
        None
      | Some(Large) =>
        Subscription.onScroll(_ =>
          switch state.status {
          | Loading => ()
          | Loaded =>
            let scrolled = {
              open Web.Dom
              window->Window.pageYOffset
            }
            if scrolled > 0. && scrolled < 1500. {
              UpdateParallaxFactor(scrolled /. 3.)->dispatch
            }
          }
        )
      }
    , (state.status, screen))

    <ExpandedRow className=Css.coverImageRow>
      <figure
        className=Css.coverImageFigure
        style={ReactDOM.Style.make(
          ~backgroundImage=j`url("$placeholder")`,
          ~backgroundSize="cover",
          ~backgroundRepeat="no-repeat",
          ~backgroundPosition="50% 50%",
          (),
        )}>
        <img
          sizes="100vw"
          ref={image->ReactDOM.Ref.domRef}
          src={src->BlogPost.Cover.fallback}
          srcSet={src->BlogPost.Cover.srcset}
          className={cx([
            Css.image,
            Css.coverImage,
            switch state.status {
            | Loading => Css.loadingImage
            | Loaded => Css.loadedImage
            },
          ])}
          style={ReactDOM.Style.make(
            ~transform="translate3d(0px, " ++
            (state.parallaxFactor->Int.fromFloat->Int.toString ++
            "px, 0px)"),
            (),
          )}
          onLoad={_ => ShowImage->dispatch}
        />
        <div className=Css.coverImageOverlay />
        <div className=Css.coverImageTitleContainer>
          <H1
            className={cx([
              Css.coverImageTitleText,
              Css.coverImageTitleBgColorBlue,
              // switch title.bgColor {
              // | #Blue => Css.coverImageTitleBgColorBlue
              // | #Orange => Css.coverImageTitleBgColorOrange
              // },
            ])}>
            {title->React.string}
          </H1>
        </div>
        {switch credit {
        | Some(credit) =>
          <figcaption className=Css.coverImageCredit>
            {"Artwork: "->React.string}
            {switch credit.url {
            | Some(url) => <A href={url->Route.make}> {credit.text->React.string} </A>
            | None => credit.text->React.string
            }}
          </figcaption>
        | None => React.null
        }}
      </figure>
    </ExpandedRow>
  }
}

module InlineImagePlacement = {
  // In fact, not used since mdx serves strings
  type t =
    | Center
    | Fill
    | Bleed

  let className = (placement, ~src) =>
    switch placement {
    | "center" => Css.inlineImagePlacementCenter
    | "fill" => Css.inlineImagePlacementFill
    | "bleed" => Css.inlineImagePlacementBleed
    | _ as placement =>
      Js.Console.warn(j`[WARNING] Invalid InlineImage placement: \`$placement\` for image "$src"`)
      Css.inlineImagePlacementFill
    }
}

module InlineImage = {
  module Src = {
    type t
    type srcset

    @get external srcset: t => srcset = "srcset"
    @get external srcs: srcset => string = "880"
    @get external fallback: t => string = "fallback"
    @get external placeholder: t => string = "placeholder"
  }

  @react.component
  let make = (~src, ~placement, ~caption=?) => {
    let placementClassName = React.useMemo1(
      () => placement->InlineImagePlacement.className(~src),
      [placement],
    )

    <Row className=Css.inlineImageRow>
      <figure className=Css.inlineImageFigure>
        <img
          src={src->Src.fallback}
          srcSet={src->Src.srcset->Src.srcs}
          alt=?caption
          className={cx([Css.inlineImage, placementClassName])}
        />
        {switch caption {
        | Some(caption) =>
          <figcaption className=Css.mediaCaption> {caption->React.string} </figcaption>
        | None => React.null
        }}
      </figure>
    </Row>
  }
}

module AnimatedGif = {
  module Img = {
    type t

    @get external src: t => string = "src"
    @get external placeholder: t => string = "placeholder"
  }

  @react.component
  let make = (~img, ~placement, ~caption) => {
    let placementClassName = React.useMemo1(
      () => placement->InlineImagePlacement.className(~src=img->Img.src),
      [placement],
    )

    <Row className=Css.inlineImageRow>
      <figure className=Css.inlineImageFigure>
        <img
          src={img->Img.src} alt=?caption className={cx([Css.inlineImage, placementClassName])}
        />
        {switch caption {
        | Some(caption) =>
          <figcaption className=Css.mediaCaption> {caption->React.string} </figcaption>
        | None => React.null
        }}
      </figure>
    </Row>
  }
}

module PhotoGallery = {
  open Px

  type photo = {
    id: Photo.id,
    src: Photo.src,
    thumb: Photo.thumb,
    caption: option<string>,
  }

  module Layout = {
    type t =
      | SmallScreen
      | One
      | L1_L2({leftAspectRatio: float, rightAspectRatio: float})
      | LPS1_LPS1({leftAspectRatio: float, rightAspectRatio: float})
      | P1_P1_P1({leftAspectRatio: float, middleAspectRatio: float, rightAspectRatio: float})

    type guessed = {
      layout: t,
      thumbs: array<photo>,
      plus: option<int>,
    }

    type result = {
      thumbs: array<photo>,
      plus: option<int>,
      style: ReactDOM.Style.t,
      className: string,
    }

    let contentWidth = LayoutParams.largeScreenContentWidth->Float.fromInt
    let gap = 10.

    let guess = (photos: array<photo>, ~screen: option<Screen.screen>) =>
      switch screen {
      | None
      | Some(Small) =>
        let photo = photos->Array.getUnsafe(0)
        {
          layout: SmallScreen,
          thumbs: [photo],
          plus: switch photos->Array.length - 1 {
          | 0 => None
          | x => Some(x)
          },
        }
      | Some(Large) =>
        let p1 = photos->Array.get(0)
        let p2 = photos->Array.get(1)
        let p3 = photos->Array.get(2)
        switch (p1, p2, p3) {
        | (Some(photo), None, None) => {
            layout: One,
            thumbs: [photo],
            plus: None,
          }

        | (
            Some({src: {orientation: #landscape}} as photo1),
            Some({src: {orientation: #landscape}} as photo2),
            Some({src: {orientation: #landscape}} as photo3),
          ) if photo2.src.aspectRatio == photo3.src.aspectRatio => {
            layout: L1_L2({
              leftAspectRatio: photo1.src.aspectRatio,
              rightAspectRatio: photo2.src.aspectRatio,
            }),
            thumbs: [photo1, photo2, photo3],
            plus: switch photos->Array.length - 3 {
            | 0 => None
            | x => Some(x)
            },
          }

        | (
          Some({src: {orientation: #landscape}} as photo1),
          Some({src: {orientation: #portrait}} as photo2),
          Some({src: {orientation: #landscape | #portrait | #square}})
          | None,
        )
        | (
          Some({src: {orientation: #landscape}} as photo1),
          Some({src: {orientation: #landscape}} as photo2),
          Some({src: {orientation: #portrait | #square}}) | None,
        )
        | (
          Some({src: {orientation: #portrait}} as photo1),
          Some({src: {orientation: #landscape}} as photo2),
          Some({src: {orientation: #portrait | #square}}) | None,
        )
        | (
          Some({src: {orientation: #portrait | #square}} as photo1),
          Some({src: {orientation: #portrait | #square}} as photo2),
          None,
        ) => {
            layout: LPS1_LPS1({
              leftAspectRatio: photo1.src.aspectRatio,
              rightAspectRatio: photo2.src.aspectRatio,
            }),
            thumbs: [photo1, photo2],
            plus: switch photos->Array.length - 2 {
            | 0 => None
            | x => Some(x)
            },
          }

        | (
            Some({src: {orientation: #portrait}} as photo1),
            Some({src: {orientation: #portrait}} as photo2),
            Some({src: {orientation: #portrait}} as photo3),
          ) => {
            layout: P1_P1_P1({
              leftAspectRatio: photo1.src.aspectRatio,
              middleAspectRatio: photo2.src.aspectRatio,
              rightAspectRatio: photo3.src.aspectRatio,
            }),
            thumbs: [photo1, photo2, photo3],
            plus: switch photos->Array.length - 3 {
            | 0 => None
            | x => Some(x)
            },
          }

        | _ => failwith("Unimplemented layout!")
        }
      }

    let small = (thumbs: array<photo>, ~plus: option<int>) => {
      let thumb = thumbs->Array.getUnsafe(0)

      let plus' = switch plus {
      | Some(plus) =>
        let plus' = thumbs->Array.length + plus - 1
        plus' > 0 ? Some(plus') : None
      | None =>
        let plus' = thumbs->Array.length - 1
        plus' > 0 ? Some(plus') : None
      }

      {
        thumbs: [thumb],
        plus: plus',
        style: ReactDOM.Style.make(),
        className: Css.galleryLayout_Small,
      }
    }

    let one = (thumbs: array<photo>, ~plus: option<int>) => {
      let thumb = thumbs->Array.getUnsafe(0)

      let plus' = switch plus {
      | Some(plus) =>
        let plus' = thumbs->Array.length + plus - 1
        plus' > 0 ? Some(plus') : None
      | None =>
        let plus' = thumbs->Array.length - 1
        plus' > 0 ? Some(plus') : None
      }

      // iw - image width
      // ih - image height
      // CW - content width
      // IAR - image aspect ratio

      // Base SOLE:
      //   | iw = CW
      //   | liw / lih = IAR

      // Normalized SOLE:
      //   | 1 * iw +   0    * ih = CW
      //   | 1 * iw + (-IAR) * ih = 0
      let a = [[1., 0.], [1., -.thumb.src.aspectRatio]]
      let b = [contentWidth, 0.]

      switch Sole.solve(a, b) {
      | Some([iw, ih]) =>
        let iw = iw->px
        let ih = ih->px
        {
          thumbs: [thumb],
          plus: plus',
          style: ReactDOM.Style.make(
            ~gridTemplateColumns=j`$(iw)`,
            ~gridTemplateRows=j`$(ih)`,
            ~gridColumnGap=0.->px,
            ~gridRowGap=0.->px,
            (),
          ),
          className: Css.galleryLayout_One,
        }
      | Some(_)
      | None => {
          thumbs: [thumb],
          plus: plus',
          style: ReactDOM.Style.make(),
          className: "",
        }
      }
    }

    let build = (photos, ~screen) =>
      switch photos->guess(~screen) {
      | {layout: SmallScreen, thumbs, plus} => thumbs->small(~plus)
      | {layout: One, thumbs, plus} => thumbs->one(~plus)
      | {layout: L1_L2({leftAspectRatio, rightAspectRatio}), thumbs, plus} =>
        // liw - left image width
        // lih - left image height
        // riw - right image width
        // rih - right image height
        // CW - content width
        // GAP - gap
        // LIAR - left image aspect ratio
        // RIAR - right image aspect ratio

        // Base SOLE:
        //   | liw + GAP + riw = CW
        //   | rih * 2 + GAP = lih
        //   | liw / lih = LIAR
        //   | riw / rih = RIAR

        // Normalized SOLE:
        //   | 1 * liw +   0     * lih + 1 * riw +   0     * rih = CW - GAP
        //   | 0 * liw + (-1)    * lih + 0 * riw +   2     * rih = -GAP
        //   | 1 * liw + (-LIAR) * lih + 0 * riw +   0     * rih = 0
        //   | 0 * liw +   0     * lih + 1 * riw + (-RIAR) * rih = 0

        let a = [
          [1., 0., 1., 0.],
          [0., -1., 0., 2.],
          [1., -.leftAspectRatio, 0., 0.],
          [0., 0., 1., -.rightAspectRatio],
        ]
        let b = [contentWidth -. gap, -.gap, 0., 0.]

        switch Sole.solve(a, b) {
        | Some([liw, _lih, riw, rih]) =>
          let liw = liw->px
          let riw = riw->px
          let rih = rih->px
          {
            thumbs: thumbs,
            plus: plus,
            className: Css.galleryLayout_L1_L2,
            style: ReactDOM.Style.make(
              ~gridTemplateColumns=j`$(liw) $(riw)`,
              ~gridTemplateRows=j`repeat(2, $(rih))`,
              ~gridColumnGap=gap->px,
              ~gridRowGap=gap->px,
              (),
            ),
          }
        | Some(_)
        | None =>
          thumbs->one(~plus)
        }

      | {layout: LPS1_LPS1({leftAspectRatio, rightAspectRatio}), thumbs, plus} =>
        // liw - left image width
        // lih - left image height
        // riw - right image width
        // rih - right image height
        // CW - content width
        // GAP - gap
        // LIAR - left image aspect ratio
        // RIAR - right image aspect ratio

        // Base SOLE:
        //   | liw + GAP + riw = CW
        //   | lih = rih
        //   | liw / lih = LIAR
        //   | riw / rih = RIAR

        // Normalized SOLE:
        //   | 1 * liw +   0     * lih + 1 * riw +   0     * rih = CW - GAP
        //   | 0 * liw + (-1)    * lih + 0 * riw +   1     * rih = 0
        //   | 1 * liw + (-LIAR) * lih + 0 * riw +   0     * rih = 0
        //   | 0 * liw +   0     * lih + 1 * riw + (-RIAR) * rih = 0
        let a = [
          [1., 0., 1., 0.],
          [0., -1., 0., 1.],
          [1., -.leftAspectRatio, 0., 0.],
          [0., 0., 1., -.rightAspectRatio],
        ]
        let b = [contentWidth -. gap, 0., 0., 0.]

        switch Sole.solve(a, b) {
        | Some([liw, lih, riw, _rih]) =>
          let liw = liw->px
          let lih = lih->px
          let riw = riw->px
          {
            thumbs: thumbs,
            plus: plus,
            className: Css.galleryLayout_LPS1_LPS1,
            style: ReactDOM.Style.make(
              ~gridTemplateColumns=j`$(liw) $(riw)`,
              ~gridTemplateRows=j`$(lih)`,
              ~gridColumnGap=gap->px,
              ~gridRowGap=0.->px,
              (),
            ),
          }
        | Some(_)
        | None =>
          thumbs->one(~plus)
        }

      | {layout: P1_P1_P1({leftAspectRatio, middleAspectRatio, rightAspectRatio}), thumbs, plus} =>
        // liw - left image width
        // lih - left image height
        // miw - middle image width
        // mih - middle image height
        // riw - right image width
        // rih - right image height
        // CW - content width
        // GAP - gap
        // LIAR - left image aspect ratio
        // MIAR - middle image aspect ratio
        // RIAR - right image aspect ratio

        // Base SOLE:
        //   | liw + GAP + miw + GAP + riw = CW
        //   | lih = rih
        //   | lih = mih
        //   | liw / lih = LIAR
        //   | miw / mih = MIAR
        //   | riw / rih = RIAR

        // Normalized SOLE:
        //   | 1 * liw +   0     * lih + 1 * miw +   0     * mih + 1 * riw +   0     * rih = CW - GAP - GAP
        //   | 0 * liw +   1     * lih + 0 * miw +   0     * mih + 0 * riw + (-1)    * rih = 0
        //   | 0 * liw +   1     * lih + 0 * miw + (-1)    * mih + 0 * riw +   0     * rih = 0
        //   | 1 * liw + (-LIAR) * lih + 0 * miw +   0     * mih + 0 * riw +   0     * rih = 0
        //   | 0 * liw +   0     * lih + 1 * miw + (-MIAR) * mih + 0 * riw +   0     * rih = 0
        //   | 0 * liw +   0     * lih + 0 * miw +   0     * mih + 1 * riw + (-RIAR) * rih = 0
        let a = [
          [1., 0., 1., 0., 1., 0.],
          [0., 1., 0., 0., 0., -1.],
          [0., 1., 0., -1., 0., 0.],
          [1., -.leftAspectRatio, 0., 0., 0., 0.],
          [0., 0., 1., -.middleAspectRatio, 0., 0.],
          [0., 0., 0., 0., 1., -.rightAspectRatio],
        ]
        let b = [contentWidth -. gap *. 2., 0., 0., 0., 0., 0.]

        switch Sole.solve(a, b) {
        | Some([liw, lih, miw, _mih, riw, _rih]) =>
          let liw = liw->px
          let miw = miw->px
          let riw = riw->px
          let lih = lih->px
          {
            thumbs: thumbs,
            plus: plus,
            className: Css.galleryLayout_P1_P1_P1,
            style: ReactDOM.Style.make(
              ~gridTemplateColumns=j`$(liw) $(miw) $(riw)`,
              ~gridTemplateRows=j`$(lih)`,
              ~gridColumnGap=gap->px,
              ~gridRowGap=0.->px,
              (),
            ),
          }
        | Some(_)
        | None =>
          thumbs->one(~plus)
        }
      }
  }

  @react.component
  let make = (~photos: array<photo>, ~caption: option<string>=?) => {
    let screen = React.useContext(ScreenContext.ctx)

    let {PhotoGalleryContext.container: galleryContainer} = React.useContext(
      PhotoGalleryContext.ctx,
    )

    let gallery = Gallery.useGallery(
      photos->Array.map(photo =>
        Gallery.Photo.make(
          ~pid=photo.id,
          ~msrc=photo.src.placeholder,
          ~srcset=photo.src.srcset,
          ~title=?photo.caption,
          (),
        )
      ),
    )

    let getThumbBoundsFn = React.useCallback1(index => {
      let photo = photos->Array.getUnsafe(index)
      open Web.Dom
      document
      ->Document.getElementById(photo.id->Photo.Id.toString, _)
      ->Option.map(container => {
        let container = container->Element.getBoundingClientRect
        PhotoSwipe.ThumbBounds.make(
          ~x={
            open Web.Dom
            container->DomRect.left
          },
          ~y={
            open Web.Dom
            container->DomRect.top +. window->Window.pageYOffset
          },
          ~w={
            open Web.Dom
            container->DomRect.width
          },
        )
      })
    }, [photos])

    let layout = photos->Layout.build(~screen)

    React.useEffect0(() => {
      switch PhotoSwipe.pidFromUrl() {
      | None => ()
      | Some(Ok(pid)) =>
        let pid = pid->Photo.Id.pack
        switch photos->Js.Array2.findIndex(photo => photo.id->Photo.Id.eq(pid)) {
        | -1 => ()
        | _ as index =>
          gallery.init(
            ~index,
            ~container=galleryContainer.current->Js.Nullable.toOption->Option.getExn,
            ~getThumbBoundsFn,
          )
        }
      | Some(Error()) => ()
      }
      None
    })

    <Row className=Css.galleryRow>
      <div className={cx([Css.galleryLayout, layout.className])} style=layout.style>
        {layout.thumbs
        ->Array.mapWithIndex((index, photo) =>
          <Photo.Thumb
            key={photo.id->Photo.Id.toString}
            id=photo.id
            src=photo.thumb
            className=Css.galleryThumb
            onClick={() =>
              gallery.init(
                ~index,
                ~container=galleryContainer.current->Js.Nullable.toOption->Option.getExn,
                ~getThumbBoundsFn,
              )}
          />
        )
        ->React.array}
        {switch layout.plus {
        | Some(plus) =>
          <Control
            className=Css.galleryPlusBadge
            onClick={_ =>
              gallery.init(
                ~index=layout.thumbs->Array.length,
                ~container=galleryContainer.current->Js.Nullable.toOption->Option.getExn,
                ~getThumbBoundsFn,
              )}>
            <div className=Css.galleryPlusBadgeTriangle />
            <div className=Css.galleryPlusBadgeTriangleOverlay />
            <div
              className={cx([
                Css.galleryPlusBadgeText,
                plus < 10 ? Css.galleryPlusBadgeTextLarger : Css.galleryPlusBadgeTextSmaller,
              ])}>
              {("+" ++ plus->Int.toString)->React.string}
            </div>
          </Control>
        | None => React.null
        }}
      </div>
      {switch caption {
      | Some(caption) => <div className=Css.mediaCaption> {caption->React.string} </div>
      | None => React.null
      }}
    </Row>
  }
}

module YoutubeVideo = {
  @react.component
  let make = React.memo((~id: string, ~caption: option<string>=?) => {
    let iframe = j`<iframe src="https://www.youtube-nocookie.com/embed/$id" width="560" height="349" frameborder="0" allow="accelerometer; autoplay; clipboard-write; encrypted-media; gyroscope; picture-in-picture" allowfullscreen></iframe>`
    <Row className=Css.videoRow>
      <div dangerouslySetInnerHTML={"__html": iframe} className=Css.videoContainer />
      {switch caption {
      | Some(caption) => <div className=Css.mediaCaption> {caption->React.string} </div>
      | None => React.null
      }}
    </Row>
  })
}

module Expandable = {
  type action = Toggle

  let reducer = (state, action) =>
    switch (state, action) {
    | (#Expanded, Toggle) => #Collapsed
    | (#Collapsed, Toggle) => #Expanded
    }

  @react.component
  let make = (~label: string, ~children) => {
    let (state, dispatch) = reducer->React.useReducer(#Collapsed)

    <>
      <RowWithSidenoteIcon
        icon=module(TipIcon) className=Css.expandableRow smallScreenVisibility=Shown>
        <Control onClick={_ => Toggle->dispatch}>
          <div className=Css.expandableTrigger>
            <span className=Css.expandableTriggerText> {label->React.string} </span>
            <CaretIcon
              size=MD
              color=Faded
              className={cx([
                Css.expandableTriggerIcon,
                switch state {
                | #Collapsed => Css.expandableTriggerIconCollapsed
                | #Expanded => Css.expandableTriggerIconExpanded
                },
              ])}
            />
          </div>
        </Control>
      </RowWithSidenoteIcon>
      {switch state {
      | #Collapsed => React.null
      | #Expanded => <ExpandedRow className=Css.expandableContentBg> children </ExpandedRow>
      }}
    </>
  }
}

module Footer = {
  @val
  external encodeURIComponent: string => string = "encodeURIComponent"

  @react.component
  let make = (~title, ~prevPost: option<BlogPost.meta>, ~nextPost: option<BlogPost.meta>) => {
    let shareOnTwitter = React.useCallback0(() => {
      let username = Env.twitterHandle
      let title = encodeURIComponent(j`"$title"`)
      let url = encodeURIComponent({
        open Web.Dom
        window->Window.location->Location.href
      })
      Browser.openWindow(
        ~url=j`https://twitter.com/intent/tweet?text=$(title)&url=$(url)&via=$(username)`,
        ~name="Share on Twitter",
        ~width=600,
        ~height=600,
      )
    })

    let shareOnFacebook = React.useCallback0(() => {
      let facebookAppId = Env.facebookAppId
      let url = encodeURIComponent({
        open Web.Dom
        window->Window.location->Location.href
      })
      Browser.openWindow(
        ~url=j`https://www.facebook.com/dialog/share?app_id=$(facebookAppId)&display=popup&href=$(url)`,
        ~name="Share on Facebook",
        ~width=600,
        ~height=600,
      )
    })

    <div className=Css.footerRow>
      <div className=Css.footerRowInner>
        <div className=Css.prevPost>
          {switch prevPost {
          | Some({date, category, slug}) =>
            <Link.Box
              path={Route.post(~year=date->BlogPost.Date.year, ~category, ~slug)}
              className=Css.footerLink>
              <ChevronLeftIcon size=LG color=Faded />
            </Link.Box>
          | None => React.null
          }}
        </div>
        <div className=Css.socialSharing>
          <Control
            className={cx([Css.socialSharingButton, Css.socialSharingButtonTwitter])}
            onClick={_ => shareOnTwitter()}>
            <TwitterShareIcon title="Share on Twitter" className=Css.socialSharingIcon />
          </Control>
          <Control
            className={cx([Css.socialSharingButton, Css.socialSharingButtonFacebook])}
            onClick={_ => shareOnFacebook()}>
            <FacebookShareIcon title="Share on Facebook" className=Css.socialSharingIcon />
          </Control>
        </div>
        <div className=Css.nextPost>
          {switch nextPost {
          | Some({date, category, slug}) =>
            <Link.Box
              path={Route.post(~year=date->BlogPost.Date.year, ~category, ~slug)}
              className=Css.footerLink>
              <ChevronRightIcon size=LG color=Faded />
            </Link.Box>
          | None => React.null
          }}
        </div>
      </div>
    </div>
  }
}

@react.component
let make = (
  ~title,
  ~category,
  ~slug,
  ~cover: option<BlogPost.cover>,
  ~date,
  ~prevPost,
  ~nextPost,
  ~children,
) => {
  let galleryContainer = React.useRef(Js.Nullable.null)

  <PostContext.Provider value={year: date->BlogPost.Date.year, category: category, slug: slug}>
    <PhotoGalleryContext.Provider value={container: galleryContainer}>
      {<>
        <div className=Css.container>
          {switch cover {
          | None => <H1> {title->React.string} </H1>
          | Some(cover) => <CoverImage src=cover.src credit=cover.credit title />
          }}
          <div className=Css.details>
            {"Posted in "->React.string}
            <Link path={category->Route.blogCategory} underline=Always className=Css.categoryLink>
              {category->BlogPost.Category.format->React.string}
            </Link>
            {` · `->React.string}
            {date->BlogPost.Date.format->React.string}
          </div>
          <div className=Css.content> children </div>
          <Footer title prevPost nextPost />
        </div>
        <Gallery ref=galleryContainer />
      </>}
    </PhotoGalleryContext.Provider>
  </PostContext.Provider>
}
