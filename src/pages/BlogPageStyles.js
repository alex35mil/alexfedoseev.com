import { css } from "linaria";

import { Color, Font, Transition, Screen, Layout } from "styles";

export const years = css`
  display: grid;
  grid-auto-flow: row;
  grid-template-rows: max-content;

  @media ${Screen.small} {
    grid-row-gap: ${Layout.smallScreenRowGap}px;
    padding: 0 ${Layout.smallScreenHPad}px;
  }

  @media ${Screen.large} {
    grid-template-columns: ${Layout.largeScreenContentWidth}px;
    grid-row-gap: ${Layout.largeScreenRowGap}px;
  }
`;

export const yearContainer = css`
  display: grid;
  grid-auto-flow: row;
  grid-auto-rows: max-content;
  grid-row-gap: 3px;

  @media ${Screen.small} {
    grid-auto-rows: max-content;
    justify-content: center;
    justify-items: center;
  }

  @media ${Screen.large} {
    grid-auto-rows: max-content;
  }
`;

export const post = css`
  display: grid;

  @media ${Screen.small} {
    justify-content: center;
    justify-items: center;
    text-align: center;
  }

  @media ${Screen.large} {
    grid-template-columns: ${Layout.largeScreenLeftColWidth}px ${Layout.largeScreenRightColWidth}px;
    grid-template-rows: max-content;
    grid-column-gap: ${Layout.largeScreenColGap}px;
    align-content: center;
    align-items: center;
  }
`;

export const year = css`
  @media ${Screen.small} {
    margin-bottom: 10px;
  }

  @media ${Screen.large} {
    margin-bottom: 0;
  }
`;

export const link = css`
  font-size: 0.9em;

  @media ${Screen.small} {
    font-size: 0.8em;
    /* text-overflow: ellipsis requires non-relative width to be set */
    max-width: calc(100vw - ${Layout.smallScreenHPad * 2}px);
  }

  @media ${Screen.large} {
    font-size: 0.9em;
  }
`;
