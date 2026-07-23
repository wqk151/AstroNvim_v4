---@type LazySpec
-- Expand 'cc' into 'CodeCompanion' in the command line
vim.cmd [[cab cc CodeCompanion]]
return {
  "olimorris/codecompanion.nvim",
  event = "User AstroFile",
  cmd = {
    "CodeCompanion",
    "CodeCompanionActions",
    "CodeCompanionChat",
    "CodeCompanionCmd",
  },
  dependencies = {
    "nvim-lua/plenary.nvim",
    "nvim-treesitter/nvim-treesitter",
    "j-hui/fidget.nvim",
    "ravitemer/codecompanion-history.nvim", -- history extension
  },
  init = function() require("plugins.fidget-spinner"):init() end,
  opts = {
    opts = {
      language = "Chinese",
    },
    display = {
      chat = {
        auto_scroll = true,
        -- show_settings = true, -- Show LLM settings at the top of the chat buffer?, can not change adapter when set true
        start_in_insert_mode = true, -- Open the chat buffer in insert mode?
      },
    },
    interactions = {
      chat = {
        adapter = {
          name = "claude_code",
          model = "deepseek-v4-flash",
        },
        roles = {
          user = "",
        },
        keymaps = {
          send = {
            modes = {
              i = { "<C-s>" },
            },
          },
        },
      },
      inline = {
        adapter = {
          name = "deepseek",
          model = "deepseek-v4-flash",
        },
      },
      shared = {
        keymaps = {
          accept_change = {
            modes = { n = "ga" },
            description = "Accept the suggested change",
          },
          reject_change = {
            modes = { n = "gr" },
            opts = { nowait = true },
            description = "Reject the suggested change",
          },
        },
      },
      cmd = {
        adapter = {
          name = "deepseek",
          model = "deepseek-v4-flash",
        },
      },
    },
    adapters = {
      http = {
        extend = {
          anthropic = { env = { api_key = "cmd:op read op://personal/Anthropic_API/credential --no-newline" } },
          gemini = { env = { api_key = "cmd:op read op://personal/Gemini_API/credential --no-newline" } },
          openai = { env = { api_key = "cmd:op read op://personal/OpenAI_API/credential --no-newline" } },
        },
      },
      acp = {
        extend = {
          claude_code = {
            defaults = { mcpServers = "inherit_from_config" },
            -- env = { CLAUDE_CODE_OAUTH_TOKEN = "cmd:op read op://personal/Claude_Code_OAuth/credential --no-newline" },
          },
          codex = {
            env = { OPENAI_API_KEY = "cmd:op read op://personal/OpenAI_API/credential --no-newline" },
          },
          gemini_cli = {
            defaults = { auth_method = "gemini-api-key" },
            env = { GEMINI_API_KEY = "cmd:op read op://personal/Gemini_API/credential --no-newline" },
          },
        },
      },
    },
    mcp = {
      servers = {
        ["memory"] = {
          cmd = { "npx", "-y", "@modelcontextprotocol/server-memory" },
        },
        ["sequential-thinking"] = {
          cmd = { "npx", "-y", "@modelcontextprotocol/server-sequential-thinking" },
        },
        -- ["tavily-mcp"] = {
        --   cmd = { "npx", "-y", "tavily-mcp@latest" },
        --   env = {
        --     TAVILY_API_KEY = "cmd:op read op://personal/Tavily_API/credential --no-newline",
        --   },
        --   tool_defaults = {
        --     require_approval_before = true,
        --   },
        -- },
      },
      opts = {
        -- The opts.default_servers option controls which MCP servers are automatically started
        -- with their tools added to the chat buffer.
        default_servers = { "sequential-thinking" },
      },
    },
    rules = {
      personal = {
        description = "Collection of common files for all projects",
        {
          path = "~/.config/nvim/lua/rules",
          files = "*.md",
        },
      },
      opts = {
        chat = {
          autoload = { "default", "personal" }, -- The rule groups to load
          enabled = true,
        },
      },
    },
    prompt_library = {
      markdown = {
        dirs = {
          vim.fn.getcwd() .. "/.prompts",
          "~/.config/nvim/lua/prompts",
        },
      },
    },
    extensions = {
      history = {
        enabled = true, -- defaults to true
        opts = {
          dir_to_save = vim.fn.stdpath "data" .. "/codecompanion_chats.json",
        },
      },
    },
  },
  specs = {
    {
      "AstroNvim/astrocore",
      opts = function(_, opts)
        local prefix = "<Leader>A"
        opts.mappings.n[prefix] = { desc = "󰭻 AI" }
        opts.mappings.v[prefix] = { desc = "󰭻 AI" }
        opts.mappings.n[prefix .. "c"] = { "<cmd>CodeCompanionChat Toggle<cr>", desc = "Toggle chat" }
        opts.mappings.v[prefix .. "c"] = { "<cmd>CodeCompanionChat Toggle<cr>", desc = "Toggle chat" }
        opts.mappings.n[prefix .. "p"] = { "<cmd>CodeCompanionActions<cr>", desc = "Open action palette" }
        opts.mappings.v[prefix .. "p"] = { "<cmd>CodeCompanionActions<cr>", desc = "Open action palette" }
        opts.mappings.n[prefix .. "i"] = { "<cmd>CodeCompanion<cr>", desc = "Open inline assistant" }
        opts.mappings.v[prefix .. "i"] = { "<cmd>CodeCompanion<cr>", desc = "Open inline assistant" }
        opts.mappings.n[prefix .. "h"] = { "<cmd>CodeCompanionHistory<cr>", desc = "Open the history browser" }
        opts.mappings.n[prefix .. "s"] = { "<cmd>CodeCompanionSummaries<cr>", desc = " Browse all summaries" }
        opts.mappings.v[prefix .. "a"] = { "<cmd>CodeCompanionChat Add<cr>", desc = "Add selection to chat" }
      end,
    },
    {
      "saghen/blink.cmp",
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
