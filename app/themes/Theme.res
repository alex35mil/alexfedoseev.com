type theme =
  | Light
  | Dark

let default = Dark

module type Colors = {
  let key: string

  let bgColor: string
  let textColor: string
  let fadedTextColor: string
  let fadedIconColor: string
  let lineColor: string
  let logoColor: string
  let signColor: string
  let avatarBorderColor: string
  let githubHoverColor: string
  let postSidenoteColor: string
  let postExpandableContentBgColor: string
  let postFooterNavLinkHoverBgColor: string
  let badgeTextColor: string
  let badgeBgColor: string
  let spinnerColor: string

  let codeColor: string
  let codeBgColor: string
  let codeLabelBgColor: string
  let codeHighlightedLineBgColor: string
  let codeTokenKeywordColor: string
  let codeTokenConstantColor: string
}

let bgColor = "var(--bg-color)"
let textColor = "var(--text-color)"
let fadedTextColor = "var(--faded-text-color)"
let fadedIconColor = "var(--faded-icon-color)"
let lineColor = "var(--line-color)"
let logoColor = "var(--logo-color)"
let signColor = "var(--sign-color)"
let avatarBorderColor = "var(--avatar-border-color)"
let githubHoverColor = "var(--github-hover-color)"
let postSidenoteColor = "var(--post-sidenote-color)"
let postExpandableContentBgColor = "var(--post-expandable-content-bg-color)"
let postFooterNavLinkHoverBgColor = "var(--post-footer-nav-link-hover-bg-color)"
let badgeTextColor = "var(--badge-text-color)"
let badgeBgColor = "var(--badge-bg-color)"
let spinnerColor = "var(--spinner-color)"
let codeColor = "var(--code-color)"
let codeBgColor = "var(--code-bg-color)"
let codeLabelBgColor = "var(--code-label-bg-color)"
let codeHighlightedLineBgColor = "var(--code-highlighted-line-bg-color)"
let codeTokenKeywordColor = "var(--code-token-keyword-color)"
let codeTokenConstantColor = "var(--code-token-constant-color)"
