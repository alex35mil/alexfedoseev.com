import { css } from "linaria";

import { Font } from "styles";

export const markdown = css`
  display: flex;
  flex-flow: column nowrap;
  align-items: flex-start;
  justify-content: flex-start;
`;

export const h1 = css`
  display: flex;
  font-family: ${Font.heading};
  font-size: 34px;
  font-weight: ${Font.bold};
`;

export const p = css`
  margin: 10px 0;
`;
