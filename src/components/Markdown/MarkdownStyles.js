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
  }

  @media ${Layout.largeScreen} {
    grid-template-columns: ${Layout.largeScreenLeftColWidth}px 1fr;
    grid-template-rows: auto;
    grid-column-gap: ${Layout.largeScreenColGap}px;
    align-content: start;
  }
`;

export const rowWithSidenote = css`
  align-items: baseline;

  @media ${Layout.smallScreen} {
    grid-column-gap: 10px;
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
    margin-left: calc(1em + ${Layout.smallScreenVPad}px);
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

export const pre = css`
  padding: 20px 30px;
  background-color: #f5f2f0;
  border-radius: 3px;
`;

export const code = css`
  font-family: ${Font.mono};
  font-size: 16px;
  line-height: 1.8;
`;

export const noteRow = css`
  margin: ${gap}px 0;
`;

export const note = css`
  color: ${Color.grayText};
  font-style: italic;
`;

export const imageRow = css`
  margin: ${gap}px 0;

  .${h2Row} + &,
  .${h3Row} + & {
    margin-top: 30px;
  }
`;

export const imageFigure = css`
  display: flex;
  flex-flow: column nowrap;
  align-items: center;
`;

export const image = css`
  width: 100%;
  max-height: 100%;
`;

export const imageCaption = css`
  margin: 6px 0;
  color: ${Color.grayText};
  font-size: 0.8em;
  text-align: center;
`;
