local const = require "snippets.const"

const.ls.add_snippets("go", {
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
  const.s({
    trig = "pmain",
    name = "init package main",
    dscr = "Initialize a new main package with a main func",
  }, {
    const.t { "package main", "", "func main() {", "\t" },
    const.i(0),
    const.t { "", "}" },
  }),
  const.s({
    trig = "iferr",
    name = "if error",
    dscr = "if statement to handle err",
  }, {
    const.t { "if err != nil {", "" },
    const.t "\t",
    const.i(0),
    const.t { "", "}" },
  }),
  const.s({
    trig = "iferrp",
    name = "if error panic",
    dscr = "if statement to panic an error",
  }, {
    const.t { "if err != nil {", "" },
    const.t "\t",
    const.t "panic(err)",
    const.t { "", "}" },
  }),
}, { key = "go" })
