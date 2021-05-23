include %css(
  let largeScreen = "(min-width: 801px)"
  let smallScreen = "(max-width: 800px)"

  let container = css`
    display: grid;
    grid-template-rows: 1fr max-content 1fr;
    grid-template-columns: max-content;
    align-items: center;
    justify-content: center;
    padding: 24px 0;
  `

  let content = css`
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
  `

  let push = css`
    display: flex;
  `

  let photoSize = 130
  let photoBorderSize = 4

  let photoContainer = css`
    display: flex;
    position: relative;
    box-sizing: content-box;
    border-width: ${photoBorderSize}px;
    border-radius: 50%;
    border-style: solid;
    border-color: ${Theme.avatarBorderColor};
    width: ${photoSize}px;
    height: ${photoSize}px;
    overflow: hidden;
  `

  let photo = css`
    border-width: 0;
    border-radius: 50%;
    width: ${photoSize}px;
    height: ${photoSize}px;
  `

  let line = css`
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
  `

  let headline = css`
    display: grid;
    grid-template-rows: max-content max-content;
    grid-row-gap: 14px;

    @media ${smallScreen} {
      justify-items: center;
    }
  `

  let logoWidth = 140.
  let logoHeight = Math.ceil(logoWidth *. LogoStyles.height /. LogoStyles.width)

  let logo = css`
    display: flex;
    align-items: center;
    user-select: none;
  `

  let logoSvg = css`
    width: ${logoWidth}px;
    height: ${logoHeight}px;
  `

  let linkHPad = 6

  let links = css`
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
  `

  let nav = css`
    display: grid;
    grid-auto-flow: column;
    grid-template-columns: max-content;
    grid-column-gap: 6px;
  `

  let link = css`
    display: flex;
    padding: 2px ${linkHPad}px;
    color: ${Theme.textColor};
    font-size: 0.9em;
    line-height: 1;
    transition-property: background-color, color, transform;
    transition-duration: ${Transition.fast};
    transition-timing-function: ${Transition.timingFunction};
    user-select: none;

    @media ${Screen.mouse} {
      &:focus,
      &:hover {
        color: #fff;
        background-color: ${Color.blue};
        transform: rotate(-3deg) scale(1.1);
      }
    }
  `

  let diagonal = css`
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
  `

  let social = css`
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
  `

  let icon = css`
    display: flex;
    padding: 6px;
    border-radius: 50%;
    transition-property: background-color, color, transform;
    transition-duration: ${Transition.fast};
    transition-timing-function: ${Transition.timingFunction};

    @media ${Screen.mouse} {
      &:focus,
      &:hover {
        background-color: ${Color.blue};
        transform: rotate(-7deg) scale(1.1);

        & path {
          fill: #fff;
        }
      }
    }
  `

  let twitterIcon = css`
    @media ${Screen.mouse} {
      &:focus,
      &:hover {
        background-color: ${Color.twitter};
      }
    }
  `

  let githubIcon = css`
    @media ${Screen.mouse} {
      &:focus,
      &:hover {
        background-color: ${Theme.githubHoverColor};
      }
    }
  `

  let instagramIcon = css`
    @media ${Screen.mouse} {
      &:focus,
      &:hover {
        background-color: ${Color.instagram};
      }
    }
  `

  let themeSwitch = css`
    align-self: end;
    justify-content: center;
  `
)
