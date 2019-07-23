import { css } from "linaria";

import { Color, Transition } from "styles";

export const sm = 12;
export const md = 16;

export const icon = css`
  transition-duration: ${Transition.fast};
  transition-timing-function: ${Transition.timingFunction};
`;

export const smSize = css`
  width: ${sm}px;
  height: ${sm}px;
`;

export const mdSize = css`
  width: ${md}px;
  height: ${md}px;
`;
