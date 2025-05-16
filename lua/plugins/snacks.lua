local get_icon = require("astroui").get_icon
return -- lazy.nvim
{
  "folke/snacks.nvim",
  ---@type snacks.Config
  opts = {
    bigfile = {
      -- your bigfile configuration comes here
      -- or leave it empty to use the default settings
      -- refer to the configuration section below
    },
    dashboard = {
      preset = {
        keys = {
          { key = "f", action = "<Leader>ff", icon = get_icon("Search", 0, true), desc = "Find File  " },
          { key = "f", action = "<Leader>zf", icon = get_icon("Search", 0, true), desc = "Find Notes  " },
          { key = "t", action = "<Leader>zt", icon = get_icon("Search", 0, true), desc = "Find Tags  " },
          { key = "n", action = "<Leader>zn", icon = get_icon("FileNew", 0, true), desc = "New Note  " },
          { key = "w", action = "<Leader>fw", icon = get_icon("WordFile", 0, true), desc = "Find Word  " },
          { key = "'", action = "<Leader>f'", icon = get_icon("Bookmarks", 0, true), desc = "Bookmarks  " },
        },
      },
    },
    image = {
      enabled = true,
      doc = {
        enabled = true,
        inline = true,
        float = true,
        max_height = 20,
      },
    },
    scroll = { enabled = true },
    picker = {
      -- your picker configuration comes here
      -- or leave it empty to use the default settings
      -- refer to the configuration section below
      win = {
        -- input window
        input = {
          keys = {
            ["<S-Tab>"] = { "list_up", mode = { "i", "n" } },
            ["<Tab>"] = { "list_down", mode = { "i", "n" } },
            ["<c-u>"] = { "preview_scroll_up", mode = { "i", "n" } },
            ["<c-d>"] = { "preview_scroll_down", mode = { "i", "n" } },
          },
        },
        list = {
          keys = {
            ["<S-Tab>"] = { "list_up", mode = { "i", "n" } },
            ["<Tab>"] = { "list_down", mode = { "i", "n" } },
            ["<c-u>"] = { "preview_scroll_up", mode = { "i", "n" } },
            ["<c-d>"] = { "preview_scroll_down", mode = { "i", "n" } },
          },
        },
      },
    },
  },
}
