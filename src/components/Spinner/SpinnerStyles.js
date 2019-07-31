import { css } from "linaria";

import { Color } from "styles";

export const container = css`
  display: flex;
  position: relative;
  pointer-events: none;
`;

export const wrapper = css`
  display: flex;
  position: relative;
  pointer-events: none;
`;

export const spreadedContainer = css`
  display: flex;
  position: absolute;
  top: 0;
  bottom: 0;
  left: 0;
  right: 0;
  width: 100%;
  pointer-events: none;
`;

export const spreadedWrapper = css`
  display: flex;
  position: absolute;
  top: 50%;
  left: 50%;
  transform: translate(-50%, -50%);
  pointer-events: none;
`;

export const spinner = css`
  display: flex;
  position: relative;
  flex-flow: row nowrap;
  align-items: center;
  justify-content: space-between;
  transform: translate3d(0, 0, 0);
  backface-visibility: hidden;
`;

export const col = css`
  display: flex;
  transition: opacity 0.1s ease-in-out;
  margin: 0;
  overflow: hidden;
  @keyframes spin {
    0%  { transform: scale(1.0); opacity: 0.9; }
    20% { transform: scale(1.1); opacity: 1.0; }
    40% { transform: scale(0.9); opacity: 1.0; }
    80% { transform: scale(1.0); opacity: 0.9; }
  }
  animation-name: spin;
  animation-duration: 2000ms;
  animation-iteration-count: infinite;
  animation-timing-function: ease-in-out;
`;

export const leftCol =   css`animation-delay: 0;`;
export const middleCol = css`animation-delay: 150ms;`;
export const rightCol =  css`animation-delay: 450ms;`;

export const blue = css`
  background-color: ${Color.blue};
`;

export const whiteBg = css`
  background-color: ${Color.white};
`;

export const transparentBg = css`
  background-color: transparent;
`;
