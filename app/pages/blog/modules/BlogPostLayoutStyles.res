include %css(
  let container = css`
    display: grid;
    grid-template-rows: max-content max-content 1fr max-content;
    justify-content: center;
    justify-items: center;
  `

  let details = css`
    margin: 10px 0;
    color: ${Theme.fadedTextColor};
    transition-property: color;
    transition-duration: ${Transition.moderate};
    transition-timing-function: ${Transition.timingFunction};
    text-align: center;
    font-size: 0.8em;
  `

  let tags = css`
    display: inline-block;
  `
  let tagLink = css`
    display: inline-block;
    margin-right: 10px;
    color: ${Theme.fadedTextColor};

    &:last-child {
      margin-right: 0;
    }
  `

  let content = css`
    display: grid;
    grid-auto-flow: row;
    grid-auto-rows: auto;
    align-content: start;
    justify-content: start;
  `

  let vGap = 14
  let largeScreenSidenoteGap = 10

  let row = css`
    display: grid;
    hyphens: auto;

    @media ${Screen.small} {
      grid-template-rows: auto;
      grid-template-columns: auto;
      align-content: start;
      padding: 0 ${LayoutParams.smallScreenHPad}px;
    }

    @media ${Screen.large} {
      grid-template-columns: ${LayoutParams.largeScreenContentWidth}px;
      grid-template-rows: auto;
      grid-column-gap: ${LayoutParams.largeScreenColGap}px;
      align-content: start;
      justify-content: center;
    }
  `

  let rowWithSidenote = css`
    position: relative;
    align-items: baseline;

    @media ${Screen.small} {
      grid-template-columns: min-content auto;
      grid-column-gap: 10px;
    }
  `

  let rowWithHiddenSidenoteOnSmallScreens = css`
    position: relative;
    align-items: baseline;

    @media ${Screen.small} {
      grid-template-columns: auto;
    }
  `

  let rowSidenote = css`
    display: block;
    line-height: 1.5;

    @media ${Screen.small} {
      grid-column-gap: 10px;
    }

    @media ${Screen.large} {
      position: absolute;
      left: 50%;
      transform: translateX(calc(-${LayoutParams.largeScreenContentWidth / 2}px - 100% - ${largeScreenSidenoteGap}px));
      overflow: visible;
    }
  `

  let rowSidenoteHiddenOnSmallScreens = css`
    @media ${Screen.small} {
      display: none;
    }
  `

  let expandedRow = css`
    display: grid;

    @media ${Screen.small} {
      grid-template-rows: auto;
      grid-template-columns: 100vw;
      align-content: start;
    }

    @media ${Screen.large} {
      grid-template-columns: minmax(100vw, 2000px);
      grid-template-rows: auto;
      align-content: start;
      justify-content: center;
    }
  `

  let h1 = css`
    display: flex;
    margin-top: 10px;
    font-family: ${Font.heading};
    font-size: 34px;
    font-weight: ${Font.bold};
    color: ${Theme.textColor};
    transition-property: color;
    transition-duration: ${Transition.moderate};
    transition-timing-function: ${Transition.timingFunction};

    @media ${Screen.small} {
      padding: 0 ${LayoutParams.smallScreenHPad}px;
      text-align: center;
    }

    @media ${Screen.large} {
      max-width: ${Screen.smallMaxWidth - 20}px;
      text-align: center;
    }
  `

  let hLine = `
    padding-bottom: 0.3em;
    border-bottom: 1px solid ${Theme.lineColor};
  `

  let h2Row = css`
    margin: ${vGap}px 0 ${vGap + 4}px 0;
  `

  let h2 = css`
    display: flex;
    font-family: ${Font.heading};
    font-size: 24px;
    font-weight: ${Font.bold};
    color: ${Theme.textColor};
    transition-property: color;
    transition-duration: ${Transition.moderate};
    transition-timing-function: ${Transition.timingFunction};
    ${hLine}
  `

  let h3Row = css`
    margin: ${vGap}px 0 ${vGap + 4}px 0;
  `

  let h3 = css`
    display: flex;
    font-family: ${Font.heading};
    font-size: 20px;
    color: ${Theme.fadedTextColor};
    transition-property: color;
    transition-duration: ${Transition.moderate};
    transition-timing-function: ${Transition.timingFunction};
    ${hLine}
  `

  let h4Row = css`
    margin: ${vGap}px 0 0;
  `

  let h4 = css`
    display: flex;
    font-family: ${Font.mono};
    font-size: 20px;
    color: ${Theme.fadedTextColor};
    transition-property: color;
    transition-duration: ${Transition.moderate};
    transition-timing-function: ${Transition.timingFunction};
  `

  let pRow = css`
    margin: ${vGap}px 0;

    .${h2Row} + &,
    .${h3Row} + & {
      margin-top: 8px;
    }

    .${h4Row} + & {
      margin-top: 0px;
    }
  `

  let p = css`
    margin: 0;
    color: ${Theme.textColor};
    transition-property: color;
    transition-duration: ${Transition.moderate};
    transition-timing-function: ${Transition.timingFunction};
  `

  let listMargin = "1.5em"

  let listRow = css`
    margin: ${vGap}px 0;
  `

  let list = css`
    margin-left: ${listMargin};
  `

  let ol = css`
    list-style-type: none;

    & li {
      counter-increment: oli-counter;

      &::before {
        content: counter(oli-counter) ".";
        display: block;
        position: relative;
        max-width: 0px;
        max-height: 0px;
        left: -${listMargin};
        color: ${Theme.fadedTextColor};
        transition-property: color;
        transition-duration: ${Transition.moderate};
        transition-timing-function: ${Transition.timingFunction};
      }
    }
  `

  let ul = css`
    list-style-type: none;

    & li::before {
      content: "—";
      display: block;
      position: relative;
      max-width: 0px;
      max-height: 0px;
      left: -${listMargin};
      color: ${Theme.fadedTextColor};
      transition-property: color;
      transition-duration: ${Transition.moderate};
      transition-timing-function: ${Transition.timingFunction};
    }
  `

  let li = css`
    margin-bottom: 4px;
    color: ${Theme.textColor};
    transition-property: color;
    transition-duration: ${Transition.moderate};
    transition-timing-function: ${Transition.timingFunction};
  `

  let hrRow = css`
    margin: ${vGap}px 0;
  `

  let hr = css`
    display: flex;
    border-width: 0;
    border-top: 1px solid ${Theme.lineColor};
    transition-property: border-top-color;
    transition-duration: ${Transition.moderate};
    transition-timing-function: ${Transition.timingFunction};
  `

  let inlineCode = css`
    font-family: ${Font.mono};
    font-style: italic;
    color: ${Theme.fadedTextColor};
    transition-property: color;
    transition-duration: ${Transition.moderate};
    transition-timing-function: ${Transition.timingFunction};
  `

  let codeRow = css`
    margin: ${vGap}px 0;
  `

  let largeScreenCodeVPad = 20
  let smallScreenCodeVPad = 20

  let pre = css`
    display: flex;
    position: relative;
    flex-flow: column nowrap;
    align-items: center;
    background-color: ${Theme.codeBgColor};
    transition-property: background-color;
    transition-duration: ${Transition.moderate};
    transition-timing-function: ${Transition.timingFunction};

    @media ${Screen.small} {
      padding: ${smallScreenCodeVPad}px 0;
      overflow-x: auto;
    }

    @media ${Screen.large} {
      padding: ${largeScreenCodeVPad}px 0;
    }
  `

  let code = css`
    font-family: ${Font.mono};
    font-size: 16px;
    color: ${Theme.codeColor};
    transition-property: color;
    transition-duration: ${Transition.moderate};
    transition-timing-function: ${Transition.timingFunction};
    line-height: 1.8;

    @media ${Screen.small} {
      width: 100%;
    }

    @media ${Screen.large} {
      width: 100%;
    }
  `

  let codeLabelsRow = css`
    position: relative;
    overflow: visible;

    @media ${Screen.small} {
      width: calc(100% - ${LayoutParams.smallScreenHPad * 2}px);
    }

    @media ${Screen.large} {
      width: ${LayoutParams.largeScreenContentWidth}px;
    }
  `

  let codeLabelsRowWithFile = css`
    height: 1em;
  `

  let codeLabelsRowWithoutFile = css`
    height: 0;
  `

  let languageLabelHPad = 7

  let codeLabel = css`
    display: flex;
    position: absolute;
    top: -${largeScreenCodeVPad}px;
    background-color: ${Theme.codeLabelBgColor};
    transition-property: background-color;
    transition-duration: ${Transition.moderate};
    transition-timing-function: ${Transition.timingFunction};
    padding: 1px ${languageLabelHPad}px;

    @media ${Screen.small} {
      font-size: 0.65em;
    }

    @media ${Screen.large} {
      font-size: 0.7em;
    }
  `

  let languageLabel = css`
    text-transform: uppercase;
    right: -${languageLabelHPad}px;
  `

  let fileLabel = css`
    @media ${Screen.small} {
      left: -${languageLabelHPad}px;
    }

    @media ${Screen.large} {
      left: -${languageLabelHPad}px;
    }
  `

  let codeLine = css`
    display: flex;
    justify-content: center;
    width: 100%;
    transition-property: opacity;
    transition-duration: ${Transition.fast};
    transition-timing-function: ${Transition.timingFunction};
  `

  let codeLineFaded = css`
    opacity: 0.7;
  `

  let codeLineHighlighted = css`
    background-color: ${Theme.codeHighlightedLineBgColor};
  `

  let codeLineContents = css`
    @media ${Screen.small} {
      width: 100%;
      padding: 0 ${LayoutParams.smallScreenHPad}px;
    }

    @media ${Screen.large} {
      width: ${LayoutParams.largeScreenContentWidth}px;
      overflow: visible;
    }
  `

  let noteRow = css`
    margin: ${vGap}px 0;
  `

  let note = css`
    &,
    & a {
      color: ${Theme.fadedTextColor};
      transition-property: color;
      transition-duration: ${Transition.moderate};
      transition-timing-function: ${Transition.timingFunction};
    }
  `

  let crossPostNoteRow = css`
    margin: ${vGap}px 0;
  `

  let crossPostNote = css`
    &,
    & a {
      font-style: italic;
      color: ${Theme.fadedTextColor};
      transition-property: color;
      transition-duration: ${Transition.moderate};
      transition-timing-function: ${Transition.timingFunction};
    }
  `

  let highlightRow = css`
    margin: ${vGap * 2}px 0;
  `

  let highlight = css`
    color: ${Theme.fadedTextColor};
    transition-property: color;
    transition-duration: ${Transition.moderate};
    transition-timing-function: ${Transition.timingFunction};
    font-style: italic;
    text-align: center;

    @media ${Screen.small} {
      font-size: 1.3em;
      word-break: break-all;
    }

    @media ${Screen.large} {
      font-size: 1.5em;
    }
  `

  let mediaCaption = css`
    margin: 14px 0 0;
    color: ${Theme.fadedTextColor};
    transition-property: color;
    transition-duration: ${Transition.moderate};
    transition-timing-function: ${Transition.timingFunction};
    font-size: 0.8em;
    text-align: center;
  `

  let coverImageHeight = "60vh"

  let coverImageRow = css`
    margin: 0 0 ${vGap}px;
  `

  let coverImageFigure = css`
    display: flex;
    position: relative;
    flex-flow: column nowrap;
    align-items: center;
    justify-content: center;
    overflow: hidden;

    @media ${Screen.small} {
      height: calc(100vh - ${LayoutParams.smallScreenHeaderHeight +
    LayoutParams.smallScreenRowGap * 2}px);
    }

    @media ${Screen.large} {
      height: ${coverImageHeight};
    }
  `

  let coverImageOverlay = css`
    display: flex;
    position: absolute;
    top: 0;
    right: 0;
    bottom: 0;
    left: 0;
    width: 100%;
    background-color: rgba(0, 0, 0, 0.2);
    box-shadow: inset 0 0 8em #000;
  `

  let coverImageContainer = css`
    @media ${Screen.small} {
      height: 100%;
    }

    @media ${Screen.large} {
      width: 100%;
      height: ${coverImageHeight};
    }
  `

  let coverImage = css`
    object-fit: cover;

    @media ${Screen.small} {
      height: 100%;
    }

    @media ${Screen.large} {
      width: 100%;
      height: ${coverImageHeight};
    }
  `

  let coverImageTitleContainer = css`
    position: absolute;
    display: block;
    top: 50%;
    transform: translateY(-100%);
    max-width: 80vw;
    text-align: center;
  `

  let coverImageTitleText = css`
    display: inline;
    padding: 2px 8px;
    color: ${Color.white};
    line-height: 1.4;
  `

  let coverImageTitleBgColorBlue = css`
    background-color: ${Color.blue};
  `

  let coverImageTitleBgColorOrange = css`
    background-color: ${Color.orange};
  `

  let coverImageCredit = css`
    position: absolute;
    bottom: 8px;
    font-size: 10px;
    text-align: center;
    text-shadow: 0 0 2px rgba(0, 0, 0, 0.3);
    white-space: nowrap;

    &,
    & a {
      color: #666;
    }
  `

  let inlineImageRow = css`
    margin: ${vGap * 2}px 0;

    .${h2Row} + &,
    .${h3Row} + & {
      margin-top: 30px;
    }
  `

  let inlineImageFigure = css`
    display: flex;
    position: relative;
    flex-flow: column nowrap;
    align-items: center;
  `

  let inlineImage = css`
    position: relative;
  `

  let inlineImagePlacementCenterMaxWidth = 0.9
  let inlineImagePlacementCenter = css`
    @media ${Screen.small} {
      max-width: 100%;
    }

    @media ${Screen.large} {
      max-width: ${inlineImagePlacementCenterMaxWidth * 100}%;
    }
  `

  let inlineImagePlacementFill = css`
    width: 100%;
  `

  let bleed = 210
  let bleedScreen = `only screen and (min-width: ${(Screen.smallMaxWidth + 1)
      ->Int.toString}px) and (max-width: ${(LayoutParams.largeScreenContentWidth + bleed)
      ->Int.toString}px)`

  let inlineImagePlacementBleed = css`
    @media ${Screen.small} {
      width: 100%;
    }

    @media ${Screen.large} {
      width: calc(100% + ${bleed}px);
    }

    /* Must go after Screen.large */
    @media ${bleedScreen} {
      width: 100%;
    }
  `

  let galleryRow = css`
    position: relative;
    margin: ${vGap}px 0;
  `

  let galleryLayout = css`
    display: grid;
    position: relative;

    & button figure,
    & button figure img {
      width: 100%;
      height: 100%;
    }
  `

  let galleryLayout_Small = css`
    @media ${Screen.small} {
      & button:nth-child(1) {
        width: 100%;
      }
    }
  `

  let galleryLayout_One = css`
    @media ${Screen.large} {
      & button:nth-child(1) {
        grid-area: 1 / 1 / 2 / 2;
      }
    }
  `

  let galleryLayout_L1_L2 = css`
    @media ${Screen.large} {
      & button:nth-child(1) {
        grid-area: 1 / 1 / 3 / 2;
      }

      & button:nth-child(2) {
        grid-area: 1 / 2 / 2 / 3;
      }

      & button:nth-child(3) {
        grid-area: 2 / 2 / 3 / 3;
      }
    }
  `

  let galleryLayout_LPS1_LPS1 = css`
    @media ${Screen.large} {
      & button:nth-child(1) {
        grid-area: 1 / 1 / 2 / 2;
      }

      & button:nth-child(2) {
        grid-area: 1 / 2 / 2 / 3;
      }
    }
  `

  let galleryLayout_P1_P1_P1 = css`
    @media ${Screen.large} {
      & button:nth-child(1) {
        grid-area: 1 / 1 / 2 / 2;
      }

      & button:nth-child(2) {
        grid-area: 1 / 2 / 2 / 3;
      }

      & button:nth-child(3) {
        grid-area: 1 / 3 / 2 / 4;
      }
    }
  `

  let galleryThumb = css`
    position: relative;
    line-height: 0;
  `

  let galleryPlusBadgeSize = 50
  let galleryPlusBadgeColor = Color.orange

  let galleryPlusBadgeTriangleOverlay = css`
    display: flex;
    position: absolute;
    right: 0;
    bottom: 0;
    width: 0;
    height: 0;
    border-bottom: ${galleryPlusBadgeSize}px solid white;
    border-left: ${galleryPlusBadgeSize}px solid transparent;
    opacity: 0;
    transition: opacity ${Transition.fast} ${Transition.timingFunction};
  `
  let galleryPlusBadgeTriangle = css`
    display: flex;
    position: absolute;
    right: 0;
    bottom: 0;
    width: 0;
    height: 0;
    border-bottom: ${galleryPlusBadgeSize}px solid ${galleryPlusBadgeColor};
    border-left: ${galleryPlusBadgeSize}px solid transparent;
  `

  let galleryPlusBadgeText = css`
    display: flex;
    position: absolute;
    right: 0;
    bottom: 0;
    align-items: center;
    justify-content: center;
    width: ${galleryPlusBadgeSize / 1.55}px;
    height: ${galleryPlusBadgeSize / 1.55}px;
    font-family: ${Font.heading};
    font-weight: ${Font.bold};
    color: white;
  `

  let galleryPlusBadgeTextLarger = css`
    font-size: ${galleryPlusBadgeSize / 3}px;
  `

  let galleryPlusBadgeTextSmaller = css`
    font-size: ${galleryPlusBadgeSize / 4}px;
  `

  let galleryPlusBadge = css`
    display: flex;
    position: absolute;
    right: 0;
    bottom: 0;
    width: ${galleryPlusBadgeSize}px;
    height: ${galleryPlusBadgeSize}px;

    &:focus .${galleryPlusBadgeTriangleOverlay},
    &:hover .${galleryPlusBadgeTriangleOverlay} {
      opacity: 0.15;
    }
  `

  let videoRow = css`
    margin: ${vGap}px 0;
  `

  let videoContainer = css`
    position: relative;
    padding-bottom: 56.25%; /* 16:9 */
    height: 0;

    & iframe {
      position: absolute;
      top: 0;
      left: 0;
      width: 100%;
      height: 100%;
    }
  `

  let expandableRow = css`
    margin: ${vGap}px 0;
  `

  let expandableTrigger = css`
    display: grid;
    grid-template-columns: max-content max-content;
    grid-column-gap: 10px;
    align-items: center;
  `

  let expandableTriggerText = css`
    display: inline-block;
    color: ${Theme.textColor};
    border-bottom: 1px dotted ${Theme.fadedTextColor};
    transition-property: color, border-bottom-color;
    transition-duration: ${Transition.moderate};
    transition-timing-function: ${Transition.timingFunction};
  `

  let expandableTriggerIcon = css`
    transition: transform ${Transition.fast} ${Transition.timingFunction};
  `

  let expandableTriggerIconCollapsed = css`
    transform: rotate(0deg);
  `

  let expandableTriggerIconExpanded = css`
    transform: rotate(180deg);
  `

  let expandableContentBg = css`
    background-color: ${Theme.postExpandableContentBgColor};
  `

  let socialSharingContainer = css`
    display: grid;

    @media ${Screen.large} {
      position: fixed;
      top: 100px;
      left: 50%;
      transform: translateX(-${LayoutParams.largeScreenContentWidth / 2}px);
      grid-template-columns: max-content;
      grid-template-rows: max-content max-content max-content;
      grid-row-gap: 20px;
      justify-items: center;
    }
  `

  let footerRow = css`
    display: grid;
    align-items: center;
    justify-content: center;

    @media ${Screen.small} {
      width: 100vw;
      grid-template-columns: 1fr;
      margin: 10px 0 0;
    }

    @media ${Screen.large} {
      width: ${LayoutParams.largeScreenContentWidth}px;
      grid-template-columns: ${LayoutParams.largeScreenContentWidth}px;
      margin: 30px 0 0;
    }
  `

  let footerRowInner = css`
    display: grid;

    @media ${Screen.small} {
      grid-template-columns: 1fr max-content 1fr;
      grid-template-rows: max-content;
      grid-column-gap: 10px;
      align-items: center;
    }

    @media ${Screen.large} {
      grid-template-columns: 1fr max-content 1fr;
      grid-template-rows: max-content;
      grid-column-gap: 10px;
      align-items: center;
    }
  `

  let footerNavLinkSmallScreenHPad = LayoutParams.smallScreenHPad
  let footerNavLinkLargeScreenHPad = 50

  let footerNavLink = css`
    display: grid;
    grid-template-columns: max-content;
    grid-column-gap: 7px;
    align-items: center;
    transition: background-color ${Transition.fast} ${Transition.timingFunction};
    background-color: transparent;
    border-radius: 6px;

    @media ${Screen.mouse} {
      &:hover {
        background-color: ${Theme.postFooterNavLinkHoverBgColor};
      }
    }

    @media ${Screen.small} {
      padding: 18px ${footerNavLinkSmallScreenHPad}px;
    }

    @media ${Screen.large} {
      padding: 14px ${footerNavLinkLargeScreenHPad}px;
    }
  `

  let prevPost = css`
    display: grid;
    align-items: center;
    justify-content: start;

    @media ${Screen.large} {
      transform: translateX(-${footerNavLinkLargeScreenHPad}px);
    }
  `

  let nextPost = css`
    display: grid;
    align-items: center;
    justify-content: end;

    @media ${Screen.large} {
      transform: translateX(${footerNavLinkLargeScreenHPad}px);
    }
  `

  let footerNote = css`
    font-size: 14px;
  `

  let footerNoteLink = css`
    color: ${Theme.fadedTextColor};

    @media ${Screen.mouse} {
      &:focus path,
      &:hover path {
        fill: ${Color.twitter};
      }
    }
  `

  let footerNoteLinkText = css`
    display: inline-block;
    margin-right: 11px;
  `
)
