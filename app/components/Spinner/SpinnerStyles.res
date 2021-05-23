include %css(
  let container = css`
    display: flex;
    position: absolute;
    align-items: center;
    justify-content: center;
    width: 100%;
    height: 100%;
    pointer-events: none;
  `

  let size = 5
  let speedMultiplier = 1

  let dot = css`
    position: absolute;
    font-size: ${size / 3}px;
    width: ${size}px;
    height: ${size}px;
    background: ${Theme.spinnerColor};
    border-radius: 50%;
    animation-fill-mode: forwards;
  `

  let d1 = 1
  let d2 = 3
  let d3 = 5

  let dot1 = css`
    animation: propagate1 ${1.5 / speedMultiplier}s infinite;

    @keyframes propagate1 {
      25% {transform: translateX(-${d1}rem) scale(0.75)}
      50% {transform: translateX(-${d2}rem) scale(0.6)}
      75% {transform: translateX(-${d3}rem) scale(0.5)}
      95% {transform: translateX(0rem) scale(1)}
    }
  `

  let dot2 = css`
    animation: propagate2 ${1.5 / speedMultiplier}s infinite;

    @keyframes propagate2 {
      25% {transform: translateX(-${d1}rem) scale(0.75)}
      50% {transform: translateX(-${d2}rem) scale(0.6)}
      75% {transform: translateX(-${d2}rem) scale(0.6)}
      95% {transform: translateX(0rem) scale(1)}
    }
  `

  let dot3 = css`
    animation: propagate3 ${1.5 / speedMultiplier}s infinite;

    @keyframes propagate3 {
      25% {transform: translateX(-${d1}rem) scale(0.75)}
      75% {transform: translateX(-${d1}rem) scale(0.75)}
      95% {transform: translateX(0rem) scale(1)}
    }
  `

  let dot4 = css`
    animation: propagate4 ${1.5 / speedMultiplier}s infinite;

    @keyframes propagate4 {
      25% {transform: translateX(${d1}rem) scale(0.75)}
      75% {transform: translateX(${d1}rem) scale(0.75)}
      95% {transform: translateX(0rem) scale(1)}
    }
  `

  let dot5 = css`
    animation: propagate5 ${1.5 / speedMultiplier}s infinite;

    @keyframes propagate5 {
      25% {transform: translateX(${d1}rem) scale(0.75)}
      50% {transform: translateX(${d2}rem) scale(0.6)}
      75% {transform: translateX(${d2}rem) scale(0.6)}
      95% {transform: translateX(0rem) scale(1)}
    }
  `

  let dot6 = css`
    animation: propagate6 ${1.5 / speedMultiplier}s infinite;

    @keyframes propagate6 {
      25% {transform: translateX(${d1}rem) scale(0.75)}
      50% {transform: translateX(${d2}rem) scale(0.6)}
      75% {transform: translateX(${d3}rem) scale(0.5)}
      95% {transform: translateX(0rem) scale(1)}
    }
  `
)
