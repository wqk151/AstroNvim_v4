return {
  "akinsho/toggleterm.nvim",
  version = "*",
  opts = {},
  specs = {
    {
      "AstroNvim/astrocore",
      opts = {
        mappings = {
          t = {
            ["<C-q>"] = { "<C-\\><C-n>", desc = "Terminal normal mode" },
            ["<esc><esc>"] = { "<C-\\><C-n>:q<cr>", desc = "Terminal quit" },
          },
          n = {
            ["<leader>ti"] = {
              function() require("astrocore").toggle_term_cmd { cmd = "ipython" } end,
              desc = "ToggleTerm ipython",
            },
            ["<leader>tj"] = {
              function() require("astrocore").toggle_term_cmd { cmd = "yazi", direction = "float" } end,
              desc = "ToggleTerm ipython",
            },
          },
        },
      },
    },
  },
}
