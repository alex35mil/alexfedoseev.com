open Web.Dom;

let onScroll = fn => {
  window->Window.addEventListener("scroll", fn, _);
  Some(() => window->Window.removeEventListener("scroll", fn, _));
};
