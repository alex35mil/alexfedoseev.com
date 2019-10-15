import { css } from "linaria";

import { Theme, Transition } from "styles";

export const width = 120;
export const height = 15;

export const logo = css`
  fill: ${Theme.logoColor};
  transition-property: fill;
  transition-duration: ${Transition.moderate};
  transition-timing-function: ${Transition.timingFunction};
`;
