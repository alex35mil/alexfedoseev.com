include %css(
  let postsGap = 20

  let years = css`
    display: grid;
    grid-auto-flow: row;
    grid-auto-rows: max-content;

    @media ${Screen.small} {
      grid-template-columns: 1fr;
      grid-row-gap: ${postsGap * 2}px;
      padding: 0 ${LayoutParams.smallScreenHPad}px;
      margin-bottom: ${postsGap}px;
    }

    @media ${Screen.large} {
      grid-template-columns: ${LayoutParams.largeScreenContentWidth}px;
      grid-row-gap: ${LayoutParams.largeScreenRowGap}px;
    }
  `

  let yearPosts = css`
    display: grid;
    grid-auto-flow: row;
    grid-auto-rows: max-content;

    @media ${Screen.small} {
      grid-auto-rows: max-content;
      grid-template-columns: 1fr;
      justify-content: start;
      justify-items: start;
      grid-row-gap: ${postsGap}px;
    }

    @media ${Screen.large} {
      grid-auto-rows: max-content;
      grid-row-gap: ${postsGap}px;
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
      grid-template-columns: ${LayoutParams.logoWidth}px ${LayoutParams.largeScreenRightColWidth}px;
      grid-template-rows: max-content;
      grid-row-gap: 4px;
      grid-column-gap: ${LayoutParams.largeScreenColGap}px;
      align-content: center;
      align-items: baseline;
    }
  `

  let largeScreenMetaFontSize = "0.7em"
  let smallScreenYearFontSize = "1em"
  let smallScreenTagFontSize = "0.7em"

  let postTags = css`
    display: grid;
    grid-auto-flow: column;
    grid-auto-columns: max-content;
    grid-column-gap: 10px;

    @media ${Screen.small} {
      order: 3;
    }
  `

  let postTag = css`
    font-size: ${largeScreenMetaFontSize};
    line-height: 1;
    color: ${Theme.fadedTextColor};
  `

  let yearContainer = css`
    @media ${Screen.small} {
      order: 2;
      margin-bottom: ${postsGap}px;
    }

    @media ${Screen.large} {
      margin-bottom: 0;
    }
  `

  let year = css`
    @media ${Screen.small} {
      font-size: ${smallScreenYearFontSize};
      font-weight: ${Font.bold};
      color: ${Theme.fadedTextColor};
    }

    @media ${Screen.large} {
      font-size: ${largeScreenMetaFontSize};
    }
  `

  let smallLargeBorderScreen = Screen.between(
    Screen.smallMaxWidth + 1,
    LayoutParams.largeScreenContentWidth + 200,
  )

  let postLink = css`
    font-size: 0.9em;
    color: ${Theme.textColor};

    @media ${Screen.small} {
      order: 4;
      font-size: 0.8em;
      /* text-overflow: ellipsis requires non-relative width to be set */
      max-width: calc(100vw - ${LayoutParams.smallScreenHPad * 2}px);
    }

    @media ${Screen.large} {
      font-size: 0.9em;
      white-space: nowrap;
    }

    @media ${smallLargeBorderScreen} {
      /* text-overflow: ellipsis requires non-relative width to be set */
      max-width: ${LayoutParams.largeScreenRightColWidth}px;
      white-space: normal !important;
    }
  `
)
