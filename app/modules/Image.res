type id

type orientation = [#portrait | #landscape | #square]

module Id = {
  external pack: string => id = "%identity"
  external toString: id => string = "%identity"
  let eq = (x1, x2) => x1->toString == x2->toString
}

module Basic = {
  type t = {src: string}
}

type basic = Basic.t

module BasicWithPlaceholder = {
  type t = {
    src: string,
    placeholder: string,
  }
}

type basicWithPlaceholder = BasicWithPlaceholder.t

module Fluid = {
  type t = {
    srcset: string,
    fallback: string,
    placeholder: string,
    width: int,
    height: int,
    aspectRatio: float,
    orientation: orientation,
  }
}

type fluid = Fluid.t

module Fixed = {
  type t<'srcset> = {
    srcset: 'srcset,
    fallback: string,
    placeholder: string,
    width: int,
    height: int,
    aspectRatio: float,
    orientation: orientation,
  }
}

type fixed<'srcset> = Fixed.t<'srcset>

module Raw = {
  type rec t = {
    srcset: srcset,
    fallback: string,
    placeholder: string,
    width: int,
    height: int,
    aspectRatio: float,
    orientation: orientation,
  }
  and srcset = {
    sm: densities,
    md: densities,
    lg: densities,
    xl: densities,
  }
  and densities = {
    @as("@1x")
    x1: density,
    @as("@2x")
    x2: density,
    @as("@3x")
    x3: density,
  }
  and density = {
    src: string,
    width: float,
    height: float,
  }
}

type raw = Raw.t
