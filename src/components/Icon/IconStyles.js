import { css } from "linaria";

import { Color, Transition } from "styles";

export const sm = 16;

export const icon = css`
  transition-duration: ${Transition.fast};
  transition-timing-function: ${Transition.timingFunction};
`;

export const smSize = css`
  width: ${sm}px;
  height: ${sm}px;
`;