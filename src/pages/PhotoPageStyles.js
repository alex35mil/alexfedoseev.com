import { css } from "linaria";

import { Color, Font, Transition, Screen, Layout } from "styles";

export const smallContainerWidth = 300;
export const mediumContainerWidth = 450;
export const largeContainerWidth = Layout.largeScreenContentWidth;

export const smallScreenMaxWidth = 440;
export const mediumScreenMaxWidth = 600;

export const smallScreen = `only screen and (max-width: ${smallScreenMaxWidth}px)`;
export const mediumScreen = `only screen and (min-width: ${smallScreenMaxWidth + 1}px) and (max-width: ${mediumScreenMaxWidth}px)`;
export const largeScreen = `only screen and (min-width: ${mediumScreenMaxWidth + 1}px)`;

export const photos = css`
  display: block;
  position: relative;

  @media ${smallScreen} {
    width: ${smallContainerWidth}px;
  }

  @media ${mediumScreen} {
    width: ${mediumContainerWidth}px;
  }

  @media ${largeScreen} {
    width: ${largeContainerWidth}px;
  }
`;
