include %css(
  let container = css`
    display: grid;
    color: ${Theme.textColor};

    @media ${Screen.small} {
      grid-template-rows: max-content max-content;
      grid-row-gap: 12px;
      align-content: center;
      align-items: center;
      justify-content: center;
      justify-items: center;
    }

    @media ${Screen.large} {
      grid-template-columns: max-content max-content max-content;
      grid-template-rows: 1fr;
      grid-column-gap: 50px;
      align-content: center;
      align-items: center;
      justify-content: center;
    }
  `

  let fourOFour = css`
    font-size: 100px;
  `

  let texts = css`
    display: grid;
    grid-template-rows: max-content max-content;
    grid-row-gap: 8px;

    @media ${Screen.small} {
      text-align: center;
    }
  `

  let notFound = css`
    font-size: 1.3em;
  `

  let line = css`
    @media ${Screen.small} {
      display: none;
    }

    @media ${Screen.large} {
      display: flex;
      height: 120px;
      width: 1px;
      background-color: ${Theme.lineColor};
      transition-property: background-color;
      transition-duration: ${Transition.moderate};
      transition-timing-function: ${Transition.timingFunction};
    }
  `
)
