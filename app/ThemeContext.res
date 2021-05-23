open Theme

let toString = x =>
  switch x {
  | Light => "light"
  | Dark => "dark"
  }

let fromString = x =>
  switch x {
  | "light" => Light
  | "dark" => Dark
  | _ as x => failwith(j`Unknown theme: $(x)`)
  }

let getModule = (theme): module(Colors) =>
  switch theme {
  | Light => module(LightTheme)
  | Dark => module(DarkTheme)
  }

module Storage = {
  let key = "theme"

  let getTheme = () => Web.Storage.localStorage->Web.Storage.getItem(key)->Option.map(fromString)

  let setTheme = value => Web.Storage.localStorage->Web.Storage.setItem(key, value->toString)
}

module Dom = {
  let darkMq = "(prefers-color-scheme: dark)"
  let lightMq = "(prefers-color-scheme: light)"

  let getRoot = () => {
    open Web.Dom
    window->Window.document->Document.documentElement->Element.unsafeAsHtmlElement
  }

  let getVar = (root, key) => {
    open Web.Dom
    root->HtmlElement.style->CssStyleDeclaration.getPropertyValue(key, _)
  }

  let setVar = (root, key, value) => {
    open Web.Dom
    root->HtmlElement.style->CssStyleDeclaration.setProperty(key, value, "", _)
  }

  let setTheme = theme => {
    let module(Theme) = theme->getModule

    let root = getRoot()

    root->setVar("--theme", Theme.key)
    root->setVar("--bg-color", Theme.bgColor)
    root->setVar("--text-color", Theme.textColor)
    root->setVar("--faded-text-color", Theme.fadedTextColor)
    root->setVar("--faded-icon-color", Theme.fadedIconColor)
    root->setVar("--line-color", Theme.lineColor)
    root->setVar("--logo-color", Theme.logoColor)
    root->setVar("--sign-color", Theme.signColor)
    root->setVar("--avatar-border-color", Theme.avatarBorderColor)
    root->setVar("--github-hover-color", Theme.githubHoverColor)
    root->setVar("--post-sidenote-color", Theme.postSidenoteColor)
    root->setVar("--post-expandable-content-bg-color", Theme.postExpandableContentBgColor)
    root->setVar("--post-footer-nav-link-hover-bg-color", Theme.postFooterNavLinkHoverBgColor)
    root->setVar("--badge-text-color", Theme.badgeTextColor)
    root->setVar("--badge-bg-color", Theme.badgeBgColor)
    root->setVar("--spinner-color", Theme.spinnerColor)
    root->setVar("--code-color", Theme.codeColor)
    root->setVar("--code-bg-color", Theme.codeBgColor)
    root->setVar("--code-label-bg-color", Theme.codeLabelBgColor)
    root->setVar("--code-token-keyword-color", Theme.codeTokenKeywordColor)
    root->setVar("--code-token-constant-color", Theme.codeTokenConstantColor)
  }

  let currentTheme = () => {
    let root = getRoot()

    switch root->getVar("--theme") {
    | "" => None
    | _ as x => Some(x->fromString)
    }
  }
}

let getInitial = () =>
  switch Storage.getTheme() {
  | Some(theme) => theme
  | None => default
  }

type ctx = {
  current: theme,
  colors: module(Colors),
  set: theme => unit,
}

include ReactContext.Make({
  type context = ctx
  let defaultValue = {
    current: default,
    colors: default->getModule,
    set: ignore,
  }
})

type state = theme

type action = Set(theme)

let reducer = (_state, action) =>
  switch action {
  | Set(theme) => theme
  }

@react.component
let make = (~children) => {
  let mounted = React.useRef(false)

  let (theme, dispatch) = reducer->React.useReducer(default)

  React.useEffect1(() => {
    if !mounted.current {
      let initial = getInitial()
      if initial != theme {
        Set(initial)->dispatch
      }
      mounted.current = true
    } else {
      theme->Dom.setTheme
      theme->Storage.setTheme
    }
    None
  }, [theme])

  React.useEffect1(() =>
    Subscription.onKeyDown(event => {
      open Web.Dom
      switch event->KeyboardEvent.code {
      | "KeyT" if event->KeyboardEvent.altKey =>
        switch theme {
        | Light => Set(Dark)->dispatch
        | Dark => Set(Light)->dispatch
        }
      | _ => ()
      }
    })
  , [theme])

  let value = React.useMemo1(() => {
    current: theme,
    colors: theme->getModule,
    set: theme => Set(theme)->dispatch,
  }, [theme])

  <Provider value> children </Provider>
}
