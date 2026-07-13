local prefix = "<Leader>D"
return {
  "dlyongemallo/diffview-plus.nvim",
  event = "User AstroGitFile",
  opts = {},
  specs = {
    {
      "AstroNvim/astrocore",
      opts = {
        mappings = {
          n = {
            [prefix] = { name = " Diff View" },
            [prefix .. "<cr>"] = { "<cmd>DiffviewOpen<cr>", desc = "Open DiffView" },
            [prefix .. "h"] = { "<cmd>DiffviewFileHistory %<cr>", desc = "History for the current file" },
            [prefix .. "H"] = { "<cmd>DiffviewFileHistory<cr>", desc = "Open DiffView Branch History" },
            [prefix .. "q"] = { "<cmd>DiffviewClose<cr>", desc = "Quit Diffview" }, -- Close the current diffview. You can also use :tabclose.
            [prefix .. "e"] = { "<cmd>DiffviewToggleFiles<cr>", desc = "Toggle Explorer" }, -- Toggle the file panel.
          },
        },
      },
    },
  },
}
