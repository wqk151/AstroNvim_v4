local const = require "snippets.const"

const.ls.add_snippets("gitcommit", {
  const.s({
    trig = "todo",
    name = "add TODO commont",
    dscr = "add TODO commont",
  }, {
    const.t { "# TODO: " },
    const.i(0),
  }),
  const.s({
    trig = "note",
    name = "add NOTE commont",
    dscr = "add NOTE commont",
  }, {
    const.t { "# NOTE: " },
    const.i(0),
  }),
  const.s({
    trig = "revert",
    name = "revert conventional commit",
    dscr = "revert conventional commit",
  }, {
    const.t { "revert(" },
    const.i(1, { "scope" }),
    const.t { "): " },
    const.i(2, { "title" }),
    const.i(0),
  }),
}, { key = "gitcommit" })
