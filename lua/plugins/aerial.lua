return {
  "stevearc/aerial.nvim",
  event = "User AstroFile",
  opts = {
    attach_mode = "global",
    backends = { "treesitter", "lsp", "prosemd_lsp", "man" },
    layout = { min_width = 28 },
    show_guides = true,
    filter_kind = false,
    guides = {
      mid_item = "├ ",
      last_item = "└ ",
      nested_top = "│ ",
      whitespace = "  ",
    },
  },
}
