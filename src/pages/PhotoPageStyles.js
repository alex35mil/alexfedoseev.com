import { css } from "linaria";

import { Color, Font, Transition, Screen, Layout } from "styles";

export const photos = css`
  display: block;
  position: relative;

  @media ${Screen.small} {
    margin: 0 ${Layout.smallScreenHPad}px;
  }

  @media ${Screen.large} {
    width: ${Layout.largeScreenContentWidth}px;
  }
`;

export const thumb = css`
  position: absolute;
`;
