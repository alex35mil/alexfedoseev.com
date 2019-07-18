import { css } from "linaria";

import { Color, Font, Layout, ZIndex } from "styles";

export const global = css`
  :global {
    * {
      box-sizing: border-box;
      transform-origin: 50% 50% 0;
      margin: 0;
      padding: 0;
      outline-width: 0;
      outline-style: none;
      outline-offset: 0;
      -moz-osx-font-smoothing: grayscale;
      -webkit-font-smoothing: antialiased;
      text-rendering: optimizeLegibility;
      -webkit-tap-highlight-color: transparent;
    }

    *:focus:not(:focus-visible) {
      outline: none;
    }

    html {
      min-height: 100%;
    }

    html,
    body,
    #root {
      display: flex;
      flex-flow: column nowrap;
      position: relative;
      margin: 0;
      padding: 0;
    }

    body {
      background-color: ${Layout.bgColor};
      font-family: ${Font.mono};
      font-size: ${Font.size}px;
      font-weight: ${Font.normal};
      line-height: ${Font.lineHeight};
    }

    #nprogress {
      pointer-events: none;
    }

    #nprogress .bar {
      position: fixed;
      top: 0;
      left: 0;
      z-index: ${ZIndex.progressBar};
      width: 100%;
      height: 2px;
      background-color: ${Color.blue};
    }
  }
`;
