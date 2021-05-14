include %css(
  let photos = css`
    display: block;
    position: relative;

    @media ${Screen.small} {
      margin: 0 ${LayoutParams.smallScreenHPad}px;
    }

    @media ${Screen.large} {
      width: ${LayoutParams.largeScreenContentWidth}px;
    }
  `

  let thumb = css`
    position: absolute;
  `
)
