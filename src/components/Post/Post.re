module Css = PostStyles;

module Row = {
  [@react.component]
  let make = (~className, ~children) => {
    <div className={Cn.make([Css.row, className])}> <div /> children </div>;
  };
};

module ExpandedRow = {
  [@react.component]
  let make = (~className, ~children) => {
    <div className={Cn.make([Css.expandedRow, className])}> children </div>;
  };
};

module RowWithSidenoteText = {
  [@react.component]
  let make = (~text, ~className, ~children) => {
    <div className={Cn.make([Css.row, Css.rowWithSidenote, className])}>
      <Layout.SecondarySidenote> text->React.string </Layout.SecondarySidenote>
      children
    </div>;
  };
};

module RowWithSidenoteIcon = {
  [@react.component]
  let make = (~icon: (module Icon.Component), ~className, ~children) => {
    let (module Icon) = icon;
    <div className={Cn.make([Css.row, Css.rowWithSidenote, className])}>
      <Layout.SecondarySidenote>
        <Icon size=MD color=Faded />
      </Layout.SecondarySidenote>
      children
    </div>;
  };
};

module H1 = {
  [@react.component]
  let make = (~children) => {
    <h1 className=Css.h1> children </h1>;
  };
};

module H2 = {
  [@react.component]
  let make = (~children) => {
    <RowWithSidenoteText text="##" className=Css.h2Row>
      <h2 className=Css.h2> children </h2>
    </RowWithSidenoteText>;
  };
};

module H3 = {
  [@react.component]
  let make = (~children) => {
    <RowWithSidenoteText text="###" className=Css.h3Row>
      <h3 className=Css.h3> children </h3>
    </RowWithSidenoteText>;
  };
};

module H4 = {
  [@react.component]
  let make = (~children) => {
    <RowWithSidenoteText text="####" className=Css.h4Row>
      <h4 className=Css.h4> children </h4>
    </RowWithSidenoteText>;
  };
};

module P = {
  [@react.component]
  let make = (~children) => {
    <Row className=Css.pRow> <p className=Css.p> children </p> </Row>;
  };
};

module A = {
  [@react.component]
  let make = (~href, ~children) => {
    <A href target=Blank underline=Always> children </A>;
  };
};

module InternalLink = {
  [@react.component]
  let make = (~path, ~children) => {
    <Link path underline=Always> children </Link>;
  };
};

module Ol = {
  [@react.component]
  let make = (~children) => {
    <Row className=Css.listRow>
      <ol className={Cn.make([Css.list, Css.ol])}> children </ol>
    </Row>;
  };
};

module Ul = {
  [@react.component]
  let make = (~children) => {
    <Row className=Css.listRow>
      <ul className={Cn.make([Css.list, Css.ul])}> children </ul>
    </Row>;
  };
};

module Li = {
  [@react.component]
  let make = (~children) => {
    <li className=Css.li> children </li>;
  };
};

module Hr = {
  [@react.component]
  let make = () => {
    <Row className=Css.hrRow> <hr className=Css.hr /> </Row>;
  };
};

module Pre = {
  [@react.component]
  let make = (~children) => {
    <ExpandedRow className=Css.codeRow>
      <pre className=Css.pre> children </pre>
    </ExpandedRow>;
  };
};

module Code = {
  let filePragma = "// @file: ";
  let indexOfFirstFileNameChar = filePragma->Js.String2.indexOf(":") + 2;
  let languageRegExp = [%bs.re "/language-/"];

