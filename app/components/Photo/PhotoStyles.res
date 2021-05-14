include %css(
  let thumbOverlay = css`
    display: flex;
    position: absolute;
    top: 0;
    bottom: 0;
    right: 0;
    left: 0;
    background-color: transparent;
    transition: background-color ${Transition.fast} ${Transition.timingFunction};
  `

  let thumb = css`
    cursor: pointer;

    @media ${Screen.mouse} {
      &:focus .${thumbOverlay},
      &:hover .${thumbOverlay} {
        background-color: rgba(255, 255, 255, 0.1);
      }
    }
  `

  let image = css`
    transition-property: filter, opacity;
    transition-duration: ${Transition.moderate};
    transition-timing-function: ${Transition.timingFunction};
  `

  let loadingImage = css`
    filter: blur(5px);
    opacity: 0;
  `

  let loadedImage = css`
    filter: blur(0);
    opacity: 1;
  `
)
