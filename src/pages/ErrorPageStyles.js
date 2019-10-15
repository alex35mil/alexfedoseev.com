import { css } from "linaria";

import { Color, Font, Theme, Transition, Screen, Layout } from "styles";

export const container = css`
  display: grid;

  @media ${Screen.small} {
    grid-template-rows: max-content max-content;
    grid-row-gap: 12px;
    align-content: center;
    align-items: center;
    justify-content: center;
    justify-items: center;
  }

  @media ${Screen.large} {
    grid-template-columns: max-content max-content max-content;
    grid-template-rows: 1fr;
    grid-column-gap: 50px;
    align-content: center;
    align-items: center;
    justify-content: center;
  }
`;

export const fourOFour = css`
  font-size: 100px;
`;

export const texts = css`
  display: grid;
  grid-template-rows: max-content max-content;
  grid-row-gap: 8px;

  @media ${Screen.small} {
    text-align: center;
  }
`;

export const notFound = css`
  font-size: 1.3em;
`;

export const line = css`
  @media ${Screen.small} {
    display: none;
  }

  @media ${Screen.large} {
    display: flex;
    height: 120px;
    width: 1px;
    background-color: ${Theme.lineColor};
    transition-property: background-color;
    transition-duration: ${Transition.moderate};
    transition-timing-function: ${Transition.timingFunction};
  }
`;
