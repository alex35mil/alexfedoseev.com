module Css = BlogPostLayoutStyles

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

module Footer = {
  @react.component
  let make = (~prevPost: option<BlogPost.meta>, ~nextPost: option<BlogPost.meta>) => {
    <div className=Css.footerRow>
      <div className=Css.footerRowInner>
        <div className=Css.prevPost>
          {switch prevPost {
          | Some({slug}) =>
            <Link.Box path={Route.post(~slug)} className=Css.footerNavLink>
              <ChevronLeftIcon size=LG color=Faded />
            </Link.Box>
          | None => React.null
          }}
        </div>
        <div className=Css.footerNote>
          <A.Box href=Route.twitter target=Blank className=Css.footerNoteLink>
            <span className=Css.footerNoteLinkText> {"Get the updates on"->React.string} </span>
            <TwitterIcon size=SM color=Faded />
          </A.Box>
        </div>
        <div className=Css.nextPost>
          {switch nextPost {
          | Some({slug}) =>
            <Link.Box path={Route.post(~slug)} className=Css.footerNavLink>
              <ChevronRightIcon size=LG color=Faded />
            </Link.Box>
          | None => React.null
          }}
        </div>
      </div>
    </div>
  }
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
  let make = (~children) => <Row className=Css.h4Row> <h4 className=Css.h4> children </h4> </Row>
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

module InlineCode = {
  @react.component
  let make = (~children) => {
    <code className=Css.inlineCode> children </code>
  }
}

module Snippet = {
  let pragma = "@"
  let maxParams = 2
  let filePragma = `${pragma}file:`
  let highlightPragma = `${pragma}highlight:`
  let delimiter = "---"
  let indexOfFirstFileNameChar = filePragma->Js.String2.indexOf(":") + 1
  let indexOfFirstHighlightChar = highlightPragma->Js.String2.indexOf(":") + 1
  let languageRegExp = %re("/language-/")

  type language = {
    id: string,
    label: string,
  }

  type meta = {
    file: option<string>,
    highlight: option<array<int>>,
  }

