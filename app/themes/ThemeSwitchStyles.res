include %css(
  let trackWidth = 36
  let trackHeight = 18
  let controlSize = 20
  let controlIcon = 16

  let lightTrack = "#dadada"
  let lightControl = "#fff"
  let darkTrack = "#6f6f6f"
  let darkControl = "#555"

  let container = css`
    display: flex;
    height: ${controlSize}px;
  `

  let label = css`
    display: flex;
    position: relative;
    align-items: center;
    margin: 0;
    width: ${trackWidth}px;
    cursor: pointer;
  `

  let track = css`
    display: flex;
    position: absolute;
    width: ${trackWidth}px;
    height: ${trackHeight}px;
    border-radius: 100px;
    background-color: ${lightTrack};
    transition: background-color ${Transition.moderate} ${Transition.timingFunction};
  `

  let control = css`
    display: flex;
    position: absolute;
    overflow: hidden;
    width: ${controlSize}px;
    height: ${controlSize}px;
    border-radius: 50%;
    background-color: ${lightControl};
    box-shadow: 0 0 1px 1px rgba(0, 0, 0, 0.1);
    transition-property: background-color, transform;
    transition-duration: ${Transition.moderate};
    transition-timing-function: ${Transition.timingFunction};
  `

  let icon = css`
    position: absolute;
    top: 50%;
    left: 50%;
    pointer-events: none;
    user-select: none;
    transition-property: transform, opacity;
    transition-duration: ${Transition.moderate};
    transition-timing-function: ${Transition.timingFunction};
  `

  let lightIcon = css`
    transform: translate(-50%, -50%);
    opacity: 1;
  `

  let darkIcon = css`
    transform: translate(-50%, -200%);
    opacity: 0;
  `

  let input = css`
    display: none;

    &:checked + .${label} {
      & .${track} {
        background-color: ${darkTrack};
      }

      & .${control} {
        transform: translateX(${trackWidth - controlSize}px);
        background-color: ${darkControl};
      }

      & .${lightIcon} {
        transform: translate(-50%, 200%);
        opacity: 0;
      }

      & .${darkIcon} {
        transform: translate(-50%, -50%);
        opacity: 1;
      }
    }
  `
)
