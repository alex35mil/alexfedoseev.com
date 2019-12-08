type js;

[@bs.val] external import: string => Promise.t(js) = "import";
[@bs.get] external default: js => React.component('props) = "default";

let fromJs = x =>
  x->Promise.map(m => {"make": m->default}->Obj.magic)->Promise.result;
