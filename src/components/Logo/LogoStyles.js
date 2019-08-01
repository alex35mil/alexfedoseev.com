import { css } from "linaria";

import { Screen, Layout } from "styles";

const largeScreenWidth = Layout.largeScreenLeftColWidth;
const largeScreenHeight = 19;

const smallScreenWidth = 110;
const smallScreenHeight = Math.ceil(smallScreenWidth * largeScreenHeight / largeScreenWidth);

export const logo = css`
  @media ${Screen.small} {
    width: ${smallScreenWidth}px;
    height: ${smallScreenHeight}px;
  }

  @media ${Screen.large} {
    width: ${largeScreenWidth}px;
    height: ${largeScreenHeight}px;
  }
`;
