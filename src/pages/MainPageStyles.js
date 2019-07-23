import { css } from "linaria";

import { Color, Font, Transition } from "styles";

const largeScreen = "(min-width: 801px)";
const smallScreen = "(max-width: 800px)";

const photoSize = 100;

export const container = css`
  display: grid;
  align-content: center;
  align-items: center;
  justify-content: center;
  justify-items: center;
  padding-bottom: 7%;

  @media ${smallScreen} {
    grid-template-rows: max-content max-content max-content;
    grid-template-columns: max-content;
    grid-column-gap: 0;
    grid-row-gap: 20px;
  }

  @media ${largeScreen} {
    grid-template-rows: max-content;
    grid-template-columns: max-content max-content max-content;
    grid-column-gap: 30px;
  }
`;

export const photo = css`
  display: flex;
  width: ${photoSize}px;
  height: ${photoSize}px;
  border-radius: 50%;
  background-color: #efefef;
  background-image: url("~meta/me.png");
  background-repeat: no-repeat;
  background-position: 50% 50%;
  background-size: contain;
`;

export const line = css`
  @media ${smallScreen} {
    display: none;
  }

  @media ${largeScreen} {
    display: flex;
    height: 120px;
    width: 1px;
    background-color: ${Color.grayLine};
  }
`;

export const headline = css`
  display: grid;
  grid-template-rows: max-content max-content;
  grid-row-gap: 20px;

  @media ${smallScreen} {
    justify-items: center;
  }
`;

export const name = css`
  font-family: ${Font.heading};
  font-size: 21px;
  font-weight: ${Font.bold};
  user-select: none;
`;

const linkHPad = 8;

export const links = css`
  display: grid;

  @media ${smallScreen} {
    grid-template-rows: max-content max-content;
    grid-row-gap: 20px;
  }

  @media ${largeScreen} {
    grid-template-columns: max-content max-content max-content;
    grid-column-gap: 10px;
    align-items: center;
    margin: 0 -${linkHPad}px;
  }
`;

export const nav = css`
  display: grid;
  grid-auto-flow: column;
  grid-template-columns: max-content;
  grid-column-gap: 4px;
`;

export const link = css`
  display: flex;
  padding: 2px ${linkHPad}px;
  color: ${Font.color};
  font-size: 0.9em;
  transition-property: background-color color transform;
  transition-duration: ${Transition.fast};
  transition-timing-function: ${Transition.timingFunction};
  user-select: none;

  &:focus,
  &:hover {
    color: #fff;
    background-color: ${Color.blue};
    transform: rotate(-3deg) scale(1.1);
  }
`;

export const diagonal = css`
  @media ${smallScreen} {
    display: none;
  }

  @media ${largeScreen} {
    display: flex;
    height: 30px;
    width: 1px;
    background-color: ${Color.grayLine};
    transform: rotate(15deg);
  }
`;

export const social = css`
  display: grid;

  @media ${smallScreen} {
    grid-auto-flow: column;
    grid-auto-columns: max-content;
    grid-column-gap: 12px;
    justify-content: center;
  }

  @media ${largeScreen} {
    grid-auto-flow: column;
    grid-auto-columns: max-content;
    grid-column-gap: 8px;
    margin-left: ${linkHPad}px;
  }
`;

export const icon = css`
  display: flex;
  padding: 6px;
  border-radius: 50%;
  transition-property: background-color color transform;
  transition-duration: ${Transition.fast};
  transition-timing-function: ${Transition.timingFunction};

  &:focus,
  &:hover {
    background-color: ${Color.blue};
    transform: rotate(-7deg) scale(1.1);

    & path {
      fill: #fff;
    }
  }
`;

export const twitterIcon = css`
  &:focus,
  &:hover {
    background-color: ${Color.twitter};
  }
`;

export const githubIcon = css`
  &:focus,
  &:hover {
    background-color: ${Color.github};
  }
`;

export const instagramIcon = css`
  &:focus,
  &:hover {
    background-color: ${Color.instagram};
  }
`;
