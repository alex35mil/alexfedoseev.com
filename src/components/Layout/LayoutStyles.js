import { css } from "linaria";

import { Color, Font, Theme, Transition, Screen, Layout } from "styles";

import * as Logo from "components/Logo/LogoStyles.js";

const navMediumScreen = Screen.between(440, Screen.smallMaxWidth);

export const container = css`
  display: grid;
  position: relative;
  width: 100%;

  @media ${Screen.small} {
    grid-template-rows: ${Layout.smallScreenHeaderHeight}px 1fr max-content;
    grid-template-columns: 1fr;
    grid-row-gap: ${Layout.smallScreenRowGap}px;
    justify-self: center;
    justify-content: center;
    justify-items: space-between;
    padding: ${Layout.smallScreenRowGap}px 0;
  }

  @media ${Screen.large} {
    grid-template-rows: max-content 1fr max-content;
    grid-template-columns: 100vw;
    grid-row-gap: ${Layout.largeScreenRowGap}px;
    justify-self: center;
    justify-content: center;
    justify-items: center;
    padding: 30px 0 0;
  }
`;

export const header = css`
  display: grid;

  @media ${Screen.small} {
    grid-template-columns: ${logoLargeScreenWidth}px 1fr;
    grid-column-gap: 14px;
    justify-content: space-between;
    padding: 0 ${Layout.smallScreenHPad}px;
  }

  @media ${navMediumScreen} {
    grid-template-columns: ${logoLargeScreenWidth}px 1fr max-content;
    grid-column-gap: 14px;
    justify-content: space-between;
  }

  @media ${Screen.large} {
    grid-template-columns: ${logoLargeScreenWidth}px 1fr max-content;
    grid-column-gap: ${Layout.largeScreenColGap}px;
    width: ${Layout.largeScreenContentWidth}px;
  }
`;

const logoLargeScreenWidth = Layout.largeScreenLogoWidth;
const logoLargeScreenHeight = Logo.height;
const logoSmallScreenWidth = 110;
const logoSmallScreenHeight = Math.ceil((logoSmallScreenWidth * Logo.height) / Logo.width);

export const logo = css`
  display: flex;

  @media ${Screen.small} {
    flex-flow: row nowrap;
    align-items: center;
    justify-content: center;
  }

  @media ${Screen.large} {
    flex-flow: row nowrap;
    align-items: center;
    justify-content: flex-end;
  }
`;

export const logoLink = css`
  font-family: ${Font.heading};
  font-weight: ${Font.bold};
  line-height: 0;
  white-space: nowrap;
  user-select: none;
`;

export const logoSvg = css`
  @media ${Screen.small} {
    width: ${logoSmallScreenWidth}px;
    height: ${logoSmallScreenHeight}px;
  }

  @media ${Screen.large} {
    width: ${logoLargeScreenWidth}px;
    height: ${logoLargeScreenHeight}px;
  }
`;

export const navigation = css`
  display: grid;

  @media ${Screen.small} {
    grid-template-columns: max-content max-content max-content;
    grid-column-gap: 14px;
    align-items: center;
    justify-content: end;
  }

  @media ${navMediumScreen} {
    grid-template-columns: max-content max-content max-content;
    grid-column-gap: 14px;
    align-items: center;
    justify-content: start;
  }

  @media ${Screen.large} {
    grid-template-columns: max-content max-content max-content;
    grid-column-gap: 20px;
    align-items: center;
    justify-content: start;
  }
`;

const largeScreenNavLinkHPad = 7;
const smallScreenNavLinkHPad = 4;

const navLinkVPad = 3;
const navLinkActiveBorderWidth = 3;

export const navLink = css`
  display: inline-block;
  position: relative;
  top: ${navLinkActiveBorderWidth}px;
  color: ${Theme.fadedTextColor};
  transition-property: border-bottom, transform;
  transition-duration: ${Transition.fast};
  transition-timing-function: ${Transition.timingFunction};
  line-height: 1;
  user-select: none;

  @media ${Screen.mouse} {
    &:focus,
    &:hover {
      color: ${Theme.fadedTextColor};
      transform: rotate(-3deg) scale(1.1);
      border-bottom: ${navLinkActiveBorderWidth}px solid ${Color.blue};
    }
  }

  @media ${Screen.small} {
    padding: 4px 0;
  }

  @media ${Screen.large} {
    padding: ${navLinkVPad + navLinkActiveBorderWidth - navLinkVPad}px 0 ${navLinkVPad}px;
  }
`;

export const navLinkActive = css`
  font-size: 0.8em;
  border-bottom: ${navLinkActiveBorderWidth}px solid ${Color.blue};
`;

export const navLinkInactive = css`
  font-size: 0.8em;
  border-bottom: ${navLinkActiveBorderWidth}px solid transparent;
`;

