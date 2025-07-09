---@type LazySpec
return {
  "olimorris/codecompanion.nvim",
  event = "User AstroFile",
  enabled = false, -- test out Avante
  cmd = {
    "CodeCompanion",
    "CodeCompanionActions",
    "CodeCompanionChat",
    "CodeCompanionCmd",
  },
  dependencies = { "nvim-lua/plenary.nvim", "nvim-treesitter/nvim-treesitter" },
  opts = {
    display = {
      chat = {
        start_in_insert_mode = true,
        window = {
          opts = {
            number = false,
            relativenumber = false,
          },
        },
      },
    },
    strategies = {
      chat = {
        adapter = "glados",
      },
      inline = {
        adapter = "glados",
      },
      cmd = {
        adapter = "glados",
      },
    },
    adapters = {
      opts = { show_defaults = false },
      glados = function()
        return require("codecompanion.adapters").extend("openai", {
          name = "deepseek",
          formatted_name = "DeepSeek",
          url = "https://api.deepseek.com",
          env = { api_key = "DEEPSEEK_API_KEY" },
          schema = {
            model = {
              default = "deepseek-coder",
            },
          },
        })
      end,
    },
  },
  specs = {
    {
      "AstroNvim/astrocore",
      opts = function(_, opts)
        local prefix = "<Leader>A"
        opts.mappings.n[prefix] = { desc = " AI" }
        opts.mappings.v[prefix] = { desc = " AI" }
        opts.mappings.n[prefix .. "<CR>"] = { function() vim.cmd.CodeCompanionChat "Toggle" end, desc = "AI Chat" }
        opts.mappings.v[prefix .. "<CR>"] = { function() vim.cmd.CodeCompanionChat "Add" end, desc = "Add to AI Chat" }
        opts.mappings.n[prefix .. "A"] = { function() vim.cmd.CodeCompanionActions() end, desc = "AI Actions" }
        opts.mappings.v[prefix .. "A"] = { function() vim.cmd.CodeCompanionActions() end, desc = "AI Actions" }
      end,
    },
    {
      "Saghen/blink.cmp",
      optional = true,
      dependencies = { "olimorris/codecompanion.nvim" },
      opts = {
        sources = {
          per_filetype = {
            codecompanion = { "codecompanion" },
          },
        },
      },
    },
    {
      "MeanderingProgrammer/render-markdown.nvim",
      optional = true,
      opts = function(_, opts)
        if not opts.file_types then opts.file_types = { "markdown" } end
        opts.file_types = require("astrocore").list_insert_unique(opts.file_types, { "codecompanion" })
      end,
    },
  },
}
