import { css } from "linaria";

import { Theme, Transition } from "styles";

const trackWidth = 36;
const trackHeight = 18;
const controlSize = 20;
const controlIcon = 16;

const lightTrack = "#dadada";
const lightControl = "#fff";
const darkTrack = "#6f6f6f";
const darkControl = "#555";

export const container = css`
  display: flex;
  height: ${controlSize}px;
`;

export const label = css`
  display: flex;
  position: relative;
  align-items: center;
  margin: 0;
  width: ${trackWidth}px;
  cursor: pointer;
`;

export const track = css`
  display: flex;
  position: absolute;
  width: ${trackWidth}px;
  height: ${trackHeight}px;
  border-radius: 100px;
  background-color: ${lightTrack};
  transition: background-color ${Transition.moderate} ${Transition.timingFunction};
`;

export const control = css`
  display: flex;
  position: absolute;
  overflow: hidden;
  width: ${controlSize}px;
  height: ${controlSize}px;
  border-radius: 50%;
  background-color: ${lightControl};
  box-shadow: 0 0 1px 1px rgba(0, 0, 0, 0.1);
  transition-property: background-color, transform;
  transition-duration: ${Transition.moderate};
  transition-timing-function: ${Transition.timingFunction};
`;

export const icon = css`
  position: absolute;
  top: 50%;
  left: 50%;
  pointer-events: none;
  user-select: none;
  transition-property: transform, opacity;
  transition-duration: ${Transition.moderate};
  transition-timing-function: ${Transition.timingFunction};
`;

export const lightIcon = css`
  transform: translate(-50%, -50%);
  opacity: 1;
`;

export const darkIcon = css`
  transform: translate(-50%, -200%);
  opacity: 0;
`;

export const input = css`
  display: none;

  &:checked + .${label} {
    & .${track} {
      background-color: ${darkTrack};
    }

    & .${control} {
      transform: translateX(${trackWidth - controlSize}px);
      background-color: ${darkControl};
    }

    & .${lightIcon} {
      transform: translate(-50%, 200%);
      opacity: 0;
    }

    & .${darkIcon} {
      transform: translate(-50%, -50%);
      opacity: 1;
    }
  }
`;
