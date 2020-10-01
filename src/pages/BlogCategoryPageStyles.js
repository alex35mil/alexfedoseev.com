import { css } from "linaria";

import { Color, Font, Transition, Screen, Theme, Layout } from "styles";

export const container = css`
  display: grid;
  grid-template-rows: max-content max-content;

  @media ${Screen.small} {
    grid-template-columns: 1fr;
  }
`;

export const title = css`
  display: inline-block;
  margin-bottom: 10px;
  font-family: ${Font.heading};
  font-size: 34px;
  font-weight: ${Font.bold};
  color: ${Theme.textColor};
  transition-property: color;
  transition-duration: ${Transition.moderate};
  transition-timing-function: ${Transition.timingFunction};

  @media ${Screen.small} {
    justify-content: start;
    justify-items: start;
    padding: 0 ${Layout.smallScreenHPad}px;
  }

  @media ${Screen.large} {
    align-content: center;
    align-items: baseline;
    padding-left: ${Layout.largeScreenLogoWidth + Layout.largeScreenColGap}px;
    /* text-overflow: ellipsis requires non-relative width to be set */
    max-width: calc(100vw - ${Layout.smallScreenHPad * 2}px);
  }
`;

export const years = css`
  display: grid;
  grid-auto-flow: row;
  grid-auto-rows: max-content;

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
    justify-content: start;
    justify-items: start;
  }

  @media ${Screen.large} {
    grid-auto-rows: max-content;
  }
`;

export const post = css`
  display: grid;

  @media ${Screen.small} {
    justify-content: start;
    justify-items: start;
    text-align: center;
  }

  @media ${Screen.large} {
    grid-template-columns: ${Layout.largeScreenLogoWidth}px max-content;
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

export const postLink = css`
  font-size: 0.9em;
  color: ${Theme.textColor};

  @media ${Screen.small} {
    font-size: 0.8em;
    /* text-overflow: ellipsis requires non-relative width to be set */
    max-width: calc(100vw - ${Layout.smallScreenHPad * 2}px);
  }

  @media ${Screen.large} {
    font-size: 0.9em;
  }

  @media ${Screen.between(Screen.smallMaxWidth + 1, Layout.largeScreenContentWidth + 200)} {
    /* text-overflow: ellipsis requires non-relative width to be set */
    max-width: ${Layout.largeScreenRightColWidth}px;
  }
`;
