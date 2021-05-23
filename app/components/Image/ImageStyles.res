include %css(
  let sizedContainer = css`
    display: flex;
    position: relative;
    height: 0;
    overflow: hidden;
  `

  let sizedImage = css`
    display: flex;
    position: absolute;
    top: 0;
    left: 0;
    width: 100%;
    height: 100%;
  `

  let scaledContainer = css`
    display: flex;
    position: relative;
    overflow: hidden;
  `

  let image = css`
    /* NOTE: Do not add transform to this list since it's used in inline style of cover image */
    transition-property: filter, opacity;
    transition-timing-function: ${Transition.timingFunction};
  `

  let transitionSlow = css`
    transition-duration: 400ms;
  `

  let transitionModerate = css`
    transition-duration: ${Transition.moderate};
  `

  let transitionFast = css`
    transition-duration: ${Transition.fast};
  `

  let loading = css`
    filter: blur(5px);
    opacity: 0;
  `

  let loaded = css`
    filter: blur(0);
    opacity: 1;
  `
)
