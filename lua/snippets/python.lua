local const = require "snippets.const"

const.ls.add_snippets("python", {
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
    trig = "imop",
    name = "import open3d",
    dscr = "import open3d as o3d",
  }, {
    const.t { "import open3d as o3d", "" }, -- Auto jump to next line
  }),
  const.s({
    trig = "imnp",
    name = "import numpy",
    dscr = "import numpy as np",
  }, {
    const.t { "import numpy as np", "" },
  }),
  const.s({
    trig = "o3r",
    name = "open3d read_point_cloud",
    dscr = "open3d read_point_cloud from a file",
  }, {
    const.i(1, { "pcd" }),
    const.t { " = o3d.io.read_point_cloud(" },
    const.i(2, { "pcd_file" }),
    const.t { ")" },
    const.i(0),
  }),
  const.s({
    trig = "o3w",
    name = "open3d write_point_cloud",
    dscr = "open3d write_point_cloud to a file",
  }, {
    const.t { "o3d.io.write_point_cloud(" },
    const.i(1, { "pcd_file" }),
    const.t { ", " },
    const.i(2, { "pcd" }),
    const.t { ")" },
    const.i(0),
  }),
}, { key = "python" })
