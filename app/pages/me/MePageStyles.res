include %css(
  let container = css`
    display: grid;
    grid-auto-flow: row;
    grid-template-rows: max-content;
    color: ${Theme.textColor};
    transition-property: color;
    transition-duration: ${Transition.moderate};
    transition-timing-function: ${Transition.timingFunction};

    @media ${Screen.small} {
      grid-row-gap: 70px;
      padding: 0 ${LayoutParams.smallScreenHPad}px;
    }

    @media ${Screen.large} {
      grid-template-columns: ${LayoutParams.largeScreenContentWidth}px;
      grid-row-gap: 40px;
    }
  `

  let smallScreenPhotoSize = 130
  let largeScreenPhotoSize = 100

  let about = css`
    display: grid;

    @media ${Screen.small} {
      grid-template-rows: 0 max-content;
      grid-row-gap: 0;
      justify-content: center;
      justify-items: center;
      text-align: center;
    }

    @media ${Screen.large} {
      grid-template-columns: ${LayoutParams.logoWidth}px ${LayoutParams.largeScreenRightColWidth}px;
      grid-template-rows: max-content;
      grid-column-gap: ${LayoutParams.largeScreenColGap}px;
      align-content: start;
      align-items: start;
    }
  `

  let photo = css`
    display: flex;
    box-sizing: content-box;
    border: 4px solid ${Theme.avatarBorderColor};
    transition-property: border-color;
    transition-duration: ${Transition.moderate};
    transition-timing-function: ${Transition.timingFunction};
    border-radius: 50%;
    background-color: #efefef;
    background-repeat: no-repeat;
    background-position: 50% 50%;
    background-size: contain;

    @media ${Screen.small} {
      justify-self: center;
      width: ${smallScreenPhotoSize}px;
      height: ${smallScreenPhotoSize}px;
    }

    @media ${Screen.large} {
      justify-self: center;
      width: ${largeScreenPhotoSize}px;
      height: ${largeScreenPhotoSize}px;
      transform: translateY(-10px);
    }
  `

  let aboutContent = css`
    display: grid;
    grid-auto-flow: row;
    grid-template-rows: max-content;
    grid-row-gap: 14px;
  `

  let title = css`
    font-family: ${Font.heading};
    font-size: 34px;
    font-weight: ${Font.bold};
    color: ${Theme.textColor};
    transition-property: color;
    transition-duration: ${Transition.moderate};
    transition-timing-function: ${Transition.timingFunction};
  `

  let row = css`
    display: grid;

    @media ${Screen.small} {
      justify-content: center;
      justify-items: center;
      text-align: center;
    }

    @media ${Screen.large} {
      grid-template-columns: ${LayoutParams.logoWidth}px ${LayoutParams.largeScreenRightColWidth}px;
      grid-template-rows: max-content;
      grid-column-gap: ${LayoutParams.largeScreenColGap}px;
      align-content: start;
      align-items: baseline;
    }
  `

  let rowLabel = css`
    @media ${Screen.small} {
      margin-bottom: 12px;
      font-size: 1.1em;
      text-transform: uppercase;
    }
  `

  let content = css`
    display: grid;
    grid-auto-flow: row;
    grid-template-rows: max-content;

    @media ${Screen.small} {
      grid-row-gap: ${LayoutParams.smallScreenRowGap}px;
      padding: 0 ${LayoutParams.smallScreenHPad}px;
    }

    @media ${Screen.large} {
      grid-template-columns: ${LayoutParams.largeScreenRightColWidth}px;
      grid-row-gap: ${LayoutParams.largeScreenRowGap}px;
    }
  `

  let contentBlock = css`
    display: grid;
    grid-template-rows: max-content max-content;
  `

  let contentSubheading = css`
    margin-bottom: 3px;
    font-size: 0.95em;
    font-weight: ${Font.bold};
  `

  let ul = css`
    list-style-type: none;

    @media ${Screen.large} {
      margin-left: 1.7em;

      & li::before {
        content: "—";
        display: block;
        position: relative;
        max-width: 0px;
        max-height: 0px;
        left: -1.7em;
        color: ${Theme.fadedTextColor};
        transition-property: color;
        transition-duration: ${Transition.moderate};
        transition-timing-function: ${Transition.timingFunction};
      }
    }
  `

  let stackItem = css`
    transition-property: color;
    transition-duration: ${Transition.moderate};
    transition-timing-function: ${Transition.timingFunction};
    font-weight: ${Font.bold};
    color: ${Theme.textColor};
  `

  let ossProjects = css`
    display: grid;
    grid-auto-flow: row;
    grid-template-rows: max-content;

    @media ${Screen.small} {
      grid-row-gap: 14px;
    }

    @media ${Screen.large} {
      grid-row-gap: 6px;
    }
  `

  let ossProject = css`
    display: grid;

    @media ${Screen.small} {
      grid-template-rows: max-content max-content;
    }

    @media ${Screen.large} {
      grid-template-columns: max-content max-content max-content;
    }
  `

  let ossProjectColon = css`
    @media ${Screen.small} {
      display: none;
    }

    @media ${Screen.large} {
      display: inline-block;
      margin-right: 0.5em;
    }
  `

  let ossProjectDescription = css`
    @media ${Screen.small} {
      text-align: center;
    }
  `

  let links = css`
    display: grid;
    grid-auto-flow: row;
    grid-template-rows: max-content;

    @media ${Screen.small} {
      grid-row-gap: 20px;
      margin: 14px 0 50px;
    }

    @media ${Screen.large} {
      grid-row-gap: 10px;
    }
  `

  let linkRow = css`
    display: grid;
    grid-template-columns: max-content;

    @media ${Screen.small} {
      justify-content: center;
    }
  `

  let link = css`
    display: grid;

    & path {
      transition: fill ${Transition.fast} ${Transition.timingFunction};
    }

    @media ${Screen.small} {
      grid-template-rows: max-content max-content;
      grid-row-gap: 6px;
      align-items: center;
      justify-items: center;
    }

    @media ${Screen.large} {
      grid-template-columns: max-content max-content;
      grid-column-gap: 10px;
    }
  `

  let linkIcon = css`
    @media ${Screen.small} {
      width: 20px;
      height: 20px;
    }

    @media ${Screen.large} {
      align-self: center;
    }
  `

  let githubLink = css`
    @media ${Screen.mouse} {
      &:hover path {
        fill: ${Theme.githubHoverColor} !important;
      }
    }
  `

  let twitterLink = css`
    @media ${Screen.mouse} {
      &:hover path {
        fill: ${Color.twitter} !important;
      }
    }
  `

  let instagramLink = css`
    @media ${Screen.mouse} {
      &:hover path {
        fill: ${Color.instagram} !important;
      }
    }
  `

  let facebookLink = css`
    @media ${Screen.mouse} {
      &:hover path {
        fill: ${Color.facebook} !important;
      }
    }
  `

  let linkedinLink = css`
    @media ${Screen.mouse} {
      &:hover path {
        fill: ${Color.linkedin} !important;
      }
    }
  `
)
