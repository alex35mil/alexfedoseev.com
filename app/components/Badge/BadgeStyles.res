include %css(
  let badge = css`
    display: inline-block;
    padding: 1px 3px;
    color: ${Theme.badgeTextColor};
    background-color: ${Theme.badgeBgColor};
    border-radius: 2px;
    font-size: 0.6em;
    line-height: 1;
    transition-property: color, background-color;
    transition-duration: ${Transition.moderate};
    transition-timing-function: ${Transition.timingFunction};
  `

  let hover = css`
    @media ${Screen.mouse} {
      &:focus,
      &:hover {
        color: #fff;
        background-color: ${Color.blue};
        transform: rotate(-3deg) scale(1.1);
        transition-property: background-color, color, transform !important;
        transition-duration: ${Transition.fast} !important;
        transition-timing-function: ${Transition.timingFunction} !important;
      }
    }
  `
)
