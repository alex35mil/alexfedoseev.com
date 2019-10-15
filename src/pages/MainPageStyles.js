import { css } from "linaria";

import { Color, Font, Theme, Transition } from "styles";

import * as Logo from "components/Logo/LogoStyles.js";

const largeScreen = "(min-width: 801px)";
const smallScreen = "(max-width: 800px)";

const photoSize = 130;

export const container = css`
  display: grid;
  grid-template-rows: 1fr max-content 1fr;
  grid-template-columns: max-content;
  align-items: center;
  justify-content: center;
  padding: 24px 0;
`;

export const content = css`
  display: grid;
  align-content: center;
  align-items: center;
  justify-content: center;
  justify-items: center;
  padding-bottom: 20%;

  @media ${smallScreen} {
    grid-template-rows: max-content max-content;
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

export const push = css`
  display: flex;
`;

export const photo = css`
  display: flex;
  box-sizing: content-box;
  border: 4px solid ${Theme.avatarBorderColor};
  transition-property: border-color;
  transition-duration: ${Transition.moderate};
  transition-timing-function: ${Transition.timingFunction};
  border-radius: 50%;
  width: ${photoSize}px;
  height: ${photoSize}px;
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
    background-color: ${Theme.lineColor};
    transition-property: background-color;
    transition-duration: ${Transition.moderate};
    transition-timing-function: ${Transition.timingFunction};
  }
`;

export const headline = css`
  display: grid;
  grid-template-rows: max-content max-content;
  grid-row-gap: 14px;

  @media ${smallScreen} {
    justify-items: center;
  }
`;

const logoWidth = 140;
const logoHeight = Math.ceil(logoWidth * Logo.height / Logo.width);

export const logo = css`
  display: flex;
  align-items: center;
  user-select: none;
`;

export const logoSvg = css`
  width: ${logoWidth}px;
  height: ${logoHeight}px;
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
  grid-column-gap: 6px;
`;

export const link = css`
  display: flex;
  padding: 2px ${linkHPad}px;
  color: ${Theme.textColor};
  font-size: 0.9em;
  transition-property: background-color, color, transform;
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
    background-color: ${Theme.lineColor};
    transition-property: background-color;
    transition-duration: ${Transition.moderate};
    transition-timing-function: ${Transition.timingFunction};
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
  transition-property: background-color, color, transform;
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
    background-color: ${Theme.githubHoverColor};
  }
`;

export const instagramIcon = css`
  &:focus,
  &:hover {
    background-color: ${Color.instagram};
  }
`;

export const themeSwitch = css`
  align-self: end;
  justify-content: center;
`;
