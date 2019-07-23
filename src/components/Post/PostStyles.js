import { css } from "linaria";

import { Color, Font, Transition, Layout } from "styles";

export const container = css`
  display: grid;
  grid-template-rows: max-content 1fr;
  grid-row-gap: 10px;
`;

export const title = css`
  display: grid;

  @media ${Layout.smallScreen} {
    grid-template-rows: max-content max-content;
    grid-row-gap: 16px;
    justify-content: center;
    justify-items: center;
    text-align: center;
  }

  @media ${Layout.largeScreen} {
    grid-template-columns: ${Layout.largeScreenLeftColWidth}px 1fr;
    grid-template-rows: max-content;
    grid-column-gap: ${Layout.largeScreenColGap}px;
    align-content: center;
    align-items: baseline;
  }
`;

export const date = css`
  @media ${Layout.smallScreen} {
    order: 1;
    text-align: center;
  }
`;

export const post = css`
  display: grid;

  @media ${Layout.smallScreen} {
    align-content: start;
  }

  @media ${Layout.largeScreen} {
    grid-template-columns: ${Layout.largeScreenLeftColWidth}px 1fr;
    grid-template-rows: max-content;
    grid-column-gap: ${Layout.largeScreenColGap}px;
    align-content: start;
  }
`;
