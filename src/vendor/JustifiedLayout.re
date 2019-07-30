type box;
type options;
type result;

[@bs.module "justified-layout"]
external make: array(float) => result = "default";

[@bs.module "justified-layout"]
external makeWithOptions: (array(float), options) => result = "default";

[@bs.obj]
external makeOptions:
  (
    ~containerWidth: int=?,
    ~containerPadding: int=?,
    ~boxSpacing: int=?,
    ~targetRowHeight: int=?,
    ~targetRowHeightTolerance: float=?,
    ~maxNumRows: int=?,
    ~forceAspectRatio: bool=?,
    ~showWidows: bool=?,
    ~fullWidthBreakoutRowCadence: int=?,
    unit
  ) =>
  options =
  "";

module Box = {
  [@bs.get] external aspectRatio: box => float = "aspectRatio";
  [@bs.get] external top: box => float = "top";
  [@bs.get] external left: box => float = "left";
  [@bs.get] external width: box => float = "width";
  [@bs.get] external height: box => float = "height";
};

module Result = {
  [@bs.get] external boxes: result => array(box) = "boxes";
  [@bs.get] external containerHeight: result => float = "containerHeight";
  [@bs.get] external widowCount: result => int = "widowCount";
};
