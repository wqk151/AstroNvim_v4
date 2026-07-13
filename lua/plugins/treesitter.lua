return {
  "AstroNvim/astrocore",
  ---@type AstroCoreOpts
  opts = {
    -- Configuration of treesitter features in Neovim
    treesitter = {
      -- Globally enable or disable treesitter features
      -- can be:
      --   - a boolean
      --   - a function (`fun(lang: string, bufnr: integer): boolean`)
      enabled = function(lang, bufnr) return not require("astrocore.buffer").is_large(bufnr) end,
      -- Enable or disable treesitter based highlighting
      -- can be:
      --   - a boolean
      --   - a function (`fun(lang: string, bufnr: integer): boolean`)
      highlight = true,
      -- Enable or disable treesitter based indenting
      -- can be:
      --   - a boolean
      --   - a function (`fun(lang: string, bufnr: integer): boolean`)
      indent = true,
      -- List of treesitter parsers that should be installed automatically
      -- ("all" can be used to install all available parsers)
      ensure_installed = { "lua", "vim", "vimdoc" },
      -- Automatically detect missing treesitter parser and install when editing file
      auto_install = false,
      -- Configure treesitter based text objects (requires `nvim-treesitter-textobjects`)
      -- These options set up automatic detection of available queries for a file and creates
      -- only the available bindings for each buffer.
      -- ~/.local/share/nvim/lazy/nvim-treesitter-textobjects/queries/python/textobjects.scm
      textobjects = {
        select = {
          select_textobject = {
            ["af"] = { query = "@function.outer", desc = "around function" },
            ["if"] = { query = "@function.inner", desc = "around function" },

            ["ac"] = { query = "@class.outer", desc = "around class" },
            ["ic"] = { query = "@class.inner", desc = "around class" },

            ["al"] = { query = "@loop.outer", desc = "around loop" },
            ["il"] = { query = "@loop.inner", desc = "around loop" },

            ["ai"] = { query = "@conditional.outer", desc = "around conditional" },
            ["ii"] = { query = "@conditional.inner", desc = "around conditional" },
          },
        },
        move = {
          goto_next_start = {
            ["]f"] = { query = "@function.outer", desc = "Next function start" },
          },
          goto_next_end = {
            ["]F"] = { query = "@function.outer", desc = "Next function end" },
          },
          goto_previous_start = {
            ["[f"] = {
              query = "@function.outer",
              desc = "Previous function start",
            },
          },
          goto_previous_end = {
            ["[F"] = {
              query = "@function.outer",
              desc = "Previous function end",
            },
          },
        },
        swap = {
          swap_next = {
            [">F"] = { query = "@function.outer", desc = "Swap next function" },
          },
          swap_previous = {
            ["<F"] = {
              query = "@function.outer",
              desc = "Swap previous function",
            },
          },
        },
      },
    },
  },
}
