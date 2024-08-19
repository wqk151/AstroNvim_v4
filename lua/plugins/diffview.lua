return {
  "sindrets/diffview.nvim",
  event = "User AstroGitFile",
  opts = function()
    local actions = require "diffview.actions"
    local utils = require "astrocore" --  astronvim utils

    local prefix = "<leader>D"

    utils.set_mappings {
      n = {
        [prefix] = { name = " Diff View" },
        [prefix .. "<cr>"] = { "<cmd>DiffviewOpen<cr>", desc = "Open DiffView" },
        [prefix .. "h"] = { "<cmd>DiffviewFileHistory %<cr>", desc = "Open DiffView File History" },
        [prefix .. "H"] = { "<cmd>DiffviewFileHistory<cr>", desc = "Open DiffView Branch History" },
        [prefix .. "q"] = { "<cmd>DiffviewClose<cr>", desc = "Quit Diffview" }, -- Toggle the file panel.
        [prefix .. "e"] = { actions.toggle_files, desc = "Toggle Explorer" }, -- Toggle the file panel.
        [prefix .. "o"] = { actions.focus_files, desc = "Focus Explorer" }, -- Bring focus to the file panel
      },
    }
  end,
}
