const matter = require("gray-matter")

module.exports = async function (src) {
  const callback = this.async()
  const {content} = matter(src)

  return callback(null, content)
}
