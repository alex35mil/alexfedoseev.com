import { css } from "linaria";

import { Color, Font, Theme, Transition, Screen, Layout } from "styles";

export const container = css`
  display: grid;
  grid-template-rows: max-content 1fr;
  justify-content: center;
  justify-items: center;

  @media ${Screen.small} {
    grid-row-gap: 16px;
  }

  @media ${Screen.large} {
    grid-row-gap: 10px;
  }
`;

export const title = css`
  display: grid;

  @media ${Screen.small} {
    grid-template-rows: max-content max-content;
    grid-row-gap: 16px;
    justify-content: center;
    justify-items: center;
    padding: 0 ${Layout.smallScreenHPad}px;
    text-align: center;
  }

  @media ${Screen.large} {
    grid-template-columns: ${Layout.largeScreenLeftColWidth}px ${Layout.largeScreenRightColWidth}px;
    grid-template-rows: max-content;
    grid-column-gap: ${Layout.largeScreenColGap}px;
    align-content: center;
    align-items: baseline;
  }
`;

export const date = css`
  @media ${Screen.small} {
    order: 1;
    text-align: center;
  }
`;

export const content = css`
  display: grid;
  grid-auto-flow: row;
  grid-auto-rows: auto;
  align-content: start;
  justify-content: start;
`;

const gap = 14;

export const row = css`
  display: grid;

  @media ${Screen.small} {
    grid-template-rows: auto;
    grid-template-columns: max-content auto;
    align-content: start;
    padding: 0 ${Layout.smallScreenHPad}px;
  }

  @media ${Screen.large} {
    grid-template-columns: ${Layout.largeScreenLeftColWidth}px ${Layout.largeScreenRightColWidth}px;
    grid-template-rows: auto;
    grid-column-gap: ${Layout.largeScreenColGap}px;
    align-content: start;
    justify-content: center;
  }
`;

export const rowWithSidenote = css`
  align-items: baseline;

  @media ${Screen.small} {
    grid-column-gap: 10px;
  }
`;

export const expandedRow = css`
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
`;

export const h1 = css`
  display: flex;
  font-family: ${Font.heading};
  font-size: 34px;
  font-weight: ${Font.bold};
  color: ${Theme.textColor};
  transition-property: color;
  transition-duration: ${Transition.moderate};
  transition-timing-function: ${Transition.timingFunction};
`;

export const h2Row = css`
  margin: ${gap}px 0 0;
`;

export const h2 = css`
  display: flex;
  font-family: ${Font.heading};
  font-size: 24px;
  font-weight: ${Font.bold};
  color: ${Theme.textColor};
  transition-property: color;
  transition-duration: ${Transition.moderate};
  transition-timing-function: ${Transition.timingFunction};
`;

export const h3Row = css`
  margin: ${gap}px 0 0;
`;

export const h3 = css`
  display: flex;
  font-family: ${Font.heading};
  font-size: 20px;
  color: ${Theme.fadedTextColor};
  transition-property: color;
  transition-duration: ${Transition.moderate};
  transition-timing-function: ${Transition.timingFunction};
`;

export const h4Row = css`
  margin: ${gap}px 0 0;
`;

export const h4 = css`
  display: flex;
  font-family: ${Font.mono};
  font-size: 20px;
  color: ${Theme.fadedTextColor};
  transition-property: color;
  transition-duration: ${Transition.moderate};
  transition-timing-function: ${Transition.timingFunction};
`;

export const pRow = css`
  margin: ${gap}px 0;

  .${h2Row} + &,
  .${h3Row} + & {
    margin-top: 8px;
  }
`;

export const p = css`
  margin: 0;
  color: ${Theme.textColor};
  transition-property: color;
  transition-duration: ${Transition.moderate};
  transition-timing-function: ${Transition.timingFunction};
`;

export const listRow = css`
  margin: ${gap}px 0;
`;

export const list = css`
  @media ${Screen.small} {
    margin-left: calc(1em + ${Layout.smallScreenHPad}px);
  }
`;

export const ol = css`
  list-style-type: none;

  & li {
    counter-increment: oli-counter;

    &::before {
      content: counter(oli-counter) ".";
      display: block;
      position: relative;
      max-width: 0px;
      max-height: 0px;
      left: -1.7em;
      color: ${Theme.fadedTextColor};
      transition-property: color;
      transition-duration: ${Transition.moderate};
      transition-timing-function: ${Transition.timingFunction};
    }
  }
`;

