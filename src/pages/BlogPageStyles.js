import { css } from "linaria";

import { Color, Font, Transition, Layout } from "styles";

export const years = css`
  display: grid;
  grid-auto-flow: row;
  grid-template-rows: max-content;

  @media ${Layout.smallScreen} {
    grid-row-gap: ${Layout.smallScreenRowGap}px;
    padding: 0 ${Layout.smallScreenHPad}px;
  }

  @media ${Layout.largeScreen} {
    grid-template-columns: ${Layout.largeScreenContentWidth}px;
    grid-row-gap: ${Layout.largeScreenRowGap}px;
  }
`;

export const yearContainer = css`
  display: grid;
  grid-auto-flow: row;
  grid-auto-rows: max-content;
  grid-row-gap: 3px;

  @media ${Layout.smallScreen} {
    grid-auto-rows: max-content;
    justify-content: center;
    justify-items: center;
  }

  @media ${Layout.largeScreen} {
    grid-auto-rows: max-content;
  }
`;

export const post = css`
  display: grid;

  @media ${Layout.smallScreen} {
    justify-content: center;
    justify-items: center;
    text-align: center;
  }

  @media ${Layout.largeScreen} {
    grid-template-columns: ${Layout.largeScreenLeftColWidth}px ${Layout.largeScreenRightColWidth}px;
    grid-template-rows: max-content;
    grid-column-gap: ${Layout.largeScreenColGap}px;
    align-content: center;
    align-items: center;
  }
`;

export const year = css`
  @media ${Layout.smallScreen} {
    margin-bottom: 10px;
  }

  @media ${Layout.largeScreen} {
    margin-bottom: 0;
  }
`;

export const link = css`
  font-size: 0.9em;

  @media ${Layout.smallScreen} {
    font-size: 0.8em;
    /* text-overflow: ellipsis requires non-relative width to be set */
    max-width: calc(100vw - ${Layout.smallScreenHPad * 2}px);
  }

  @media ${Layout.largeScreen} {
    font-size: 0.9em;
  }
`;
