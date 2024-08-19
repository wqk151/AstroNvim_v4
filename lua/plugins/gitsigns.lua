return {
  "lewis6991/gitsigns.nvim",
  event = "User AstroGitFile",
  opts = {
    signs = {
      add = { text = "+" },
      change = { text = "~" },
      delete = { text = "_" },
      -- changedelete = { text = "~" },
      changedelete = { text = "║" },
      topdelete = { text = "契" },
      untracked = { text = "┆" },
    },
  },
  config = function(_, opts) require("gitsigns").setup(opts) end,
}
