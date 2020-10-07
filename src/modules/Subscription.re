open Web.Dom;

let onResize = fn => {
  window->Window.addEventListener("resize", fn, _);
  Some(() => window->Window.removeEventListener("resize", fn, _));
};

let onScroll = fn => {
  window->Window.addEventListener("scroll", fn, _);
  Some(() => window->Window.removeEventListener("scroll", fn, _));
};

let onKeyDown = fn => {
  window->Window.addKeyDownEventListener(fn, _);
  Some(() => window->Window.removeKeyDownEventListener(fn, _));
};
