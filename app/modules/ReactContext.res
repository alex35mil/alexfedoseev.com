module type Config = {
  type context
  let defaultValue: context
}

module Make = (Config: Config) => {
  let ctx = React.createContext(Config.defaultValue)

  module Provider = {
    let make = ctx->React.Context.provider

    @obj
    external makeProps: (
      ~value: Config.context,
      ~children: React.element,
      ~key: string=?,
      unit,
    ) => {"value": Config.context, "children": React.element} = ""
  }
}
