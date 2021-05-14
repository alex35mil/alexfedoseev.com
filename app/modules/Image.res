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

// TODO: Define all image types here
