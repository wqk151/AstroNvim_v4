local const = require "snippets.const"

const.ls.add_snippets("c", {
  const.s({
    trig = "todo",
    name = "add TODO commont",
    dscr = "add TODO commont",
  }, {
    const.t { "// TODO: " },
    const.i(0),
  }),
  const.s({
    trig = "note",
    name = "add NOTE commont",
    dscr = "add NOTE commont",
  }, {
    const.t { "// NOTE: " },
    const.i(0),
  }),
}, { key = "c" })
