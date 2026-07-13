local prefix = "<Leader>j"
return {
  "smoka7/hop.nvim",
  version = "*",
  opts = {
    keys = "etovxqpdygfblzhckisuran",
  },
  specs = {
    {
      "AstroNvim/astrocore",
      opts = {
        mappings = {
          n = {
            [prefix] = { name = " Hop" },
            [prefix .. "l"] = { "<cmd>HopLine<cr>", desc = "Line" },
            [prefix .. "w"] = { "<cmd>HopWord<cr>", desc = "Word" },
          },
        },
      },
    },
  },
}
