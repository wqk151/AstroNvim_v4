local const = require "snippets.const"

const.ls.add_snippets("cpp", {
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
    trig = "cla",
    name = "cla",
    dscr = "simple class",
  }, {
    const.t { "class " },
    const.i(1, "className"),
    const.t { "", "{" },
    const.t { "", "public:", "\t" },
    const.i(0),
    const.t { "", "};" },
  }),
  const.s({
    trig = "include",
    name = "include standard library",
    dscr = "include iostream, vector, string",
  }, {
    const.t { "#include <iostream>" },
    const.t { "", "#include <vector>" },
    const.t { "", "#include <string>" },
    const.t { "", "using namespace std;", "" },
    const.i(0),
  }),
  const.s({
    trig = "func",
    name = "func",
    dscr = "define function",
  }, {
    const.i(1, "void"),
    const.t { " " },
    const.i(2, "funcName"),
    const.t { "(" },
    const.i(3),
    const.t { ")" },
    const.t { " " },
    const.t { "{", "\t" },
    const.i(4),
    const.t { "", "}" },
    const.i(0),
  }),
  const.s({
    trig = "funci",
    name = "funci",
    dscr = "declaration function",
  }, {
    const.i(1, "void"),
    const.t { " " },
    const.i(2, "funcName"),
    const.t { "(" },
    const.i(3),
    const.t { ");" },
    const.i(0),
  }),
  const.s({
    trig = "endl",
    name = "endl",
    dscr = "<< std::endl",
  }, {
    const.t { "<< std::endl" },
  }),
}, { key = "cpp" })
