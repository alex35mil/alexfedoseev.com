module Css = PhotoStyles;

type id;

module Id = {
  external pack: string => id = "%identity";
  external toString: id => string = "%identity";
  let eq = (x1, x2) => x1->toString == x2->toString;
};

type src = {
  srcset,
  fallback: string,
  placeholder: string,
  width: int,
  height: int,
  aspectRatio: float,
}
and srcset = {
  sm: densities,
  md: densities,
  lg: densities,
  xl: densities,
}
and densities = {
  [@bs.as "@1x"]
  x1: density,
  [@bs.as "@2x"]
  x2: density,
  [@bs.as "@3x"]
  x3: density,
}
and density = {
  src: string,
  width: float,
  height: float,
};

let px = x => x->Float.toString ++ "px";

module Thumb = {
  type src;

  [@bs.get] external width: src => int = "width";
  [@bs.get] external height: src => int = "height";
  [@bs.get] external aspectRatio: src => float = "aspectRatio";
  [@bs.get] [@bs.scope "srcset"] external thumb: src => string = "thumb";
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
          srcSet={src->thumb}
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
