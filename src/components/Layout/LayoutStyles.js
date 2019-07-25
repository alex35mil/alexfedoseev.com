import { css } from "linaria";

import { Color, Font, Transition, Layout } from "styles";

export const container = css`
  display: grid;
  width: 100%;

  @media ${Layout.smallScreen} {
    grid-template-columns: minmax(auto, 700px);
    grid-template-rows: max-content max-content 1fr;
    grid-row-gap: ${Layout.smallScreenRowGap}px;
    justify-self: center;
    justify-content: center;
    padding: 30px 0;
  }

  @media ${Layout.largeScreen} {
    grid-template-rows: max-content max-content 1fr;
    grid-template-columns: 100vw;
    grid-row-gap: ${Layout.largeScreenRowGap}px;
    justify-self: center;
    justify-content: center;
    justify-items: center;
    padding: 40px 0 30px;
  }
`;

export const header = css`
  display: grid;

  @media ${Layout.smallScreen} {
    grid-template-columns: max-content max-content;
    grid-column-gap: 14px;
    justify-content: center;
    padding: 0 ${Layout.smallScreenHPad}px;
  }

  @media ${Layout.largeScreen} {
    grid-template-columns: ${Layout.largeScreenLeftColWidth}px ${Layout.largeScreenRightColWidth}px;
    grid-column-gap: ${Layout.largeScreenColGap}px;
  }
`;

export const logo = css`
  display: flex;

  @media ${Layout.smallScreen} {
    flex-flow: row nowrap;
    align-items: center;
    justify-content: center;
  }

  @media ${Layout.largeScreen} {
    flex-flow: row nowrap;
    align-items: center;
    justify-content: flex-end;
  }
`;

export const logoLink = css`
  font-family: ${Font.heading};
  font-weight: ${Font.bold};
  white-space: nowrap;
  user-select: none;

  @media ${Layout.smallScreen} {
    font-size: 18px;
  }

  @media ${Layout.largeScreen} {
    font-size: 21px;
  }
`;

export const navigation = css`
  display: grid;

  @media ${Layout.smallScreen} {
    grid-template-columns: max-content max-content max-content;
    grid-column-gap: 14px;
    align-items: center;
    justify-content: center;
  }

  @media ${Layout.largeScreen} {
    grid-template-columns: max-content max-content 1fr;
    grid-column-gap: 28px;
    align-items: center;
  }
`;

const largeScreenNavLinkHPad = 8;
const smallScreenNavLinkHPad = 4;

export const navLink = css`
  display: inline-block;
  transition-property: background-color color font-size transform;
  transition-duration: ${Transition.fast};
  transition-timing-function: ${Transition.timingFunction};
  line-height: 1;
  user-select: none;

  &:focus,
  &:hover {
    color: ${Color.white};
    background-color: ${Color.blue};
    transform: rotate(-3deg) scale(1.1);
  }

  @media ${Layout.smallScreen} {
    padding: 4px ${smallScreenNavLinkHPad}px;
  }

  @media ${Layout.largeScreen} {
    padding: 6px ${largeScreenNavLinkHPad}px;
  }
`;

export const navLinkActive = css`
  color: ${Color.white};
  background-color: ${Color.blue};

  @media ${Layout.smallScreen} {
    font-size: 0.8em;
  }

  @media ${Layout.largeScreen} {
    font-size: 1em;
  }
`;

export const navLinkInactive = css`
  font-size: 0.8em;
  color: ${Color.grayText};
  background-color: transparent;
`;

export const navSep = css`
  display: flex;
  height: 30px;
  width: 1px;
  background-color: ${Color.grayLine};
`;

export const restNavLinks = css`
  display: grid;
  grid-auto-flow: column;
  grid-auto-columns: max-content;
  grid-column-gap: 10px;
  align-items: center;

  @media ${Layout.smallScreen} {
    margin-left: -${smallScreenNavLinkHPad}px;
  }

  @media ${Layout.largeScreen} {
    margin-left: -${largeScreenNavLinkHPad}px;
  }
`;

