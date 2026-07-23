local prefix = "<Leader>A"
return {
  "folke/sidekick.nvim",
  ---@type sidekick.Config
  opts = { nes = { enabled = false } },
  specs = {
    {
      "AstroNvim/astrocore",
      ---@type AstroCoreOpts
      opts = {
        options = {
          g = {
            ai_accept = function()
              return require("sidekick").nes_jump_or_apply()
                or (vim.lsp.inline_completion and vim.lsp.inline_completion.get())
            end,
          },
        },
        mappings = {
          n = {
            [prefix] = { desc = "󰭻 AI" },
            [prefix .. "A"] = {
              function() require("sidekick.cli").toggle { filter = { installed = true } } end,
              desc = "Toggle AI CLI",
            },
            [prefix .. "c"] = {
              function() require("sidekick.cli").toggle { name = "claude", focus = true } end,
              desc = "Toggle Claude",
            },
            [prefix .. "o"] = {
              function() require("sidekick.cli").focus() end,
              desc = "Focus",
            },
            [prefix .. "d"] = {
              function() require("sidekick.cli").close() end,
              desc = "Detach AI CLI",
            },
            [prefix .. "s"] = {
              function() require("sidekick.cli").select { filter = { intalled = true } } end,
              desc = "Select an AI CLI",
            },
            [prefix .. "t"] = {
              function() require("sidekick.cli").send { msg = "{this}" } end,
              desc = "Send This to AI CLI",
            },
            [prefix .. "f"] = {
              function() require("sidekick.cli").send { msg = "{file}" } end,
              desc = "Send File to AI CLI",
            },
            [prefix .. "p"] = {
              function() require("sidekick.cli").prompt() end,
              desc = "Send Prompt to AI CLI",
            },
            [prefix .. "c"] = {
              function() require("sidekick.cli").toggle { name = "claude", focus = true } end,
              desc = "Toggle Claude",
            },
            [prefix .. "l"] = {
              function()
                vim.lsp.enable("copilot", not vim.lsp.is_enabled "copilot")
                require("astrocore").notify(
                  "Copilot LSP " .. (vim.lsp.is_enabled "copilot" and "enabled" or "disabled")
                )
              end,
              desc = "Toggle Copilot LSP",
            },
          },
          x = {
            [prefix] = { desc = " AI" },
            [prefix .. "o"] = {
              function() require("sidekick.cli").focus() end,
              desc = "Focus",
            },
            [prefix .. "t"] = {
              function() require("sidekick.cli").send { msg = "{this}" } end,
              desc = "Send This to AI CLI",
            },
            [prefix .. "v"] = {
              function() require("sidekick.cli").send { msg = "{selection}" } end,
              desc = "Send Selection to AI CLI",
            },
            [prefix .. "p"] = {
              function() require("sidekick.cli").prompt() end,
              desc = "Send Prompt to AI CLI",
            },
            [prefix .. "A"] = {
              function() require("sidekick.cli").toggle { filter = { installed = true } } end,
              desc = "Toggle AI CLI",
            },
          },
          t = {
            [prefix .. "A"] = {
              function() require("sidekick.cli").toggle { filter = { installed = true } } end,
              desc = "Toggle AI CLI",
            },
            [prefix .. "o"] = {
              function() require("sidekick.cli").focus() end,
              desc = "Focus",
            },
          },

          i = {
            [prefix .. "o"] = {
              function() require("sidekick.cli").focus() end,
              desc = "Focus",
            },
            ["<A-a>"] = {
              function()
                if vim.lsp.inline_completion and vim.lsp.inline_completion.get() then return end
                return "<A-a>"
              end,
              expr = true,
              desc = "Accept inline completion",
            },
          },
        },
      },
    },
    {
      "AstroNvim/astrolsp",
      ---@type AstroLSPOpts
      opts = {
        features = { inline_completion = true },
        handlers = { copilot = false },
      },
    },
    -- {
    --   "WhoIsSethDaniel/mason-tool-installer.nvim",
    --   opts = { ensure_installed = { "copilot-language-server" } },
    -- },
    -- {
    --   "neovim/nvim-lspconfig",
    --   config = function() vim.lsp.enable "copilot" end,
    -- },
  },
}
