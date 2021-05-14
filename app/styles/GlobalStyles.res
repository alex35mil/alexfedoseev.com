include %css(
  let global = css`
    :global {
      @font-face {
        font-family: "Noto Sans";
        font-style: normal;
        font-weight: 700;
        src: local("Noto Sans Bold"), local("NotoSans-Bold"),
             url("~fonts/noto-sans-v8-latin-700.woff2") format("woff2"),
             url("~fonts/noto-sans-v8-latin-700.woff") format("woff");
      }

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
        display: grid;
        position: relative;
        grid-template-columns: 1fr;
        grid-template-rows: 1fr;
        margin: 0;
        padding: 0;
      }

      body {
        background-color: ${Theme.bgColor};
        transition-property: background-color;
        transition-duration: ${Transition.moderate};
        transition-timing-function: ${Transition.timingFunction};
        font-family: ${Font.mono};
        font-size: ${Font.size}px;
        font-weight: ${Font.normal};
        line-height: ${Font.lineHeight};
      }
    }
  `
)
