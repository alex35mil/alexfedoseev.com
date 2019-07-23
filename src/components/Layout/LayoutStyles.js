import { css } from "linaria";

import { Color, Font, Transition } from "styles";

export const contentWidth = 840;
export const leftColWidth = 150;
export const rowGap = 28;
export const colGap = 20;

export const container = css`
  display: grid;
  grid-template-rows: max-content max-content 1fr;
  grid-row-gap: ${rowGap}px;
  justify-self: center;
  width: ${contentWidth}px;
  padding: 40px 0 30px;
`;

export const header = css`
  display: grid;
  grid-template-columns: ${leftColWidth}px 1fr;
  grid-column-gap: ${colGap}px;
`;

export const logo = css`
  display: flex;
  flex-flow: row nowrap;
  align-items: center;
  justify-content: flex-end;
`;

export const logoLink = css`
  font-family: ${Font.heading};
  font-size: 21px;
  font-weight: ${Font.bold};
  white-space: nowrap;
  user-select: none;
`;

export const navigation = css`
  display: grid;
  grid-template-columns: max-content max-content 1fr;
  grid-column-gap: 28px;
  align-items: center;
`;

const navLinkHPad = 8;

export const navLink = css`
  display: inline-block;
  padding: 6px ${navLinkHPad}px;
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
`;

export const navLinkActive = css`
  font-size: 1em;
  color: ${Color.white};
  background-color: ${Color.blue};
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
  margin-left: -${navLinkHPad}px;
`;

export const footer = css`
  display: grid;
  grid-template-columns: ${leftColWidth}px 1fr;
  grid-template-rows: max-content;
  grid-column-gap: ${colGap}px;
  align-content: end;
  justify-content: space-between;
  margin: 15px 0;
  user-select: none;
`;

export const footerSources = css`
  display: grid;
  grid-template-columns: max-content;
  align-items: center;
  justify-content: start;
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
  grid-template-columns: max-content max-content max-content;
  grid-column-gap: 8px;
  align-items: center;
  justify-content: space-between;
`;

export const footerNav = css`
  display: grid;
  grid-auto-flow: column;
  grid-auto-columns: max-content;
  grid-column-gap: 12px;
  align-items: center;
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
  justify-content: flex-end;
  font-size: .65em;
  color: ${Color.grayText};
  text-align: right;
  line-height: 1;
  user-select: none;
`;
