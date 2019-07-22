import { css } from "linaria";

import { Color, Font, Transition } from "styles";

const contentWidth = 700;
const rightColWidth = 150;
const rowGap = 28;
const colGap = 20;

export const container = css`
  display: grid;
  grid-template-rows: max-content max-content 1fr;
  grid-row-gap: ${rowGap}px;
  justify-self: center;
  width: ${contentWidth}px;
  padding: 40px 0;
`;

export const header = css`
  display: grid;
  grid-template-columns: ${rightColWidth}px 1fr;
  grid-column-gap: ${colGap}px;
`;

export const logo = css`
  font-family: ${Font.heading};
  font-size: 21px;
  font-weight: ${Font.bold};
  user-select: none;
`;

export const sectionHeader = css`
  display: inline-block;
  padding: 2px 8px;
  color: ${Color.white};
  background-color: ${Color.blue};
  user-select: none;

  &:focus,
  &:hover {
    transform: rotate(-3deg) scale(1.1);
  }
`;

export const years = css`
  display: grid;
  grid-auto-flow: row;
  grid-template-rows: max-content;
  grid-row-gap: ${rowGap}px;
`;

export const yearContainer = css`
  display: grid;
  grid-auto-flow: row;
  grid-template-rows: max-content;
  grid-row-gap: 3px;
`;

export const post = css`
  display: grid;
  grid-template-columns: ${rightColWidth}px 1fr;
  grid-template-rows: max-content;
  grid-column-gap: ${colGap}px;
  align-content: center;
  align-items: center;
`;

export const year = css`
  display: flex;
  align-items: center;
  justify-content: flex-end;
  font-size: .6em;
  color: #999;
  text-align: right;
  line-height: 1;
  user-select: none;
`;

export const link = css`
  font-size: 0.9em;
`;

export const copy = css`
  display: flex;
  align-items: center;
  justify-content: flex-start;
  font-size: .6em;
  color: #999;
  line-height: 1;
`;

export const footer = css`
  display: grid;
  grid-template-columns: ${rightColWidth}px 1fr;
  grid-template-rows: 1fr;
  grid-column-gap: ${colGap}px;
  align-items: start;
  user-select: none;
`;
