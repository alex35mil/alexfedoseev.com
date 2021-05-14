type box
type options
type result

@module("justified-layout")
external make: array<float> => result = "default"

@module("justified-layout")
external makeWithOptions: (array<float>, options) => result = "default"

@obj
external makeOptions: (
  ~containerWidth: int=?,
  ~containerPadding: int=?,
  ~boxSpacing: int=?,
  ~targetRowHeight: int=?,
  ~targetRowHeightTolerance: float=?,
  ~maxNumRows: int=?,
  ~forceAspectRatio: bool=?,
  ~showWidows: bool=?,
  ~fullWidthBreakoutRowCadence: int=?,
  unit,
) => options = ""

module Box = {
  @get external aspectRatio: box => float = "aspectRatio"
  @get external top: box => float = "top"
  @get external left: box => float = "left"
  @get external width: box => float = "width"
  @get external height: box => float = "height"
}

module Result = {
  @get external boxes: result => array<box> = "boxes"
  @get external containerHeight: result => float = "containerHeight"
  @get external widowCount: result => int = "widowCount"
}
