include %css(
  let container = css`
    display: grid;
    grid-template-rows: max-content max-content;

    @media ${Screen.small} {
      grid-template-columns: 1fr;
    }
  `

  let title = css`
    display: inline-block;
    margin-bottom: 20px;
    font-family: ${Font.heading};
    font-size: 34px;
    font-weight: ${Font.bold};
    color: ${Theme.textColor};
    transition-property: color;
    transition-duration: ${Transition.moderate};
    transition-timing-function: ${Transition.timingFunction};

    @media ${Screen.small} {
      justify-content: start;
      justify-items: start;
      padding: 0 ${LayoutParams.smallScreenHPad}px;
    }

    @media ${Screen.large} {
      align-content: center;
      align-items: baseline;
      padding-left: ${LayoutParams.logoWidth + LayoutParams.largeScreenColGap}px;
      /* text-overflow: ellipsis requires non-relative width to be set */
      max-width: calc(100vw - ${LayoutParams.smallScreenHPad * 2}px);
    }
  `
)
