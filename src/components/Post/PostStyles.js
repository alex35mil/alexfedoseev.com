import { css } from "linaria";

import { Color, Font, Transition, Layout } from "styles";

export const container = css`
  display: grid;
  grid-template-rows: max-content 1fr;
  justify-content: center;
  justify-items: center;

  @media ${Layout.smallScreen} {
    grid-row-gap: 16px;
  }

  @media ${Layout.largeScreen} {
    grid-row-gap: 10px;
  }
`;

export const title = css`
  display: grid;

  @media ${Layout.smallScreen} {
    grid-template-rows: max-content max-content;
    grid-row-gap: 16px;
    justify-content: center;
    justify-items: center;
    padding: 0 ${Layout.smallScreenHPad}px;
    text-align: center;
  }

  @media ${Layout.largeScreen} {
    grid-template-columns: ${Layout.largeScreenLeftColWidth}px ${Layout.largeScreenRightColWidth}px;
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
