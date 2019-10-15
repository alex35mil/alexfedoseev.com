open Web.Dom;

let onScroll = fn => {
  window->Window.addEventListener("scroll", fn, _);
  Some(() => window->Window.removeEventListener("scroll", fn, _));
};

let onKeyDown = fn => {
  window->Window.addKeyDownEventListener(fn, _);
  Some(() => window->Window.removeKeyDownEventListener(fn, _));
};
