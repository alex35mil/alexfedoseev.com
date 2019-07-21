import { css } from "linaria";

import { Font } from "styles";

export const link = css`
  cursor: pointer;
`;

export const text = css`
  margin: -1px;
  padding: 1px;
  border-radius: 1px;
  color: ${Font.color};
  background-color: transparent;
  text-decoration: underline;
  text-decoration-skip: ink;
  text-decoration-skip-ink: auto;
  text-decoration-style: solid;
  -webkit-text-decoration-skip: objects;

  &:focus {
    background-color: rgba(0, 0, 0, 0.05);
  }
`;

export const box = css`
  text-decoration: none;

  &:focus,
  &:hover {
    text-decoration: none;
  }
`;
