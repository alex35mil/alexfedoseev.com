import { css } from "linaria";

import { Color, Font, Transition } from "styles";

import * as Layout from "../Layout/LayoutStyles";

export const container = css`
  display: grid;
  grid-template-rows: max-content 1fr;
  grid-row-gap: 10px;
`;

export const title = css`
  display: grid;
  grid-template-columns: ${Layout.leftColWidth}px 1fr;
  grid-template-rows: max-content;
  grid-column-gap: ${Layout.colGap}px;
  align-content: center;
  align-items: baseline;
`;

export const post = css`
  display: grid;
  grid-template-columns: ${Layout.leftColWidth}px 1fr;
  grid-template-rows: max-content;
  grid-column-gap: ${Layout.colGap}px;
  align-content: start;
`;
