let _ = PhotoSwipe.Css.core;
let _ = PhotoSwipe.Css.ui;

module Photo = {
  type t;

  type size =
    | SM
    | MD
    | LG
    | XL;

  type dpr =
    | X1
    | X2
    | X3;

  [@bs.obj]
  external make:
    (
      ~pid: string,
      ~sm: Photo.densities,
      ~md: Photo.densities,
      ~lg: Photo.densities,
      ~xl: Photo.densities,
      ~msrc: string
    ) =>
    t =
    "";

  [@bs.get] external sm: t => Photo.densities = "sm";
  [@bs.get] external md: t => Photo.densities = "md";
  [@bs.get] external lg: t => Photo.densities = "lg";
  [@bs.get] external xl: t => Photo.densities = "xl";

  [@bs.get] external x1: Photo.densities => Photo.density = "@1x";
  [@bs.get] external x2: Photo.densities => Photo.density = "@2x";
  [@bs.get] external x3: Photo.densities => Photo.density = "@3x";

  [@bs.get] external src: Photo.density => string = "src";
  [@bs.get] external width: Photo.density => float = "width";
  [@bs.get] external height: Photo.density => float = "height";

  [@bs.set] external setSrc: (t, string) => unit = "src";
  [@bs.set] external setWidth: (t, float) => unit = "w";
  [@bs.set] external setHeight: (t, float) => unit = "h";
};

module Gallery = PhotoSwipe.Make(Photo);

type gallery = {
  init:
    (
      ~index: int,
      ~container: Dom.element,
      ~getThumbBoundsFn: int => PhotoSwipe.thumbBounds
    ) =>
    unit,
};

let dpr =
  if (Web.Dom.devicePixelRatio > 2.0) {
    Photo.X3;
  } else if (Web.Dom.devicePixelRatio > 1.0) {
    Photo.X2;
  } else {
    Photo.X1;
  };

let sizeFromViewport = viewportWidth =>
  if (viewportWidth > 1500.) {
    Photo.XL;
  } else if (viewportWidth > 1024.) {
    Photo.LG;
  } else if (viewportWidth > 830.) {
    Photo.MD;
  } else {
    Photo.SM;
  };

let twitterHandle = Env.twitterHandle;
let facebookAppId = Env.facebookAppId;

