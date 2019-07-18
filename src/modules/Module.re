type js;

[@bs.val] external import: string => Promise.t(js) = "import";
[@bs.get] external default: js => 'x = "default";

let fromJs = x =>
  x->Promise.map(m => [|m->default|]->Obj.magic)->Promise.result;