export const ul = css`
  list-style-type: none;

  & li::before {
    content: "—";
    display: block;
    position: relative;
    max-width: 0px;
    max-height: 0px;
    left: -1.7em;
    color: ${Theme.fadedTextColor};
    transition-property: color;
    transition-duration: ${Transition.moderate};
    transition-timing-function: ${Transition.timingFunction};
  }
`;

export const li = css`
  margin-bottom: 4px;
  color: ${Theme.textColor};
  transition-property: color;
  transition-duration: ${Transition.moderate};
  transition-timing-function: ${Transition.timingFunction};
`;

export const hrRow = css`
  margin: ${gap}px 0;
`;

export const hr = css`
  display: flex;
  border-width: 0;
  border-top: 1px solid ${Theme.lineColor};
  transition-property: border-top-color;
  transition-duration: ${Transition.moderate};
  transition-timing-function: ${Transition.timingFunction};
`;

export const inlineCode = css`
  font-family: ${Font.mono};
  font-style: italic;
  color: ${Theme.fadedTextColor};
  transition-property: color;
  transition-duration: ${Transition.moderate};
  transition-timing-function: ${Transition.timingFunction};
`;

export const codeRow = css`
  margin: ${gap}px 0;
`;

const largeScreenCodeVPad = 20;
const smallScreenCodeVPad = 20;

export const pre = css`
  display: flex;
  position: relative;
  flex-flow: column nowrap;
  align-items: center;
  background-color: ${Theme.codeBgColor};
  transition-property: background-color;
  transition-duration: ${Transition.moderate};
  transition-timing-function: ${Transition.timingFunction};

  @media ${Screen.small} {
    padding: ${smallScreenCodeVPad}px ${Layout.smallScreenHPad}px;
    overflow-x: auto;
  }

  @media ${Screen.large} {
    padding: ${largeScreenCodeVPad}px 0;
  }
`;

export const code = css`
  font-family: ${Font.mono};
  font-size: 16px;
  color: ${Theme.codeColor};
  transition-property: color;
  transition-duration: ${Transition.moderate};
  transition-timing-function: ${Transition.timingFunction};
  line-height: 1.8;

  @media ${Screen.small} {
    width: 100%;
    padding-right: ${Layout.smallScreenHPad}px;
  }

  @media ${Screen.large} {
    width: ${Layout.largeScreenContentWidth}px;
    padding-left: ${Layout.largeScreenLeftColWidth + Layout.largeScreenColGap}px;
    overflow: visible;
  }
`;

export const codeLabelsRow = css`
  position: relative;
  overflow: visible;

  @media ${Screen.small} {
    width: 100%;
  }

  @media ${Screen.large} {
    width: ${Layout.largeScreenContentWidth}px;
  }
`;

export const codeLabelsRowWithFile = css`
  height: 1em;
`;

export const codeLabelsRowWithoutFile = css`
  height: 0;
`;

const languageLabelHPad = 7;

export const codeLabel = css`
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
`;

export const languageLabel = css`
  text-transform: uppercase;
  right: -${languageLabelHPad}px;
`;

export const fileLabel = css`
  @media ${Screen.small} {
    left: -${languageLabelHPad}px;
  }

  @media ${Screen.large} {
    left: ${Layout.largeScreenLeftColWidth + Layout.largeScreenColGap - languageLabelHPad}px;
  }
`;

