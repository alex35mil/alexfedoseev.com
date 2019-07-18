let onNextTick = fn => fn->Js.Global.setTimeout(1)->ignore;

let onNextTickCancelable = fn => {
  let timerId = fn->Js.Global.setTimeout(1);
  () => timerId->Js.Global.clearTimeout;
};
