import { css } from "linaria";

import { Screen, Transition } from "styles";

export const thumbOverlay = css`
  display: flex;
  position: absolute;
  top: 0;
  bottom: 0;
  right: 0;
  left: 0;
  background-color: transparent;
  transition: background-color ${Transition.fast} ${Transition.timingFunction};
`;

export const thumb = css`
  position: absolute;
  cursor: pointer;

  @media ${Screen.mouse} {
    &:focus .${thumbOverlay},
    &:hover .${thumbOverlay} {
      background-color: rgba(255, 255, 255, 0.1);
    }
  }
`;

export const loadingImage = css`
  filter: blur(5px);
  opacity: 0;
`;

export const loadedImage = css`
  filter: blur(0);
  opacity: 1;
`;