export const footer = css`
  display: grid;

  @media ${Layout.smallScreen} {
    grid-template-rows: max-content max-content;
    grid-row-gap: 20px;
    align-content: end;
    padding: 0 ${Layout.smallScreenHPad}px;
  }

  @media ${Layout.largeScreen} {
    grid-template-columns: ${Layout.largeScreenLeftColWidth}px ${Layout.largeScreenRightColWidth}px;
    grid-template-rows: max-content;
    grid-column-gap: ${Layout.largeScreenColGap}px;
    align-content: end;
    justify-content: space-between;
    margin: 15px 0 0;
    user-select: none;
  }
`;

export const footerSources = css`
  display: grid;

  @media ${Layout.smallScreen} {
    order: 2;
    justify-content: center;
  }

  @media ${Layout.largeScreen} {
    grid-template-columns: max-content;
    align-items: center;
    justify-content: start;
  }
`;

export const footerSourcesLink = css`
  display: grid;
  grid-template-columns: max-content max-content;
  grid-column-gap: 8px;
  align-items: center;
  justify-content: start;
  color: ${Color.grayText};
`;

export const footerMainCol = css`
  display: grid;

  @media ${Layout.smallScreen} {
    order: 1;
    grid-template-rows: max-content max-content max-content;
    grid-row-gap: 20px;
  }

  @media ${Layout.largeScreen} {
    grid-template-columns: max-content max-content max-content;
    grid-column-gap: 8px;
    align-items: center;
    justify-content: space-between;
  }
`;

export const footerNav = css`
  display: grid;

  @media ${Layout.smallScreen} {
    grid-auto-flow: column;
    grid-auto-columns: max-content;
    grid-column-gap: 12px;
    justify-content: center;
    align-items: center;
  }

  @media ${Layout.largeScreen} {
    grid-auto-flow: column;
    grid-auto-columns: max-content;
    grid-column-gap: 12px;
    align-items: center;
  }
`;

export const footerCopy = css`
  display: grid;
  grid-template-columns: max-content max-content max-content;
  align-items: center;
  justify-content: center;
`;

export const footerText = css`
  font-size: .6em;
  padding: 6px 0;
  color: ${Color.grayText};
  line-height: 1;
`;

export const copySignature = css`
  display: inline-block;
  padding: 0 4px 0 10px;
  height: 26px;
`;

export const footerIcons = css`
  display: grid;
  grid-auto-flow: column;
  grid-auto-columns: max-content;
  grid-column-gap: 10px;
  align-items: center;
  justify-content: center;
`;

export const footerIconLink = css`
  display: flex;
  padding: 6px;
  border-radius: 50%;
  transition-property: background-color color transform;
  transition-duration: ${Transition.fast};
  transition-timing-function: ${Transition.timingFunction};
  transform: scale(1);

  &:focus,
  &:hover {
    transform: scale(1.3);

    & path {
      fill: #fff;
    }
  }
`;

export const footerTwitterIcon = css`
  &:focus,
  &:hover {
    background-color: ${Color.twitter};
  }
`;

export const footerGithubIcon = css`
  &:focus,
  &:hover {
    background-color: ${Color.github};
  }
`;

export const footerInstagramIcon = css`
  &:focus,
  &:hover {
    background-color: ${Color.instagram};
  }
`;

export const footerFacebookIcon = css`
  &:focus,
  &:hover {
    background-color: ${Color.facebook};
  }
`;

export const footerLinkedInIcon = css`
  &:focus,
  &:hover {
    background-color: ${Color.linkedin};
  }
`;

export const sidenote = css`
  display: flex;
  align-items: center;
  color: ${Color.grayText};
  line-height: 1;
  user-select: none;

  @media ${Layout.smallScreen} {
    font-size: 0.8em;
  }

  @media ${Layout.largeScreen} {
    font-size: .65em;
    justify-content: flex-end;
    text-align: right;
  }
`;

export const primarySidenote = css`
  color: ${Color.grayText};
`;

export const secondarySidenote = css`
  color: ${Color.grayNote};
`;
