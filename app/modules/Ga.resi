type id

let gaMeasurementId: id

type opts = {
  @as("page_path") pagePath: string,
  @as("send_page_view") sendPageView: bool,
}

@val @scope("window") external gtag: (@as(json`"config"`) _, id, opts) => unit = "gtag"

let script: string

let pageview: string => unit
