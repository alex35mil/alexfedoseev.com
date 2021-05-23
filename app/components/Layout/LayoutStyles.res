include %css(
  let navMediumScreen = Screen.between(440, Screen.smallMaxWidth)

  let container = css`
    display: grid;
    position: relative;
    width: 100%;

    @media ${Screen.small} {
      grid-template-rows: ${LayoutParams.smallScreenHeaderHeight}px 1fr max-content;
      grid-template-columns: 1fr;
      grid-row-gap: ${LayoutParams.smallScreenRowGap}px;
      justify-self: center;
      justify-content: center;
      justify-items: space-between;
      padding: ${LayoutParams.smallScreenRowGap}px 0;
    }

    @media ${Screen.large} {
      grid-template-rows: max-content 1fr max-content;
      grid-template-columns: 100vw;
      grid-row-gap: ${LayoutParams.largeScreenRowGap}px;
      justify-self: center;
      justify-content: center;
      justify-items: center;
      padding: ${LayoutParams.largeScreenRowGap}px 0 0;
    }
  `

  let header = css`
    display: grid;

    @media ${Screen.small} {
      grid-template-columns: ${LayoutParams.largeScreenLogoWidth}px 1fr;
      grid-column-gap: 14px;
      justify-content: space-between;
      padding: 0 ${LayoutParams.smallScreenHPad}px;
    }

    @media ${navMediumScreen} {
      grid-template-columns: ${LayoutParams.largeScreenLogoWidth}px 1fr max-content;
      grid-column-gap: 14px;
      justify-content: space-between;
    }

    @media ${Screen.large} {
      grid-template-columns: ${LayoutParams.largeScreenLogoWidth}px 1fr max-content;
      grid-column-gap: ${LayoutParams.largeScreenColGap}px;
      width: ${LayoutParams.largeScreenContentWidth}px;
    }
  `

  let logo = css`
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
  `

  let logoLink = css`
    font-family: ${Font.heading};
    font-weight: ${Font.bold};
    line-height: 0;
    white-space: nowrap;
    user-select: none;
  `

  let logoSvg = css`
    @media ${Screen.small} {
      width: ${LayoutParams.smallScreenLogoWidth}px;
      height: ${LayoutParams.smallScreenLogoHeight}px;
    }

    @media ${Screen.large} {
      width: ${LayoutParams.largeScreenLogoWidth}px;
      height: ${LayoutParams.largeScreenLogoHeight}px;
    }
  `

  let navigation = css`
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
  `

  let largeScreenNavLinkHPad = 7
  let smallScreenNavLinkHPad = 4

  let navLinkVPad = 3
  let navLinkActiveBorderWidth = 3

  let navLink = css`
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
  `

  let navLinkActive = css`
    font-size: 0.8em;
    border-bottom: ${navLinkActiveBorderWidth}px solid ${Color.blue};
  `

  let navLinkInactive = css`
    font-size: 0.8em;
    border-bottom: ${navLinkActiveBorderWidth}px solid transparent;
  `

  let themeSwitchHeader = css`
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
  `

  let themeSwitchFooter = css`
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
  `

  let footer = css`
    display: grid;

    @media ${Screen.small} {
      grid-template-rows: max-content max-content;
      grid-row-gap: 20px;
      align-content: end;
      padding: 0 ${smallScreenHPad}px;
    }

    @media ${Screen.large} {
      grid-template-columns: max-content max-content max-content max-content;
      grid-template-rows: max-content;
      grid-column-gap: ${LayoutParams.largeScreenColGap}px;
      align-content: end;
      justify-content: space-between;
      margin: 20px 0 30px;
      width: ${LayoutParams.largeScreenContentWidth}px;
      user-select: none;
    }
  `

  let footerSources = css`
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
  `

  let footerSourcesLink = css`
    display: grid;
    grid-template-columns: max-content max-content;
    grid-column-gap: 8px;
    align-items: center;
    justify-content: start;
    color: ${Theme.fadedTextColor};
    transition-property: color;
    transition-duration: ${Transition.moderate};
    transition-timing-function: ${Transition.timingFunction};
  `

  let footerNav = css`
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
  `

  let footerCopy = css`
    display: grid;
    grid-template-columns: max-content max-content max-content;
    align-items: center;
    justify-content: center;

    @media ${Screen.small} {
      order: 1;
    }
  `

  let footerText = css`
    font-size: 0.6em;
    padding: 6px 0;
    color: ${Theme.fadedTextColor};
    transition-property: color;
    transition-duration: ${Transition.moderate};
    transition-timing-function: ${Transition.timingFunction};
    line-height: 1;
  `

  let copySignature = css`
    display: inline-block;
    padding: 0 4px 0 10px;
    height: ${Sign.height}px;
  `

  let footerIcons = css`
    display: grid;
    grid-auto-flow: column;
    grid-auto-columns: max-content;
    grid-column-gap: 10px;
    align-items: center;
    justify-content: center;

    @media ${Screen.small} {
      order: 3;
    }
  `

  let footerIconLink = css`
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
  `

  let footerTwitterIcon = css`
    @media ${Screen.mouse} {
      &:focus,
      &:hover {
        background-color: ${Color.twitter};
      }
    }
  `

  let footerGithubIcon = css`
    @media ${Screen.mouse} {
      &:focus,
      &:hover {
        background-color: ${Theme.githubHoverColor};
      }
    }
  `

  let footerInstagramIcon = css`
    @media ${Screen.mouse} {
      &:focus,
      &:hover {
        background-color: ${Color.instagram};
      }
    }
  `

  let footerFacebookIcon = css`
    @media ${Screen.mouse} {
      &:focus,
      &:hover {
        background-color: ${Color.facebook};
      }
    }
  `

  let footerLinkedInIcon = css`
    @media ${Screen.mouse} {
      &:focus,
      &:hover {
        background-color: ${Color.linkedin};
      }
    }
  `

  let sidenote = css`
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
  `

  let primarySidenote = css`
    color: ${Theme.fadedTextColor};
    transition-property: color;
    transition-duration: ${Transition.moderate};
    transition-timing-function: ${Transition.timingFunction};
  `

  let secondarySidenote = css`
    color: ${Theme.postSidenoteColor};
    transition-property: color;
    transition-duration: ${Transition.moderate};
    transition-timing-function: ${Transition.timingFunction};
  `
)
