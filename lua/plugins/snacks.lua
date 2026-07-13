return -- lazy.nvim
{
  "folke/snacks.nvim",
  ---@type snacks.Config
  opts = function()
    local get_icon = require("astroui").get_icon
    return {
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
      scroll = { enabled = false },
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
        sources = {
          files = {
            hidden = true,
            ignored = true,
            exclude = {
              "node_modules",
              "build",
              "devel",
              "logs",
              "cmake_build",
              ".DS_Store",
              ".git",
              ".yarn",
              ".cache",
              ".agents",
              ".claude",
              ".cursor",
              ".vscode",
            },
          },
        },
      },
    }
  end,

  specs = {
    {
      "AstroNvim/astrocore",
      opts = {
        mappings = {
          n = {
            ["<Leader>i"] = {
              function()
                local image = require "snacks.image"
                image.doc.hover_close()
                image.hover()
                vim.api.nvim_create_autocmd("CursorMoved", {
                  once = true,
                  group = vim.api.nvim_create_augroup("snacks_image_cleanup", { clear = true }),
                  callback = function() image.doc.hover_close() end,
                })
              end,
              desc = "Hover image",
            },
            -- Snacks jumps, 查看 Vim 的 Jump List（跳转历史）。如gd,gD, 打开的文件，搜索，结果等
            ["<leader>jf"] = { function() Snacks.picker.jumps() end, desc = "Jumps" },
          },
        },
      },
    },
  },
}