  [@react.component]
  let make = (~className, ~children as source) => {
    let language =
      React.useMemo0(() =>
        className->Option.map(cn => {
          let language = cn->Js.String.replaceByRe(languageRegExp, "", _);
          let label =
            switch (language) {
            | "reason" => "re"
            | _ => language
            };
          (language, label);
        })
      );
    let (source, file) =
      React.useMemo0(() =>
        if (source->Js.String2.startsWith(filePragma)) {
          let indexOfFirstCodeChar =
            switch (source->Js.String2.indexOf("\n")) {
            | (-1) => None
            | _ as x =>
              switch (source->Js.String2.charAt(x + 1)) {
              | "\n" => Some(x + 2)
              | _ => Some(x + 1)
              }
            };

          switch (indexOfFirstCodeChar) {
          | None => (source, None)
          | Some(x) =>
            let trimmedSource = source->Js.String2.sliceToEnd(~from=x);
            let file =
              source
              ->Js.String2.slice(~from=indexOfFirstFileNameChar, ~to_=x)
              ->Js.String2.trim;
            (trimmedSource, Some(file));
          };
        } else {
          (source, None);
        }
      );
    let code =
      React.useMemo0(() =>
        switch (language) {
        | Some((language, _)) =>
          Prism.(source->highlight(language->Language.get, language))
        | None => source
        }
      );

    <>
      {switch (language, file) {
       | (Some((_, label)), None) =>
         <div
           className={Cn.make([
             Css.codeLabelsRow,
             Css.codeLabelsRowWithoutFile,
           ])}>
           <div className={Cn.make([Css.codeLabel, Css.languageLabel])}>
             label->React.string
           </div>
         </div>
       | (Some((_, label)), Some(file)) =>
         <div
           className={Cn.make([Css.codeLabelsRow, Css.codeLabelsRowWithFile])}>
           <div className={Cn.make([Css.codeLabel, Css.fileLabel])}>
             file->React.string
           </div>
           <div className={Cn.make([Css.codeLabel, Css.languageLabel])}>
             label->React.string
           </div>
         </div>
       | (None, Some(file)) =>
         <div
           className={Cn.make([Css.codeLabelsRow, Css.codeLabelsRowWithFile])}>
           <div className={Cn.make([Css.codeLabel, Css.fileLabel])}>
             file->React.string
           </div>
         </div>
       | (None, None) => React.null
       }}
      <code className=Css.code dangerouslySetInnerHTML={"__html": code} />
    </>;
  };
};

module InlineCode = {
  [@react.component]
  let make = (~children) => {
    <code className=Css.inlineCode> children </code>;
  };
};

module Note = {
  [@react.component]
  let make = (~children) => {
    <RowWithSidenoteIcon icon=(module InfoIcon) className=Css.noteRow>
      <div className=Css.note> children </div>
    </RowWithSidenoteIcon>;
  };
};

module Highlight = {
  [@react.component]
  let make = (~children) => {
    <Row className=Css.highlightRow>
      <div className=Css.highlight> children </div>
    </Row>;
  };
};

module CoverImage = {
  type status =
    | Loading
    | Loaded;

  type state = {
    status,
    parallaxFactor: float,
  };

  type action =
    | ShowImage
    | UpdateParallaxFactor(float);

  let reducer = (state, action) =>
    switch (action) {
    | ShowImage =>
      switch (state.status) {
      | Loading => {...state, status: Loaded}
      | Loaded => state
      }
    | UpdateParallaxFactor(parallaxFactor) => {...state, parallaxFactor}
    };

  module Src = {
    type t;

    [@bs.get] external srcset: t => string = "srcset";
    [@bs.get] external fallback: t => string = "fallback";
    [@bs.get] external placeholder: t => string = "placeholder";
  };

