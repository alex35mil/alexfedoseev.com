import { css } from "linaria";

import { Color, Font, Transition, Screen, Layout } from "styles";

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
