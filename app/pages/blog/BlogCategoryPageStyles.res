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
    margin-bottom: 10px;
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

  let years = css`
    display: grid;
    grid-auto-flow: row;
    grid-auto-rows: max-content;

    @media ${Screen.small} {
      grid-row-gap: ${LayoutParams.smallScreenRowGap}px;
      padding: 0 ${LayoutParams.smallScreenHPad}px;
    }

    @media ${Screen.large} {
      grid-template-columns: ${LayoutParams.largeScreenContentWidth}px;
      grid-row-gap: ${LayoutParams.largeScreenRowGap}px;
    }
  `

  let yearContainer = css`
    display: grid;
    grid-auto-flow: row;
    grid-auto-rows: max-content;
    grid-row-gap: 3px;

    @media ${Screen.small} {
      grid-auto-rows: max-content;
      justify-content: start;
      justify-items: start;
    }

    @media ${Screen.large} {
      grid-auto-rows: max-content;
    }
  `

  let post = css`
    display: grid;

    @media ${Screen.small} {
      justify-content: start;
      justify-items: start;
      text-align: center;
    }

    @media ${Screen.large} {
      grid-template-columns: ${LayoutParams.logoWidth}px max-content;
      grid-template-rows: max-content;
      grid-column-gap: ${LayoutParams.largeScreenColGap}px;
      align-content: center;
      align-items: center;
    }
  `

  let year = css`
    @media ${Screen.small} {
      margin-bottom: 10px;
    }

    @media ${Screen.large} {
      margin-bottom: 0;
    }
  `

  let postLink = css`
    font-size: 0.9em;
    color: ${Theme.textColor};

    @media ${Screen.small} {
      font-size: 0.8em;
      /* text-overflow: ellipsis requires non-relative width to be set */
      max-width: calc(100vw - ${LayoutParams.smallScreenHPad * 2}px);
    }

    @media ${Screen.large} {
      font-size: 0.9em;
    }

    @media ${Screen.between(Screen.smallMaxWidth + 1, LayoutParams.largeScreenContentWidth + 200)} {
      /* text-overflow: ellipsis requires non-relative width to be set */
      max-width: ${LayoutParams.largeScreenRightColWidth}px;
    }
  `
)