export const themeSwitchHeader = css`
  @media ${Screen.small} {
    display: none;
  }

  @media ${navMediumScreen} {
    display: flex;
    position: relative;
    justify-content: flex-end;
  }

  @media ${Screen.large} {
    display: flex;
    position: relative;
    justify-content: flex-end;
  }
`;

export const themeSwitchFooter = css`
  @media ${Screen.small} {
    display: flex;
    position: relative;
    justify-content: center;
  }

  @media ${Screen.large} {
    display: none;
  }

  @media ${Screen.small} {
    order: 5;
  }
`;

export const footer = css`
  display: grid;

  @media ${Screen.small} {
    grid-template-rows: max-content max-content;
    grid-row-gap: 20px;
    align-content: end;
    padding: 0 ${Layout.smallScreenHPad}px;
  }

  @media ${Screen.large} {
    grid-template-columns: max-content max-content max-content max-content;
    grid-template-rows: max-content;
    grid-column-gap: ${Layout.largeScreenColGap}px;
    align-content: end;
    justify-content: space-between;
    margin: 20px 0 30px;
    width: ${Layout.largeScreenContentWidth}px;
    user-select: none;
  }
`;

export const footerSources = css`
  display: grid;

  @media ${Screen.small} {
    order: 4;
    justify-content: center;
  }

  @media ${Screen.large} {
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
  color: ${Theme.fadedTextColor};
  transition-property: color;
  transition-duration: ${Transition.moderate};
  transition-timing-function: ${Transition.timingFunction};
`;

export const footerNav = css`
  display: grid;

  @media ${Screen.small} {
    grid-auto-flow: column;
    grid-auto-columns: max-content;
    grid-column-gap: 12px;
    justify-content: center;
    align-items: center;
    order: 2;
  }

  @media ${Screen.large} {
    grid-auto-flow: column;
    grid-auto-columns: max-content;
    grid-column-gap: 16px;
    align-items: center;
  }
`;

export const footerCopy = css`
  display: grid;
  grid-template-columns: max-content max-content max-content;
  align-items: center;
  justify-content: center;

  @media ${Screen.small} {
    order: 1;
  }
`;

export const footerText = css`
  font-size: 0.6em;
  padding: 6px 0;
  color: ${Theme.fadedTextColor};
  transition-property: color;
  transition-duration: ${Transition.moderate};
  transition-timing-function: ${Transition.timingFunction};
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

  @media ${Screen.small} {
    order: 3;
  }
`;

export const footerIconLink = css`
  display: flex;
  padding: 6px;
  border-radius: 50%;
  transition-property: background-color, color, transform;
  transition-duration: ${Transition.fast};
  transition-timing-function: ${Transition.timingFunction};
  transform: scale(1);

  @media ${Screen.mouse} {
    &:focus,
    &:hover {
      transform: scale(1.3);

      & path {
        fill: #fff;
      }
    }
  }
`;

export const footerTwitterIcon = css`
  @media ${Screen.mouse} {
    &:focus,
    &:hover {
      background-color: ${Color.twitter};
    }
  }
`;

export const footerGithubIcon = css`
  @media ${Screen.mouse} {
    &:focus,
    &:hover {
      background-color: ${Theme.githubHoverColor};
    }
  }
`;

export const footerInstagramIcon = css`
  @media ${Screen.mouse} {
    &:focus,
    &:hover {
      background-color: ${Color.instagram};
    }
  }
`;

export const footerFacebookIcon = css`
  @media ${Screen.mouse} {
    &:focus,
    &:hover {
      background-color: ${Color.facebook};
    }
  }
`;

export const footerLinkedInIcon = css`
  @media ${Screen.mouse} {
    &:focus,
    &:hover {
      background-color: ${Color.linkedin};
    }
  }
`;

export const sidenote = css`
  display: flex;
  align-items: center;
  color: ${Theme.fadedTextColor};
  transition-property: color;
  transition-duration: ${Transition.moderate};
  transition-timing-function: ${Transition.timingFunction};
  line-height: 1;
  user-select: none;

  @media ${Screen.small} {
    font-size: 0.8em;
  }

  @media ${Screen.large} {
    font-size: 0.65em;
    justify-content: flex-end;
    text-align: right;
  }
`;

export const primarySidenote = css`
  color: ${Theme.fadedTextColor};
  transition-property: color;
  transition-duration: ${Transition.moderate};
  transition-timing-function: ${Transition.timingFunction};
`;

export const secondarySidenote = css`
  color: ${Theme.postSidenoteColor};
  transition-property: color;
  transition-duration: ${Transition.moderate};
  transition-timing-function: ${Transition.timingFunction};
`;