  [@react.component]
  let make = (~src, ~credit) => {
    let screen = React.useContext(ScreenSize.Context.x);
    let image = React.useRef(Js.Nullable.null);
    let placeholder = src->Src.placeholder;

    let (state, dispatch) =
      reducer->React.useReducer({status: Loading, parallaxFactor: 0.});

    React.useEffect0(() => {
      switch (image->React.Ref.current->Js.Nullable.toOption) {
      | Some(image)
          when
            Web.Dom.(
              image->htmlImageElementFromElement->HtmlImageElement.complete
            ) =>
        ShowImage->dispatch
      | Some(_)
      | None => ()
      };
      None;
    });

    React.useEffect2(
      () =>
        switch (screen) {
        | Small => None
        | Large =>
          Subscription.onScroll(_ =>
            switch (state.status) {
            | Loading => ()
            | Loaded =>
              let scrolled = Web.Dom.(window->Window.pageYOffset);
              if (scrolled > 0. && scrolled < 1500.) {
                UpdateParallaxFactor(scrolled /. 3.)->dispatch;
              };
            }
          )
        },
      (state.status, screen),
    );

    <ExpandedRow className=Css.coverImageRow>
      <figure
        className=Css.coverImageFigure
        style={ReactDom.Style.make(
          ~backgroundImage={j|url("$placeholder")|j},
          ~backgroundSize="cover",
          ~backgroundRepeat="no-repeat",
          ~backgroundPosition="50% 50%",
          (),
        )}>
        <img
          sizes="100vw"
          ref={image->ReactDom.Ref.domRef}
          src={src->Src.fallback}
          srcSet={src->Src.srcset}
          className={Cn.make([
            Css.image,
            Css.coverImage,
            switch (state.status) {
            | Loading => Css.loadingImage
            | Loaded => Css.loadedImage
            },
          ])}
          style={ReactDom.Style.make(
            ~transform=
              "translate3d(0px, "
              ++ state.parallaxFactor->Int.fromFloat->Int.toString
              ++ "px, 0px)",
            (),
          )}
          onLoad={_ => ShowImage->dispatch}
        />
        <div className=Css.coverImageOverlay />
        {switch (credit) {
         | Some(credit) =>
           <figcaption className=Css.coverImageCredit>
             "Artwork: "->React.string
             <A href={credit##url}> {credit##text->React.string} </A>
           </figcaption>
         | None => React.null
         }}
      </figure>
    </ExpandedRow>;
  };
};

module InlineImagePlacement = {
  // In fact, not used since mdx serves strings
  type t =
    | Center
    | Fill
    | Bleed;

  let className = (placement, ~src) =>
    switch (placement) {
    | "center" => Css.inlineImagePlacementCenter
    | "fill" => Css.inlineImagePlacementFill
    | "bleed" => Css.inlineImagePlacementBleed
    | _ as placement =>
      Js.Console.warn(
        {j|[WARNING] Invalid InlineImage placement: `$placement` for image "$src"|j},
      );
      Css.inlineImagePlacementFill;
    };
};

module InlineImage = {
  module Src = {
    type t;
    type srcset;

    [@bs.get] external srcset: t => srcset = "srcset";
    [@bs.get] external srcs: srcset => string = "880";
    [@bs.get] external fallback: t => string = "fallback";
    [@bs.get] external placeholder: t => string = "placeholder";
  };

  [@react.component]
  let make = (~src, ~placement, ~caption=?) => {
    let placementClassName =
      React.useMemo1(
        () => placement->InlineImagePlacement.className(~src),
        [|placement|],
      );

    <Row className=Css.inlineImageRow>
      <figure className=Css.inlineImageFigure>
        <img
          src={src->Src.fallback}
          srcSet={src->Src.srcset->Src.srcs}
          alt=?caption
          className={Cn.make([Css.inlineImage, placementClassName])}
        />
        {switch (caption) {
         | Some(caption) =>
           <figcaption className=Css.inlineImageCaption>
             caption->React.string
           </figcaption>
         | None => React.null
         }}
      </figure>
    </Row>;
  };
};

module AnimatedGif = {
  [@react.component]
  let make = (~src, ~placement, ~caption) => {
    let placementClassName =
      React.useMemo1(
        () => placement->InlineImagePlacement.className(~src),
        [|placement|],
      );

    <Row className=Css.inlineImageRow>
      <figure className=Css.inlineImageFigure>
        <img
          src
          alt=?caption
          className={Cn.make([Css.inlineImage, placementClassName])}
        />
        {switch (caption) {
         | Some(caption) =>
           <figcaption className=Css.inlineImageCaption>
             caption->React.string
           </figcaption>
         | None => React.null
         }}
      </figure>
    </Row>;
  };
};

module Expandable = {
  type action =
    | Toggle;

