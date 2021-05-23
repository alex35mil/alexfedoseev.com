include %css(
  let overlay = css`
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
      &:focus .${overlay},
      &:hover .${overlay} {
        background-color: rgba(255, 255, 255, 0.1);
      }
    }
  `
)
