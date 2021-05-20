type id = string

let gaMeasurementId: id = Env.gaMeasurementId

type opts = {
  @as("page_path") pagePath: string,
  @as("send_page_view") sendPageView: bool,
}

@val @scope("window") external gtag: (@as(json`"config"`) _, id, opts) => unit = "gtag"

let script = `
window.dataLayer = window.dataLayer || [];
function gtag(){dataLayer.push(arguments);}
gtag('js', new Date());

gtag('config', '${gaMeasurementId}', {
  page_path: window.location.pathname,
  send_page_view: false,
});
`
let pageview = url => gtag(gaMeasurementId, {pagePath: url, sendPageView: false})
