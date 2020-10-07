module Css = PhotoPageStyles;

module Thumb = {
  let px = x => x->Float.toString ++ "px";

  [@react.component]
  let make = (~id, ~src, ~box, ~onClick) => {
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
    />;
  };
};

let px = x => x->Float.toString ++ "px";

let smallScreenContainerWidth = () =>
  Web.Dom.(window->Window.innerWidth - Layout.smallScreenHPad * 2);

[@react.component]
let make = () => {
  let photos = React.useMemo0(() => Photos.all->Array.shuffle); // probably, not the best ux
  let screen = React.useContext(ScreenSize.Context.x);

  let (containerWidth, setContainerWidth) =
    React.useState(() =>
      switch (screen) {
      | Small => smallScreenContainerWidth()
      | Large => Layout.largeScreenContentWidth
      }
    );

  // TODO: It can be optimized by throttling updates and preventing unneccessary updates.
  React.useEffect2(
    () => {
      Subscription.onResize(_ => {
        switch (screen) {
        | Small => setContainerWidth(_ => smallScreenContainerWidth())
        | Large => setContainerWidth(_ => Layout.largeScreenContentWidth)
        }
      })
    },
    (screen, setContainerWidth),
  );

  let layout =
    React.useMemo1(
      () =>
        photos
        ->Array.map(((_, photo, _)) => photo.aspectRatio)
        ->JustifiedLayout.makeWithOptions(
            JustifiedLayout.makeOptions(
              ~containerWidth,
              ~containerPadding=0,
              ~targetRowHeight=180,
              (),
            ),
          ),
      [|containerWidth|],
    );

  let entries =
    React.useMemo1(
      () =>
        Array.zipBy(
          photos,
          layout->JustifiedLayout.Result.boxes,
          ((id, photo, thumb), box) =>
          (id, photo, thumb, box)
        ),
      [|layout|],
    );

  let gridContainer = React.useRef(Js.Nullable.null);
  let galleryContainer = React.useRef(Js.Nullable.null);

  let gallery =
    Gallery.useGallery(
      entries->Array.map(((id, photo, _, _)) =>
        Gallery.Photo.make(
          ~pid=id,
          ~msrc=photo.placeholder,
          ~srcset=photo.srcset,
          (),
        )
      ),
    );

  let getThumbBoundsFn =
    React.useCallback2(
      index => {
        let (_, _, _, box) = entries->Array.getUnsafe(index);
        Web.Dom.(
          gridContainer.current
          ->Js.Nullable.toOption
          ->Option.map(container => {
              let container = container->Element.getBoundingClientRect;
              PhotoSwipe.ThumbBounds.make(
                ~x=
                  Web.Dom.(
                    container->DomRect.left +. box->JustifiedLayout.Box.left
                  ),
                ~y=
                  Web.Dom.(
                    container->DomRect.top
                    +. window->Window.pageYOffset
                    +. box->JustifiedLayout.Box.top
                  ),
                ~w=box->JustifiedLayout.Box.width,
              );
            })
        );
      },
      (entries, gridContainer),
    );

  React.useEffect0(() => {
    switch (PhotoSwipe.pidFromUrl()) {
    | None => ()
    | Some(Ok(pid)) =>
      let pid = pid->Photo.Id.pack;
      switch (
        entries->Js.Array2.findIndex(((id, _, _, _)) =>
          id->Photo.Id.eq(pid)
        )
      ) {
      | (-1) => Route.photo->ReactRouter.push
      | _ as index =>
        gallery.init(
          ~index,
          ~container=
            galleryContainer.current->Js.Nullable.toOption->Option.getExn,
          ~getThumbBoundsFn,
        )
      };
    | Some(Error ()) => Route.photo->ReactRouter.push
    };
    None;
  });

  <Page>
    <div
      ref={gridContainer->ReactDOM.Ref.domRef}
      className=Css.photos
      style={ReactDOM.Style.make(
        ~height=layout->JustifiedLayout.Result.containerHeight->px,
        (),
      )}>
      {entries
       ->Array.mapWithIndex((index, (id, _, thumb, box)) =>
           <Thumb
             id
             key={id->Photo.Id.toString}
             src=thumb
             box
             onClick={_ =>
               gallery.init(
                 ~index,
                 ~container=
                   galleryContainer.current
                   ->Js.Nullable.toOption
                   ->Option.getExn,
                 ~getThumbBoundsFn,
               )
             }
           />
         )
       ->React.array}
    </div>
    <Gallery ref=galleryContainer />
  </Page>;
};
