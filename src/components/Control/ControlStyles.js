import { css } from "linaria";

import { Font } from "styles";

export const control = css`
  display: flex;
  appearance: none;
  border-width: 0;
  background-image: none;
  background-color: transparent;
  cursor: pointer;
  color: currentColor;
  font-family: ${Font.mono};
  font-size: 1em;
  line-height: inherit;
`;
