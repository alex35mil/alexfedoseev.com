module Css = ThumbStyles

@react.component
let make = (
  ~id: Image.id,
  ~size: Image.size,
  ~srcSet,
  ~sizes=?,
  ~fallback: string,
  ~placeholder: string,
  ~className,
  ~controlStyle=?,
  ~figureStyle=?,
  ~onClick,
) => {
  <Control className={cx([Css.thumb, className])} style=?controlStyle onClick={_ => onClick()}>
    <figure style=?figureStyle>
      <Image
        id={id->Image.Id.toString}
        src={fallback}
        srcSet={srcSet}
        size
        ?sizes
        loader=Placeholder({src: placeholder, transition: Moderate})
      />
      <div className=Css.overlay />
    </figure>
  </Control>
}
