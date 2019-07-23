import { css } from "linaria";

import { Color, Font, Transition } from "styles";

import * as Layout from "../components/Layout/LayoutStyles";

export const years = css`
  display: grid;
  grid-auto-flow: row;
  grid-template-rows: max-content;
  grid-row-gap: ${Layout.rowGap}px;
`;

export const yearContainer = css`
  display: grid;
  grid-auto-flow: row;
  grid-template-rows: max-content;
  grid-row-gap: 3px;
`;

export const post = css`
  display: grid;
  grid-template-columns: ${Layout.leftColWidth}px 1fr;
  grid-template-rows: max-content;
  grid-column-gap: ${Layout.colGap}px;
  align-content: center;
  align-items: center;
`;

export const link = css`
  font-size: 0.9em;
`;
