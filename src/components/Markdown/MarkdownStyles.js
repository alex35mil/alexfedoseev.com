import { css } from "linaria";

import { Font } from "styles";

export const markdown = css`
  display: flex;
  flex-flow: column nowrap;
  align-items: center;
  justify-content: flex-start;
`;

export const h1 = css`
  display: flex;
  font-size: 40px;
  font-weight: ${Font.bold};
`;

export const p = css`
  margin: 10px 0;
`;
