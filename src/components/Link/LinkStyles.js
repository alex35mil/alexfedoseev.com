import { css } from "linaria";

import { Font } from "styles";

export const link = css`
  position: relative;
  margin: -1px;
  padding: 1px;
  background-color: transparent;
  cursor: pointer;
  border-radius: 1px;

  color: ${Font.color};

  text-decoration: underline;
  text-decoration-skip: ink;
  text-decoration-skip-ink: auto;
  text-decoration-style: solid;
  -webkit-text-decoration-skip: objects;

  &:focus {
    background-color: rgba(0, 0, 0, 0.05);
  }
`;