export const global = css`
  :global code[class*="language-"],
  :global pre[class*="language-"] {
    color: black;
    background: none;
    text-shadow: 0 1px white;
    font-family: Consolas, Monaco, 'Andale Mono', 'Ubuntu Mono', monospace;
    font-size: 1em;
    text-align: left;
    white-space: pre;
    word-spacing: normal;
    word-break: normal;
    word-wrap: normal;
    line-height: 1.5;

    -moz-tab-size: 4;
    -o-tab-size: 4;
    tab-size: 4;

    -webkit-hyphens: none;
    -moz-hyphens: none;
    -ms-hyphens: none;
    hyphens: none;
  }

  :global pre[class*="language-"]::-moz-selection,
  :global pre[class*="language-"] ::-moz-selection,
  :global code[class*="language-"]::-moz-selection,
  :global code[class*="language-"] ::-moz-selection {
    text-shadow: none;
    background: #b3d4fc;
  }

  :global pre[class*="language-"]::selection,
  :global pre[class*="language-"] ::selection,
  :global code[class*="language-"]::selection,
  :global code[class*="language-"] ::selection {
    text-shadow: none;
    background: #b3d4fc;
  }

  @media print {
    :global code[class*="language-"],
    :global pre[class*="language-"] {
      text-shadow: none;
    }
  }

  /* Code blocks */
  :global pre[class*="language-"] {
    padding: 1em;
    margin: .5em 0;
    overflow: auto;
  }

  :global :not(pre) > code[class*="language-"],
  :global pre[class*="language-"] {
    background: #f5f2f0;
  }

  /* Inline code */
  :global :not(pre) > code[class*="language-"] {
    padding: .1em;
    border-radius: .3em;
    white-space: normal;
  }

  :global .token.comment,
  :global .token.prolog,
  :global .token.doctype,
  :global .token.cdata {
    color: slategray;
  }

  :global .token.punctuation {
    color: #999;
  }

  :global .namespace {
    opacity: .7;
  }

  :global .token.property,
  :global .token.tag,
  :global .token.boolean,
  :global .token.number,
  :global .token.constant,
  :global .token.symbol,
  :global .token.deleted {
    color: ${Theme.codeTokenConstantColor};
    transition-property: color;
    transition-duration: ${Transition.moderate};
    transition-timing-function: ${Transition.timingFunction};
  }

  :global .token.selector,
  :global .token.attr-name,
  :global .token.string,
  :global .token.char,
  :global .token.builtin,
  :global .token.inserted {
    color: #690;
  }

  :global .token.operator,
  :global .token.entity,
  :global .token.url,
  :global .language-css .token.string,
  :global .style .token.string {
    color: #9a6e3a;
    background: none;
  }

  :global .token.atrule,
  :global .token.attr-value,
  :global .token.keyword {
    color: ${Theme.codeTokenKeywordColor};
    transition-property: color;
    transition-duration: ${Transition.moderate};
    transition-timing-function: ${Transition.timingFunction};
  }

  :global .token.function,
  :global .token.class-name {
    color: #DD4A68;
  }

  :global .token.regex,
  :global .token.important,
  :global .token.variable {
    color: #e90;
  }

  :global .token.important,
  :global .token.bold {
    font-weight: bold;
  }

  :global .token.italic {
    font-style: italic;
  }

  :global .token.entity {
    cursor: help;
  }
`;

export const noteRow = css`
  margin: ${gap}px 0;
`;

export const note = css`
  &,
  & a {
    color: ${Theme.fadedTextColor};
    transition-property: color;
    transition-duration: ${Transition.moderate};
    transition-timing-function: ${Transition.timingFunction};
  }
`;

export const highlightRow = css`
  margin: ${gap * 2}px 0;
`;

export const highlight = css`
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
`;

export const image = css`
  /* NOTE: Do not add transform to this list since it's used in inline style */
  transition-property: filter, opacity;
  transition-duration: 0.2s;
  transition-timing-function: linear;
`;

export const loadingImage = css`
  filter: blur(5px);
  opacity: 0;
`;

export const loadedImage = css`
  filter: blur(0);
  opacity: 1;
`;

export const coverImageRow = css`
  margin: ${gap}px 0;
`;

export const coverImageFigure = css`
  display: flex;
  position: relative;
  flex-flow: column nowrap;
  align-items: center;
  justify-content: center;
  overflow: hidden;

  @media ${Screen.small} {
    height: 220px;
  }

  @media ${Screen.large} {
    height: 320px;
  }
`;

export const coverImageOverlay = css`
  display: flex;
  position: absolute;
  top: 0;
  right: 0;
  bottom: 0;
  left: 0;
  width: 100%;
  background-color: rgba(0, 0, 0, 0.2);
  box-shadow: inset 0 0 8em #000;
`;

export const coverImage = css`
  object-fit: cover;
  width: 100%;
`;

export const coverImageCredit = css`
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
`;

export const inlineImageRow = css`
  margin: ${gap * 2}px 0;

  .${h2Row} + &,
  .${h3Row} + & {
    margin-top: 30px;
  }
`;

export const inlineImageFigure = css`
  display: flex;
  position: relative;
  flex-flow: column nowrap;
  align-items: center;
`;

export const inlineImage = css`
  position: relative;
`;

export const inlineImageCaption = css`
  margin: 14px 0 0;
  color: ${Theme.fadedTextColor};
  transition-property: color;
  transition-duration: ${Transition.moderate};
  transition-timing-function: ${Transition.timingFunction};
  font-size: 0.8em;
  text-align: center;
`;

