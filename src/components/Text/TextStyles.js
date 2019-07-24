import { css } from "linaria";

import { Font } from "styles";

export const ellipsis = css`
  display: block;
  overflow: hidden;
  white-space: nowrap;
  text-overflow: ellipsis;
`;