  @react.component
  let make = (~className=?, ~children as source) => {
    let language = React.useMemo0(() =>
      className->Option.map(cn => {
        let label = cn->Js.String.replaceByRe(languageRegExp, "", _)
        let id = switch label {
        | "sh" => "shell"
        // Looks like Reason syntax works pretty well
        | "rescript" => "reason"
        | _ => label
        }
        {id: id, label: label}
      })
    )

    let (code, meta) = React.useMemo0(() => {
      if source->Js.String2.get(0) != pragma {
        (source->Js.String2.trim, None)
      } else {
        let lines = source->Js.String2.split("\n")

        let meta = ref(None)
        let code = ref("")
        let line: ref<[#1 | #2 | #3]> = ref(#1)
        let done = ref(false)

        // barely tested but good thing it compiles to static html so bugs will be caught at build time
        while !done.contents {
          let text = lines->Array.get((line.contents :> int) - 1)
          switch (text, meta.contents, line.contents) {
          | (Some("---"), None, _) =>
            code := source
            done := true
          | (
              Some("---"),
              Some({file: Some(_), highlight: None} | {file: None, highlight: Some(_)}),
              #2,
            ) =>
            code :=
              lines->Array.sliceToEnd((line.contents :> int) - 1 + 1)->Array.joinWith("\n", x => x)
            done := true
          | (Some("---"), Some({file: Some(_), highlight: Some(_)}), #3) =>
            code :=
              lines->Array.sliceToEnd((line.contents :> int) - 1 + 1)->Array.joinWith("\n", x => x)
            done := true
          | (Some(text), _, #1 as line' | #2 as line') =>
            if text->Js.String2.startsWith(filePragma) {
              let file =
                text->Js.String2.sliceToEnd(~from=indexOfFirstFileNameChar)->Js.String2.trim
              meta :=
                switch (file, meta.contents) {
                | ("", _) => failwith("Empty @file pragma")
                | (file, None) => Some({file: Some(file), highlight: None})
                | (file, Some({file: None, highlight})) =>
                  Some({file: Some(file), highlight: highlight})
                | (_, Some({file: Some(_), highlight: _})) => failwith("Multiple @file pragmas")
                }
              line :=
                switch line' {
                | #1 => #2
                | #2 => #3
                }
            } else if text->Js.String2.startsWith(highlightPragma) {
              let lines =
                text
                ->Js.String2.sliceToEnd(~from=indexOfFirstHighlightChar)
                ->Js.String2.trim
                ->Js.String2.split(",")
                ->Js.Array2.reduce((acc, n) =>
                  if n->Js.String2.includes("-") {
                    switch n->Js.String2.split("-") {
                    | [a, b] =>
                      switch (a->Int.fromString, b->Int.fromString) {
                      | (Some(a), Some(b)) =>
                        if a > b {
                          failwith(`Invalid line range: ${n}`)
                        } else {
                          acc->Js.Array2.concat(
                            Array.make(b - a + 1, ())->Array.mapWithIndex((i, _) => a + i),
                          )
                        }
                      | _ => failwith(`Invalid line range: ${n}`)
                      }
                    | _ => failwith(`Invalid line range: ${n}`)
                    }
                  } else {
                    switch n->Int.fromString {
                    | Some(n) => {
                        acc->Js.Array2.push(n)->ignore
                        acc
                      }
                    | None => failwith(`Invalid highlight line number: ${n}`)
                    }
                  }
                , [])
              meta :=
                switch (lines, meta.contents) {
                | ([], _) => failwith("Empty @highlight pragma")
                | (lines, None) => Some({file: None, highlight: Some(lines)})
                | (lines, Some({file, highlight: None})) =>
                  Some({file: file, highlight: Some(lines)})
                | (_, Some({file: _, highlight: Some(_)})) =>
                  failwith("Multiple @highlight pragmas")
                }
              line :=
                switch line' {
                | #1 => #2
                | #2 => #3
                }
            } else {
              code := source
              done := true
            }
          | (Some("---"), Some({file: Some(_), highlight: None}), #3)
          | (Some("---"), Some({file: None, highlight: Some(_)}), #3)
          | (Some("---"), Some({file: None, highlight: None}), #3) =>
            failwith(
              "There's something sketchy is going on with the code block. Might be accidental empty line.",
            )
          | (Some(_), Some({file: Some(_), highlight: Some(_)}), #3) =>
            failwith("You probably forgot a delimiter in this code block.")
          | (Some(_), Some({file: Some(_), highlight: None}), #3)
          | (Some(_), Some({file: None, highlight: Some(_)}), #3)
          | (Some(_), Some({file: None, highlight: None}), #3)
          | (Some(_), None, #3) =>
            failwith(
              "There's something sketchy is going on with the code block. Might be accidental empty line or missing delimiter.",
            )
          | (None, _, _) =>
            code := source
            done := true
          }
        }

        switch (code.contents, meta.contents) {
        | ("", _) => failwith("No code in the end of the loop")
        | (code, meta) => (code->Js.String2.trim, meta)
        }
      }
    })

    <>
      {switch (language, meta) {
      | (Some({label, _}), None)
      | (Some({label, _}), Some({file: None})) =>
        <div className={cx([Css.codeLabelsRow, Css.codeLabelsRowWithoutFile])}>
          <div className={cx([Css.codeLabel, Css.languageLabel])}> {label->React.string} </div>
        </div>
      | (Some({label, _}), Some({file: Some(file)})) =>
        <div className={cx([Css.codeLabelsRow, Css.codeLabelsRowWithFile])}>
          <div className={cx([Css.codeLabel, Css.fileLabel])}> {file->React.string} </div>
          <div className={cx([Css.codeLabel, Css.languageLabel])}> {label->React.string} </div>
        </div>
      | (None, Some({file: Some(file)})) =>
        <div className={cx([Css.codeLabelsRow, Css.codeLabelsRowWithFile])}>
          <div className={cx([Css.codeLabel, Css.fileLabel])}> {file->React.string} </div>
        </div>
      | (None, Some({file: None}))
      | (None, None) => React.null
      }}
      <code className=Css.code>
        {switch language {
        | Some({id: language, _}) =>
          <Prism.Highlight code language>
            {({tokens, getTokenProps}) => {
              switch meta {
              | None
              | Some({highlight: None | Some([])}) =>
                tokens->Array.mapWithIndex((idx, line) => {
                  <div key={idx->Int.toString} className=Css.codeLine>
                    <div className=Css.codeLineContents>
                      {line
                      ->Array.mapWithIndex((idx, token) => {
                        let {className, children} = getTokenProps({token: token, key: idx})
                        <span key={idx->Int.toString} className> {children} </span>
                      })
                      ->React.array}
                    </div>
                  </div>
                })
              | Some({highlight: Some(lines)}) =>
                tokens->Array.mapWithIndex((idx, line) => {
                  <div
                    key={idx->Int.toString}
                    className={cx([
                      Css.codeLine,
                      lines->Js.Array2.includes(idx + 1)
                        ? Css.codeLineHighlighted
                        : Css.codeLineFaded,
                    ])}>
                    <div className=Css.codeLineContents>
                      {line
                      ->Array.mapWithIndex((idx, token) => {
                        let {className, children} = getTokenProps({token: token, key: idx})
                        <span key={idx->Int.toString} className> {children} </span>
                      })
                      ->React.array}
                    </div>
                  </div>
                })
              }->React.array
            }}
          </Prism.Highlight>
        | None => {
            let code = code->Js.String2.split("\n")

            switch meta {
            | None
            | Some({highlight: None | Some([])}) =>
              code->Array.mapWithIndex((idx, line) => {
                <div key={idx->Int.toString} className=Css.codeLine>
                  <div className=Css.codeLineContents>
                    <span>
                      {switch line {
                      | "" => "\n"->React.string
                      | _ => line->React.string
                      }}
                    </span>
                  </div>
                </div>
              })
            | Some({highlight: Some(lines)}) =>
              code->Array.mapWithIndex((idx, line) => {
                <div
                  key={idx->Int.toString}
                  className={cx([
                    Css.codeLine,
                    lines->Js.Array2.includes(idx + 1)
                      ? Css.codeLineHighlighted
                      : Css.codeLineFaded,
                  ])}>
                  <div className=Css.codeLineContents>
                    <span>
                      {switch line {
                      | "" => "\n"->React.string
                      | _ => line->React.string
                      }}
                    </span>
                  </div>
                </div>
              })
            }->React.array
          }
        }}
      </code>
    </>
  }
}

module Code = {
  type kind =
    | Inline
    | Snippet

  @react.component
  let make = (~kind: option<kind>=?, ~className=?, ~children) => {
    switch kind {
    | None
    | Some(Inline) =>
      <InlineCode> {children->React.string} </InlineCode>
    | Some(Snippet) => <Snippet ?className> children </Snippet>
    }
  }
}

module Pre = {
  @react.component
  let make = (~children) => {
    <ExpandedRow className=Css.codeRow>
      <pre className=Css.pre> {React.cloneElement(children, {"kind": Some(Code.Snippet)})} </pre>
    </ExpandedRow>
  }
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
  type state = {parallaxFactor: float}

  type action = UpdateParallaxFactor(float)

  let reducer = (_state, action) =>
    switch action {
    | UpdateParallaxFactor(parallaxFactor) => {parallaxFactor: parallaxFactor}
    }

  let initialState = {parallaxFactor: 0.}

  @react.component
  let make = (
    ~src: Image.responsive<Image.postCover>,
    ~credit: option<BlogPost.Cover.credit>,
    ~title: string,
  ) => {
    let imageRef = React.useRef(Js.Nullable.null)

    let (state, dispatch) = reducer->React.useReducer(initialState)

    React.useEffect0(() =>
      Subscription.onScroll(_ => {
        let scrolled = {
          open Web.Dom
          window->Window.pageYOffset
        }
        if scrolled > 0. && scrolled < 1500. {
          UpdateParallaxFactor(scrolled /. 3.)->dispatch
        }
      })
    )

    <ExpandedRow className=Css.coverImageRow>
      <figure className=Css.coverImageFigure>
        <Image
          load=Eager
          size=Scaled({
            containerClassName: Some(Css.coverImageContainer),
            imgClassName: Some(Css.coverImage),
            imgStyle: Some(
              ReactDOM.Style.make(
                ~transform=`translate3d(0px, ${state.parallaxFactor->Float.toString}px, 0px) scale(1.1)`, // also, scaling up a bit so placeholder isn't exposed on scroll
                (),
              ),
            ),
          })
          sizes="100vw"
          imgRef={imageRef}
          src={src.fallback}
          srcSet={src.srcsets.fluid}
          loader=Placeholder({src: src.placeholder, transition: Moderate})
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

  let styles = (placement, ~width, ~ident) =>
    switch placement {
    | "center" =>
      let style = {
        let largeScreenLayoutWidth = Float.toString(
          LayoutParams.largeScreenContentWidth->Float.fromInt *.
            Css.inlineImagePlacementCenterMaxWidth,
        )
        let smallScreenLayoutWidth = "100%"
        let layoutWidth = `calc(${largeScreenLayoutWidth}px * ${Screen.largeScreenVar} + ${smallScreenLayoutWidth} * ${Screen.smallScreenVar})`
        let imgWidth = `calc(${width->Int.toString}px / ${Screen.dprVar})`
        Some(ReactDOM.Style.make(~width=`min(${layoutWidth}, ${imgWidth})`, ()))
      }
      (Css.inlineImagePlacementCenter, style)
    | "fill" => (Css.inlineImagePlacementFill, None)
    | "bleed" => (Css.inlineImagePlacementBleed, None)
    | _ as placement =>
      Js.Console.warn(
        `[WARNING] Invalid InlineImage placement \`${placement}\` for image "${ident}"`,
      )
      (Css.inlineImagePlacementFill, None)
    }
}

module InlineImage = {
  type rec src = Image.responsive<Image.postContent>

  @react.component
  let make = (~src: src, ~placement, ~caption=?) => {
    let (placementClassName, placementStyle) = React.useMemo1(
      () => placement->InlineImagePlacement.styles(~ident=src.fallback, ~width=src.width),
      [placement],
    )

    <Row className=Css.inlineImageRow>
      <figure className=Css.inlineImageFigure>
        <div className={cx([Css.inlineImage, placementClassName])} style=?placementStyle>
          <Image
            size=Original({
              width: src.width,
              height: src.height,
            })
            src={src.fallback}
            srcSet={src.srcsets.w880}
            alt=?caption
            loader=Spinner({transition: Fast})
          />
        </div>
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
  @react.component
  let make = (~img: Image.basic, ~placement, ~caption) => {
    let (placementClassName, placementStyle) = React.useMemo1(
      () => placement->InlineImagePlacement.styles(~ident=img.src, ~width=img.width),
      [placement],
    )

    <Row className=Css.inlineImageRow>
      <figure className=Css.inlineImageFigure>
        <div className={cx([Css.inlineImage, placementClassName])} style=?placementStyle>
          <Image
            size=Original({
              width: img.width,
              height: img.height,
            })
            src={img.src}
            alt=?caption
            loader=Spinner({transition: Fast})
          />
        </div>
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

  type photo<'thumb> = {
    id: Image.id,
    src: Image.responsive<Image.photo>,
    thumb: 'thumb,
    caption: option<string>,
  }

  type thumbs = Image.responsive<Image.postThumb>

  type thumb = {
    src: Image.responsive<string>,
    size: Image.size,
    sizes: option<string>,
  }

  let withThumb = (
    photo: photo<thumbs>,
    ~size=Image.Scaled({
      containerClassName: None,
      imgStyle: None,
      imgClassName: None,
    }),
    ~sizes=?,
    pick: Image.postThumb => string,
  ): photo<thumb> => {
    id: photo.id,
    src: photo.src,
    thumb: {
      src: {
        ...photo.thumb,
        srcsets: photo.thumb.srcsets->pick,
      },
      size: size,
      sizes: sizes,
    },
    caption: photo.caption,
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
      thumbs: array<photo<thumb>>,
      plus: option<int>,
    }

    type result = {
      thumbs: array<photo<thumb>>,
      plus: option<int>,
      style: ReactDOM.Style.t,
      className: string,
    }

    let contentWidth = LayoutParams.largeScreenContentWidth->Float.fromInt
    let gap = 10.

    let guess = (photos: array<photo<thumbs>>, ~screen: option<Screen.screen>) =>
      switch screen {
      | None
      | Some(Small) =>
        let photo = photos->Array.getUnsafe(0)
        {
          layout: SmallScreen,
          thumbs: [
            photo->withThumb(
              ~size=Original({
                width: photo.thumb.width,
                height: photo.thumb.height,
              }),
              ~sizes="100vw",
              srcset => srcset.fluid,
            ),
          ],
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
            thumbs: [photo->withThumb(srcset => srcset.w700)],
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
            thumbs: [
              photo1->withThumb(srcset => srcset.w500),
              photo2->withThumb(srcset => srcset.w250),
              photo3->withThumb(srcset => srcset.w250),
            ],
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
          ) => {
            layout: LPS1_LPS1({
              leftAspectRatio: photo1.src.aspectRatio,
              rightAspectRatio: photo2.src.aspectRatio,
            }),
            thumbs: [
              photo1->withThumb(srcset => srcset.w500),
              photo2->withThumb(srcset => srcset.w250),
            ],
            plus: switch photos->Array.length - 2 {
            | 0 => None
            | x => Some(x)
            },
          }

        | (
            Some({src: {orientation: #landscape}} as photo1),
            Some({src: {orientation: #landscape}} as photo2),
            Some({src: {orientation: #portrait | #square}}) | None,
          ) => {
            layout: LPS1_LPS1({
              leftAspectRatio: photo1.src.aspectRatio,
              rightAspectRatio: photo2.src.aspectRatio,
            }),
            thumbs: [
              photo1->withThumb(srcset => srcset.w350),
              photo2->withThumb(srcset => srcset.w350),
            ],
            plus: switch photos->Array.length - 2 {
            | 0 => None
            | x => Some(x)
            },
          }

        | (
            Some({src: {orientation: #portrait}} as photo1),
            Some({src: {orientation: #landscape}} as photo2),
            Some({src: {orientation: #portrait | #square}}) | None,
          ) => {
            layout: LPS1_LPS1({
              leftAspectRatio: photo1.src.aspectRatio,
              rightAspectRatio: photo2.src.aspectRatio,
            }),
            thumbs: [
              photo1->withThumb(srcset => srcset.w250),
              photo2->withThumb(srcset => srcset.w500),
            ],
            plus: switch photos->Array.length - 2 {
            | 0 => None
            | x => Some(x)
            },
          }

        | (
            Some({src: {orientation: #portrait | #square}} as photo1),
            Some({src: {orientation: #portrait | #square}} as photo2),
            None,
          ) => {
            layout: LPS1_LPS1({
              leftAspectRatio: photo1.src.aspectRatio,
              rightAspectRatio: photo2.src.aspectRatio,
            }),
            thumbs: [
              photo1->withThumb(srcset => srcset.w350),
              photo2->withThumb(srcset => srcset.w350),
            ],
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
            thumbs: [
              photo1->withThumb(srcset => srcset.w250),
              photo2->withThumb(srcset => srcset.w250),
              photo3->withThumb(srcset => srcset.w250),
            ],
            plus: switch photos->Array.length - 3 {
            | 0 => None
            | x => Some(x)
            },
          }

        | _ => failwith("Unimplemented layout!")
        }
      }

    let small = (thumbs: array<photo<thumb>>, ~plus: option<int>) => {
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

    let one = (thumbs: array<photo<thumb>>, ~plus: option<int>) => {
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
  let make = (~photos: array<photo<thumbs>>, ~caption: option<string>=?) => {
    let screen = React.useContext(ScreenContext.ctx)

    let {PhotoGalleryContext.container: galleryContainer} = React.useContext(
      PhotoGalleryContext.ctx,
    )

    let gallery = Gallery.useGallery(
      photos->Array.map(photo =>
        Gallery.Photo.make(
          ~pid=photo.id,
          ~msrc=photo.src.placeholder,
          ~srcset=photo.src.srcsets,
          ~title=?photo.caption,
          (),
        )
      ),
    )

    let getThumbBoundsFn = React.useCallback1(index => {
      let photo = photos->Array.getUnsafe(index)

      Web.Dom.document
      ->Web.Dom.Document.getElementById(photo.id->Image.Id.toString, _)
      ->Option.map(container => {
        let container = container->Web.Dom.Element.getBoundingClientRect
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
        let pid = pid->Image.Id.pack
        switch photos->Js.Array2.findIndex(photo => photo.id->Image.Id.eq(pid)) {
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
        ->Array.mapWithIndex((index, photo) => {
          let {thumb} = photo

          <Thumb
            key={photo.id->Image.Id.toString}
            id=photo.id
            srcSet=thumb.src.srcsets
            size=thumb.size
            sizes=?thumb.sizes
            fallback=thumb.src.fallback
            placeholder=thumb.src.placeholder
            className=Css.galleryThumb
            onClick={() =>
              gallery.init(
                ~index,
                ~container=galleryContainer.current->Js.Nullable.toOption->Option.getExn,
                ~getThumbBoundsFn,
              )}
          />
        })
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

@react.component
let make = (
  ~title,
  ~tags,
  ~cover: option<BlogPost.cover>,
  ~date,
  ~prevPost,
  ~nextPost,
  ~children,
) => {
  let galleryContainer = React.useRef(Js.Nullable.null)

  <PhotoGalleryContext.Provider value={container: galleryContainer}>
    {<>
      <div className=Css.container>
        {switch cover {
        | None => <H1> {title->React.string} </H1>
        | Some(cover) => <CoverImage src=cover.src credit=cover.credit title />
        }}
        <div className=Css.details>
          {date->BlogPost.Date.format->React.string}
          {` · `->React.string}
          <span className=Css.tags>
            {tags
            ->Array.map(tag => {
              <Link
                key={tag->BlogPost.Tag.toString}
                path={tag->Route.blogTag}
                underline=WhenInteracted
                className=Css.tagLink>
                {tag->BlogPost.Tag.format->React.string}
              </Link>
            })
            ->React.array}
          </span>
        </div>
        <div className=Css.content> children </div>
        <Footer prevPost nextPost />
      </div>
      <Gallery ref=galleryContainer />
    </>}
  </PhotoGalleryContext.Provider>
}
