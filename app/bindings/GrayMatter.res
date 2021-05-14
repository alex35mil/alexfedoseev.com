type output = {
  data: Js.Json.t,
  content: string,
}

@module("gray-matter")
external parse: string => output = "default"
