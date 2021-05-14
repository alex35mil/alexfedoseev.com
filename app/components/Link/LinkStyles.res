include %css(
  let link = css`
    cursor: pointer;
  `

  let text = css`
    margin: -1px;
    padding: 1px;
    border-radius: 1px;
    color: ${Theme.textColor};
    background-color: transparent;
    transition-property: color;
    transition-duration: ${Transition.moderate};
    transition-timing-function: ${Transition.timingFunction};

    @media ${Screen.mouse} {
      &:focus {
        background-color: rgba(0, 0, 0, 0.05);
      }
    }
  `

  let box = css`
    line-height: 0;
  `

  let underlineAlways = css`
    text-decoration: underline;
    text-decoration-skip-ink: auto;
    text-decoration-style: solid;
    -webkit-text-decoration-skip: objects;
  `

  let underlineWhenInteracted = css`
    text-decoration: none;

    @media ${Screen.mouse} {
      &:focus,
      &:hover {
        text-decoration: underline;
        text-decoration-skip-ink: auto;
        text-decoration-style: solid;
        -webkit-text-decoration-skip: objects;
      }
    }
  `

  let underlineNever = css`
    text-decoration: none;

    @media ${Screen.mouse} {
      &:focus,
      &:hover {
        text-decoration: none;
      }
    }
  `
)
