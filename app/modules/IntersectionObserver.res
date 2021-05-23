@new
external make: (
  array<Dom.intersectionObserverEntry> => unit,
  @as(json`{rootMargin: "50%"}`) _,
) => Dom.intersectionObserver = "IntersectionObserver"

@send external observe: (Dom.intersectionObserver, Dom.element) => unit = "observe"
@send external disconnect: Dom.intersectionObserver => unit = "disconnect"

module Entry = {
  @get external isIntersecting: Dom.intersectionObserverEntry => bool = "isIntersecting"
}