export const inlineImagePlacementCenter = css`
  @media ${Screen.small} {
    width: 100%;
  }

  @media ${Screen.large} {
    width: auto;
    max-width: 90%;
  }
`;

export const inlineImagePlacementFill = css`
  width: 100%;
`;

export const inlineImagePlacementBleed = css`
  @media ${Screen.small} {
    width: 100%;
  }

  @media ${Screen.large} {
    width: calc(100% + 210px);
  }
`;

export const expandableRow = css`
  margin: ${gap}px 0;
`;

export const expandableTrigger = css`
  display: grid;
  grid-template-columns: max-content max-content;
  grid-column-gap: 10px;
  align-items: center;
`;

export const expandableTriggerText = css`
  display: inline-block;
  color: ${Theme.textColor};
  border-bottom: 1px dotted ${Theme.fadedTextColor};
  transition-property: color, border-bottom-color;
  transition-duration: ${Transition.moderate};
  transition-timing-function: ${Transition.timingFunction};
`;

export const expandableTriggerIcon = css`
  transition: transform ${Transition.fast} ${Transition.timingFunction};
`;

export const expandableTriggerIconCollapsed = css`
  transform: rotate(0deg);
`;

export const expandableTriggerIconExpanded = css`
  transform: rotate(180deg);
`;

export const socialSharingContainer = css`
  display: grid;

  @media ${Screen.large} {
    position: fixed;
    top: 100px;
    left: 50%;
    transform: translateX(-${Layout.largeScreenContentWidth / 2}px);
    grid-template-columns: max-content;
    grid-template-rows: max-content max-content max-content;
    grid-row-gap: 20px;
    justify-items: center;
  }
`;

export const footerRow = css`
  display: grid;
  align-items: center;
  justify-content: center;

  @media ${Screen.small} {
    width: 100vw;
    grid-template-columns: 1fr;
    margin: 10px 0 0;
  }

  @media ${Screen.large} {
    width: ${Layout.largeScreenRightColWidth}px;
    transform: translateX(${(Layout.largeScreenLeftColWidth + Layout.largeScreenColGap) / 2}px);
    grid-template-columns: ${Layout.largeScreenRightColWidth}px;
    margin: 30px 0 0;
  }
`;

export const footerRowInner = css`
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
`;

const footerLinkSmallScreenHPad = 30;
const footerLinkLargeScreenHPad = 50;

export const footerLink = css`
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
    padding: 18px ${footerLinkSmallScreenHPad}px;
  }

  @media ${Screen.large} {
    padding: 14px ${footerLinkLargeScreenHPad}px;
  }
`;

export const prevPost = css`
  display: grid;
  align-items: center;
  justify-content: start;

  @media ${Screen.large} {
    transform: translateX(-${footerLinkLargeScreenHPad}px);
  }
`;

export const nextPost = css`
  display: grid;
  align-items: center;
  justify-content: end;

  @media ${Screen.large} {
    transform: translateX(${footerLinkLargeScreenHPad}px);
  }
`;

export const socialSharing = css`
  display: grid;

  @media ${Screen.small} {
    grid-template-columns: max-content max-content;
    grid-column-gap: 10px;
    align-items: center;
    justify-content: center;
    justify-items: center;
  }

  @media ${Screen.large} {
    grid-template-columns: max-content max-content;
    grid-column-gap: 16px;
    align-items: center;
    justify-content: center;
    justify-items: center;
  }
`;

export const socialSharingButton = css`
  display: flex;
  padding: 6px;
  transition-property: background-color, transform;
  transition-duration: ${Transition.fast};
  transition-timing-function: ${Transition.timingFunction};
  background-color: transparent;
  border-radius: 50%;
  transform: scale(1);

  @media ${Screen.mouse} {
    &:hover {
      transform: scale(1.1);

      & path {
        fill: #fff !important;
      }
    }
  }
`;

export const socialSharingButtonTwitter = css`
  @media ${Screen.mouse} {
    &:hover {
      background-color: ${Color.twitter};
    }
  }
`;

export const socialSharingButtonFacebook = css`
  @media ${Screen.mouse} {
    &:hover {
      background-color: ${Color.facebook};
    }
  }
`;

export const socialSharingIcon = css`
  display: flex;
  width: 32px;
  height: 32px;
`;
