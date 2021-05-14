open Web.Dom

let openWindow = (~url: string, ~name: string, ~width: int, ~height: int) => {
  let dualScreenLeft = window->Window.screenX
  let dualScreenTop = window->Window.screenY
  let innerWidth = window->Window.innerWidth
  let innerHeight = window->Window.innerHeight
  let left = innerWidth / 2 - width / 2 + dualScreenLeft
  let top = innerHeight / 2 - height / 2 + dualScreenTop
  let window =
    window->Window.open_(
      ~url,
      ~name,
      ~features=j`width=$width,height=$height,top=$top,left=$left`,
      _,
    )
  switch window {
  | Some(window) => window->Window.focus
  | None => ()
  }
}
