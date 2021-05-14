include %css(
  let years = css`
    display: grid;
    grid-auto-flow: row;
    grid-auto-rows: max-content;

    @media ${Screen.small} {
      grid-template-columns: 1fr;
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

    @media ${Screen.small} {
      grid-auto-rows: max-content;
      grid-template-columns: 1fr;
      justify-content: start;
      justify-items: start;
      grid-row-gap: 2px;
    }

    @media ${Screen.large} {
      grid-auto-rows: max-content;
      grid-row-gap: 3px;
    }
  `

  let post = css`
    display: grid;

    @media ${Screen.small} {
      grid-template-columns: 1fr;
      justify-content: center;
      justify-items: start;
      text-align: left;
    }

    @media ${Screen.large} {
      grid-template-columns: ${LayoutParams.largeScreenLogoWidth}px ${LayoutParams.largeScreenRightColWidth}px;
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

  let linksHGap = 8

  let links = css`
    display: grid;

    @media ${Screen.small} {
      grid-template-columns: auto max-content;
      grid-column-gap: ${linksHGap}px;
      align-items: center;
      justify-content: start;
      justify-items: start;
    }

    @media ${Screen.large} {
      grid-template-columns: max-content max-content;
      grid-template-rows: max-content;
      grid-column-gap: ${linksHGap}px;
      align-content: center;
      align-items: center;
    }
  `

  let approxCategoryBadgeWidth = 50

  let postLink = css`
    font-size: 0.9em;
    color: ${Theme.textColor};

    @media ${Screen.small} {
      font-size: 0.8em;
      /* text-overflow: ellipsis requires non-relative width to be set */
      max-width: calc(100vw - ${LayoutParams.smallScreenHPad * 2 +
    approxCategoryBadgeWidth +
    linksHGap}px);
    }

    @media ${Screen.large} {
      font-size: 0.9em;
    }

    @media ${Screen.between(Screen.smallMaxWidth + 1, LayoutParams.largeScreenContentWidth + 200)} {
      /* text-overflow: ellipsis requires non-relative width to be set */
      max-width: ${LayoutParams.largeScreenRightColWidth - approxCategoryBadgeWidth - linksHGap}px;
    }
  `
)