let useGallery = (items: array(Photo.t)): gallery => {
  let init =
    React.useCallback1(
      (index, container, getThumbBoundsFn) => {
        let size: ref(option(Photo.size)) = None->ref;

        let focusTarget =
          Web.Dom.(
            document
            ->Document.asHtmlDocument
            ->Option.flatMap(HtmlDocument.activeElement)
            ->Option.map(Web.Dom.Element.unsafeAsHtmlElement)
          );

        let gallery =
          Gallery.make(
            ~container,
            ~ui=PhotoSwipe.ui,
            ~items,
            ~options=
              Gallery.makeOptions(
                ~index,
                ~getThumbBoundsFn,
                ~loop=false,
                ~history=true,
                ~galleryPIDs=true,
                ~escKey=true,
                ~arrowKeys=true,
                ~modal=true,
                ~focus=true,
                ~pinchToClose=true,
                ~closeOnScroll=false,
                ~closeOnVerticalDrag=true,
                ~showHideOpacity=false,
                ~getDoubleTapZoom=
                  (_isMouseClick, photo) =>
                    if (photo->PhotoSwipe.Photo.width
                        > photo->PhotoSwipe.Photo.height) {
                      0.5;
                    } else {
                      0.3;
                    },
                ~shareButtons=[|
                  PhotoSwipe.ShareButton.make(
                    ~id="twitter",
                    ~label="Tweet",
                    ~url=
                      {j|https://twitter.com/intent/tweet?text={{text}}&url={{url}}&via=$(twitterHandle)|j},
                    (),
                  ),
                  PhotoSwipe.ShareButton.make(
                    ~id="facebook",
                    ~label="Share on Facebook",
                    ~url=
                      {j|https://www.facebook.com/dialog/share?app_id=$(facebookAppId)&display=popup&href={{url}}|j},
                    (),
                  ),
                  PhotoSwipe.ShareButton.make(
                    ~id="pinterest",
                    ~label="Pin it",
                    ~url=
                      {j|http://www.pinterest.com/pin/create/button/?url={{url}}&media={{image_url}}&description={{text}}|j},
                    (),
                  ),
                  PhotoSwipe.ShareButton.make(
                    ~id="download",
                    ~label="Download photo",
                    ~url={j|{{raw_image_url}}|j},
                    ~download=true,
                    (),
                  ),
                |],
                (),
              ),
          );

        gallery->Gallery.listen(
          `beforeResize(
            () =>
              switch (
                size^,
                PhotoSwipe.ViewportSize.(
                  gallery->dimensions->x->sizeFromViewport
                ),
              ) {
              | (None, x) => size := x->Some
              | (Some(SM), SM)
              | (Some(MD), MD)
              | (Some(LG), LG)
              | (Some(XL), XL) => ()
              | (Some(_), x) =>
                size := x->Some;
                gallery->Gallery.invalidateCurrItems;
              },
          ),
        );

        gallery->Gallery.listen(
          `gettingData(
            (_index, photo) =>
              switch ((size^)->Option.getExn, dpr) {
              | (SM, X3) =>
                Photo.(photo->setSrc(photo->sm->x3->src));
                Photo.(photo->setWidth(photo->sm->x3->width));
                Photo.(photo->setHeight(photo->sm->x3->height));
              | (SM, X2) =>
                Photo.(photo->setSrc(photo->sm->x2->src));
                Photo.(photo->setWidth(photo->sm->x2->width));
                Photo.(photo->setHeight(photo->sm->x2->height));
              | (SM, X1) =>
                Photo.(photo->setSrc(photo->sm->x1->src));
                Photo.(photo->setWidth(photo->sm->x1->width));
                Photo.(photo->setHeight(photo->sm->x1->height));
              | (MD, X3) =>
                Photo.(photo->setSrc(photo->md->x3->src));
                Photo.(photo->setWidth(photo->md->x3->width));
                Photo.(photo->setHeight(photo->md->x3->height));
              | (MD, X2) =>
                Photo.(photo->setSrc(photo->md->x2->src));
                Photo.(photo->setWidth(photo->md->x2->width));
                Photo.(photo->setHeight(photo->md->x2->height));
              | (MD, X1) =>
                Photo.(photo->setSrc(photo->md->x1->src));
                Photo.(photo->setWidth(photo->md->x1->width));
                Photo.(photo->setHeight(photo->md->x1->height));
              | (LG, X3) =>
                Photo.(photo->setSrc(photo->lg->x3->src));
                Photo.(photo->setWidth(photo->lg->x3->width));
                Photo.(photo->setHeight(photo->lg->x3->height));
              | (LG, X2) =>
                Photo.(photo->setSrc(photo->lg->x2->src));
                Photo.(photo->setWidth(photo->lg->x2->width));
                Photo.(photo->setHeight(photo->lg->x2->height));
              | (LG, X1) =>
                Photo.(photo->setSrc(photo->lg->x1->src));
                Photo.(photo->setWidth(photo->lg->x1->width));
                Photo.(photo->setHeight(photo->lg->x1->height));
              | (XL, X3) =>
                Photo.(photo->setSrc(photo->xl->x3->src));
                Photo.(photo->setWidth(photo->xl->x3->width));
                Photo.(photo->setHeight(photo->xl->x3->height));
              | (XL, X2) =>
                Photo.(photo->setSrc(photo->xl->x2->src));
                Photo.(photo->setWidth(photo->xl->x2->width));
                Photo.(photo->setHeight(photo->xl->x2->height));
              | (XL, X1) =>
                Photo.(photo->setSrc(photo->xl->x1->src));
                Photo.(photo->setWidth(photo->xl->x1->width));
                Photo.(photo->setHeight(photo->xl->x1->height));
              | exception _ =>
                Photo.(photo->setSrc(photo->lg->x2->src));
                Photo.(photo->setWidth(photo->lg->x2->width));
                Photo.(photo->setHeight(photo->lg->x2->height));
              },
          ),
        );

        gallery->Gallery.listen(
          `destroy(
            () =>
              Web.Dom.(
                focusTarget
                ->Option.map(HtmlElement.focus)
                ->Option.getWithDefault()
              ),
          ),
        );

        gallery->Gallery.init;
      },
      [|items|],
    );

  {
    init: (~index, ~container, ~getThumbBoundsFn) =>
      init(index, container, getThumbBoundsFn),
  };
};

[@react.component]
let make = React.forwardRef(theRef => <PhotoSwipe.Dom ref=theRef />);
