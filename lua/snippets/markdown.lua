local const = require "snippets.const"

const.ls.add_snippets("markdown", {
  const.s({
    trig = "todo",
    name = "add TODO commont",
    dscr = "add TODO commont",
  }, {
    const.t { "<!-- TODO: " },
    const.i(0),
    const.t { " -->" },
  }),
  const.s({
    trig = "note",
    name = "add NOTE commont",
    dscr = "add NOTE commont",
  }, {
    const.t { "<!-- NOTE: " },
    const.i(0),
    const.t { " -->" },
  }),
  const.s({
    trig = "meta",
    namr = "Metadata",
    dscr = "Yaml metadata format for markdown",
  }, {
    const.t { "---", "title: " },
    const.i(1, "note_title"),
    const.t { "", "author: " },
    const.i(2, "author"),
    const.t { "", "date: " },
    const.f(const.date, {}),
    const.t { "", "categories: [" },
    const.i(3, ""),
    const.t { "]", "lastmod: " },
    const.f(const.date, {}),
    const.t { "", "tags: [" },
    const.i(4),
    const.t { "]", "comments: true", "---", "" },
    const.i(0),
  }),
}, { key = "markdown" })
