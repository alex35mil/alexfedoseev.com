module Dom = {
  include Webapi.Dom;

  [@bs.val] external devicePixelRatio: float = "devicePixelRatio";

  external htmlImageElementFromElement: Dom.element => HtmlImageElement.t =
    "%identity";
};

module Url = Webapi.Url;
