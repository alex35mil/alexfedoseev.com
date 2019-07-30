module Css = PhotoStyles;

type src;
type srcset;
type densities;
type density;

[@bs.get] external width: src => int = "width";
[@bs.get] external height: src => int = "height";
[@bs.get] external aspectRatio: src => float = "aspectRatio";
[@bs.get] external srcset: src => srcset = "srcset";
[@bs.get] external sm: srcset => densities = "sm";
[@bs.get] external md: srcset => densities = "md";
[@bs.get] external lg: srcset => densities = "lg";
[@bs.get] external xl: srcset => densities = "xl";
[@bs.get] external oneX: densities => density = "@1x";
[@bs.get] external twoX: densities => density = "@2x";
[@bs.get] external threeX: densities => density = "@3x";
[@bs.get] external densitySrc: density => string = "src";
[@bs.get] external densityWidth: density => float = "width";
[@bs.get] external densityHeight: density => float = "height";
[@bs.get] external fallback: src => string = "fallback";
[@bs.get] external placeholder: src => string = "placeholder";

let px = x => x->Float.toString ++ "px";

module Thumb = {
  type src;
  type srcset;

  [@bs.get] external width: src => int = "width";
  [@bs.get] external height: src => int = "height";
  [@bs.get] external aspectRatio: src => float = "aspectRatio";
  [@bs.get] external srcset: src => srcset = "srcset";
  [@bs.get] external thumb: srcset => string = "thumb";
  [@bs.get] external fallback: src => string = "fallback";
  [@bs.get] external placeholder: src => string = "placeholder";

  type state =
    | Loading
    | Loaded;

  type action =
    | ShowImage;

  let reducer = (state, action) =>
    switch (action) {
    | ShowImage =>
      switch (state) {
      | Loading => Loaded
      | Loaded => state
      }
    };

  [@react.component]
  let make = (~src, ~box, ~onClick) => {
    let photo = React.useRef(Js.Nullable.null);
    let placeholder = src->placeholder;

    let (state, dispatch) = reducer->React.useReducer(Loading);

    React.useEffect0(() => {
      switch (photo->React.Ref.current->Js.Nullable.toOption) {
      | Some(photo)
          when
            Web.Dom.(
              photo->htmlImageElementFromElement->HtmlImageElement.complete
            ) =>
        ShowImage->dispatch
      | Some(_)
      | None => ()
      };
      None;
    });

    <Control
      className=Css.thumb
      style={ReactDom.Style.make(
        ~top=box->JustifiedLayout.Box.top->px,
        ~left=box->JustifiedLayout.Box.left->px,
        ~width=box->JustifiedLayout.Box.width->px,
        ~height=box->JustifiedLayout.Box.height->px,
        ~backgroundImage={j|url("$placeholder")|j},
        ~backgroundSize="cover",
        ~backgroundRepeat="no-repeat",
        ~backgroundPosition="50% 50%",
        (),
      )}
      onClick={_ => onClick()}>
      <figure
        style={ReactDom.Style.make(
          ~width=box->JustifiedLayout.Box.width->px,
          ~height=box->JustifiedLayout.Box.height->px,
          ~backgroundImage={j|url("$placeholder")|j},
          ~backgroundSize="cover",
          ~backgroundRepeat="no-repeat",
          ~backgroundPosition="50% 50%",
          (),
        )}>
        <img
          src={src->fallback}
          srcSet={src->srcset->thumb}
          className={Cn.make([
            switch (state) {
            | Loading => Css.loadingImage
            | Loaded => Css.loadedImage
            },
          ])}
          style={ReactDom.Style.make(
            ~width=box->JustifiedLayout.Box.width->px,
            ~height=box->JustifiedLayout.Box.height->px,
            (),
          )}
          onLoad={_ => ShowImage->dispatch}
        />
        <div className=Css.thumbOverlay />
      </figure>
    </Control>;
  };
};

type thumb = Thumb.src;
