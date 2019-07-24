import { css } from "linaria";

import { Color, Font, Layout } from "styles";

const gap = 14;

export const markdown = css`
  display: grid;
  grid-auto-flow: row;
  grid-auto-rows: auto;
  align-content: start;
  justify-content: start;
`;

export const row = css`
  display: grid;

  @media ${Layout.smallScreen} {
    grid-template-rows: auto;
    grid-template-columns: max-content auto;
    align-content: start;
    padding: 0 ${Layout.smallScreenHPad}px;
  }

  @media ${Layout.largeScreen} {
    grid-template-columns: ${Layout.largeScreenLeftColWidth}px ${Layout.largeScreenRightColWidth}px;
    grid-template-rows: auto;
    grid-column-gap: ${Layout.largeScreenColGap}px;
    align-content: start;
    justify-content: center;
  }
`;

export const rowWithSidenote = css`
  align-items: baseline;

  @media ${Layout.smallScreen} {
    grid-column-gap: 10px;
  }
`;

export const expandedRow = css`
  display: grid;

  @media ${Layout.smallScreen} {
    grid-template-rows: auto;
    grid-template-columns: 1fr;
    align-content: start;
  }

  @media ${Layout.largeScreen} {
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
`;

export const h2Row = css`
  margin: ${gap}px 0 0;
`;

export const h2 = css`
  display: flex;
  font-family: ${Font.heading};
  font-size: 24px;
  font-weight: ${Font.bold};
`;

export const h3Row = css`
  margin: ${gap}px 0 0;
`;

export const h3 = css`
  display: flex;
  font-family: ${Font.heading};
  font-size: 20px;
  color: ${Color.grayText};
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
`;

export const listRow = css`
  margin: ${gap}px 0;
`;

export const list = css`
  @media ${Layout.smallScreen} {
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
      color: ${Color.grayText};
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
    color: ${Color.grayText};
  }
`;

export const inlineCode = css`
  font-family: ${Font.mono};
  font-style: italic;
  color: ${Color.grayText};
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
  background-color: #f5f2f0;

  @media ${Layout.smallScreen} {
    padding: ${smallScreenCodeVPad}px ${Layout.smallScreenHPad}px;
    overflow-x: auto;
  }

  @media ${Layout.largeScreen} {
    padding: ${largeScreenCodeVPad}px 0;
  }
`;

export const code = css`
  font-family: ${Font.mono};
  font-size: 16px;
  line-height: 1.8;

  @media ${Layout.smallScreen} {
    width: 100%;
    padding-right: ${Layout.smallScreenHPad}px;
  }

  @media ${Layout.largeScreen} {
    width: ${Layout.largeScreenContentWidth}px;
    padding-left: ${Layout.largeScreenLeftColWidth + Layout.largeScreenColGap}px;
    overflow: visible;
  }
`;

export const languageRow = css`
  position: relative;
  overflow: visible;

  @media ${Layout.smallScreen} {
    width: 100%;
    height: 1em;
  }

  @media ${Layout.largeScreen} {
    width: ${Layout.largeScreenContentWidth}px;
    height: 0;
  }
`;

const languageLabelHPad = 7;

export const languageLabel = css`
  display: flex;
  position: absolute;
  top: -${largeScreenCodeVPad}px;
  background-color: #e7e7e7;
  padding: 1px ${languageLabelHPad}px;
  font-size: 0.7em;
  text-transform: uppercase;

  @media ${Layout.smallScreen} {
    left: -${languageLabelHPad}px;
  }

  @media ${Layout.largeScreen} {
    left: ${Layout.largeScreenLeftColWidth}px;
    transform: translateX(-100%);
  }
`;

export const global = css`
  :global {
    .token.operator,
    .token.entity,
    .token.url,
    .language-css .token.string,
    .style .token.string {
      background: none !important;
    }
  }
`;

export const noteRow = css`
  margin: ${gap}px 0;
`;

export const note = css`
  color: ${Color.grayText};
  font-style: italic;
`;

export const coverImageRow = css`
  margin: ${gap}px 0;
`;

export const coverImageFigure = css`
  display: flex;
  position: relative;
  flex-flow: column nowrap;
  align-items: center;
`;

export const coverImage = css`
  object-fit: cover;
  width: 100%;

  @media ${Layout.smallScreen} {
    height: 160px;
  }

  @media ${Layout.largeScreen} {
    height: 320px;
  }
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
    color: #ccc;
  }
`;

export const inlineImageRow = css`
  margin: ${gap}px 0;

  .${h2Row} + &,
  .${h3Row} + & {
    margin-top: 30px;
  }
`;

export const inlineImageFigure = css`
  display: flex;
  flex-flow: column nowrap;
  align-items: center;
`;

export const inlineImage = css`
  width: 100%;
`;

export const inlineImageCaption = css`
  margin: 6px 0;
  color: ${Color.grayText};
  font-size: 0.8em;
  text-align: center;
`;