  let reducer = (state, action) =>
    switch (state, action) {
    | (`Expanded, Toggle) => `Collapsed
    | (`Collapsed, Toggle) => `Expanded
    };

  [@react.component]
  let make = (~label: string, ~children) => {
    let (state, dispatch) = reducer->React.useReducer(`Collapsed);

    <>
      <RowWithSidenoteIcon icon=(module TipIcon) className=Css.expandableRow>
        <Control onClick={_ => Toggle->dispatch}>
          <div className=Css.expandableTrigger>
            <span className=Css.expandableTriggerText>
              label->React.string
            </span>
            <CaretIcon
              size=MD
              color=Faded
              className={Cn.make([
                Css.expandableTriggerIcon,
                switch (state) {
                | `Collapsed => Css.expandableTriggerIconCollapsed
                | `Expanded => Css.expandableTriggerIconExpanded
                },
              ])}
            />
          </div>
        </Control>
      </RowWithSidenoteIcon>
      {switch (state) {
       | `Collapsed => React.null
       | `Expanded => <> children <Hr /> </>
       }}
    </>;
  };
};

module Footer = {
  type post = {
    year: string,
    slug: string,
  };

  [@bs.val]
  external encodeURIComponent: string => string = "encodeURIComponent";

  [@react.component]
  let make = (~title, ~prevPost: option(post), ~nextPost: option(post)) => {
    let shareOnTwitter =
      React.useCallback0(() => {
        let username = Env.twitterHandle;
        let title = encodeURIComponent({j|"$title"|j});
        let url =
          encodeURIComponent(
            Web.Dom.(window->Window.location->Location.href),
          );
        Browser.openWindow(
          ~url=
            {j|https://twitter.com/intent/tweet?text=$(title)&url=$(url)&via=$(username)|j},
          ~name="Share on Twitter",
          ~width=600,
          ~height=600,
        );
      });

    let shareOnFacebook =
      React.useCallback0(() => {
        let facebookAppId = Env.facebookAppId;
        let url =
          encodeURIComponent(
            Web.Dom.(window->Window.location->Location.href),
          );
        Browser.openWindow(
          ~url=
            {j|https://www.facebook.com/dialog/share?app_id=$(facebookAppId)&display=popup&href=$(url)|j},
          ~name="Share on Facebook",
          ~width=600,
          ~height=600,
        );
      });

    <div className=Css.footerRow>
      <div className=Css.footerRowInner>
        <div className=Css.prevPost>
          {switch (prevPost) {
           | Some({year, slug}) =>
             <Link.Box
               path={Route.post(~year, ~slug)} className=Css.footerLink>
               <ChevronLeftIcon size=LG color=Faded />
             </Link.Box>
           | None => React.null
           }}
        </div>
        <div className=Css.socialSharing>
          <Control
            className={Cn.make([
              Css.socialSharingButton,
              Css.socialSharingButtonTwitter,
            ])}
            onClick={_ => shareOnTwitter()}>
            <TwitterShareIcon
              title="Share on Twitter"
              className=Css.socialSharingIcon
            />
          </Control>
          <Control
            className={Cn.make([
              Css.socialSharingButton,
              Css.socialSharingButtonFacebook,
            ])}
            onClick={_ => shareOnFacebook()}>
            <FacebookShareIcon
              title="Share on Facebook"
              className=Css.socialSharingIcon
            />
          </Control>
        </div>
        <div className=Css.nextPost>
          {switch (nextPost) {
           | Some({year, slug}) =>
             <Link.Box
               path={Route.post(~year, ~slug)} className=Css.footerLink>
               <ChevronRightIcon size=LG color=Faded />
             </Link.Box>
           | None => React.null
           }}
        </div>
      </div>
    </div>;
  };
};

[@react.component]
let make = (~title, ~year, ~date, ~prevPost, ~nextPost, ~children) => {
  <Page>
    <div className=Css.container>
      <div className=Css.title>
        <div className=Css.date>
          <Layout.PrimarySidenote>
            {j|$(date), $(year)|j}->React.string
          </Layout.PrimarySidenote>
        </div>
        <H1> title->React.string </H1>
      </div>
      <div className=Css.content> children </div>
      <Footer title prevPost nextPost />
    </div>
  </Page>;
};
