return {
  {
    "Kurama622/llm.nvim",
    dependencies = { "nvim-lua/plenary.nvim", "MunifTanjim/nui.nvim" },
    cmd = { "LLMSessionToggle", "LLMSelectedTextHandler", "LLMAppHandler" },
    config = function()
      local tools = require "llm.common.tools"
      require("llm").setup {
        -- [[ Deepseek ]]
        url = "https://api.deepseek.com/chat/completions",
        model = "deepseek-chat",
        api_type = "openai",
        max_tokens = 4096,
        temperature = 0.3,
        top_p = 0.7,
        fetch_key = function() return vim.env.DEEPSEEK_API_KEY end,

        prompt = "You are a helpful chinese assistant.",

        prefix = {
          user = { text = "😃 ", hl = "Title" },
          assistant = { text = "  ", hl = "Added" },
        },

        -- history_path = "/tmp/llm-history",
        save_session = true,
        max_history = 15,
        max_history_name_length = 20,

        -- stylua: ignore
        keys = {
          -- The keyboard mapping for the input window.
          ["Input:Submit"]      = { mode = "n", key = "<cr>" },
          ["Input:Cancel"]      = { mode = {"n", "i"}, key = "<C-c>" },
          ["Input:Resend"]      = { mode = {"n", "i"}, key = "<C-r>" },

          -- only works when "save_session = true"
          ["Input:HistoryNext"] = { mode = {"n", "i"}, key = "<C-j>" },
          ["Input:HistoryPrev"] = { mode = {"n", "i"}, key = "<C-k>" },

          -- The keyboard mapping for the output window in "split" style.
          ["Output:Ask"]        = { mode = "n", key = "i" },
          ["Output:Cancel"]     = { mode = "n", key = "<C-c>" },
          ["Output:Resend"]     = { mode = "n", key = "<C-r>" },

          -- The keyboard mapping for the output and input windows in "float" style.
          ["Session:Toggle"]    = { mode = "n", key = "<leader>ac" },
          ["Session:Close"]     = { mode = "n", key = {"<esc>", "Q"} },

          -- Scroll
          ["PageUp"]            = { mode = {"i","n"}, key = "<C-b>" },
          ["PageDown"]          = { mode = {"i","n"}, key = "<C-f>" },
          ["HalfPageUp"]        = { mode = {"i","n"}, key = "<C-u>" },
          ["HalfPageDown"]      = { mode = {"i","n"}, key = "<C-d>" },
          ["JumpToTop"]         = { mode = "n", key = "gg" },
          ["JumpToBottom"]      = { mode = "n", key = "G" },
        },
        app_handler = {
          DocString = {
            prompt = [[You are an AI programming assistant. You need to write a really good docstring that follows a best practice for the given language.

Your core tasks include:
- parameter and return types (if applicable).
- any errors that might be raised or returned, depending on the language.

You must:
- Place the generated docstring before the start of the code.
- Follow the format of examples carefully if the examples are provided.
- Use Markdown formatting in your answers.
- Include the programming language name at the start of the Markdown code blocks.]],
            handler = tools.action_handler,
            opts = {
              fetch_key = function() return vim.env.DEEPSEEK_API_KEY end,
              url = "https://api.deepseek.com/chat/completions",
              model = "deepseek-chat",
              api_type = "openai",
              only_display_diff = true,
              templates = {
                lua = [[- For the Lua language, you should use the LDoc style.
- Start all comment lines with "---".
]],
              },
            },
          },
          CommitMsg = {
            handler = tools.flexi_handler,
            prompt = function()
              -- Source: https://andrewian.dev/blog/ai-git-commits
              return string.format(
                [[You are an expert at following the Conventional Commit specification. Given the git diff listed below, please generate a commit message for me:
      1. First line: conventional commit format (type: concise description) (remember to use semantic types like feat, fix, docs, style, refactor, perf, test, chore, etc.)
      2. Optional bullet points if more context helps:
        - Keep the second line blank
        - Keep them short and direct
        - Focus on what changed
        - Always be terse
        - Don't overly explain
        - Drop any fluffy or formal language

      Return ONLY the commit message - no introduction, no explanation, no quotes around it.

      Examples:
      feat: add user auth system

      - Add JWT tokens for API auth
      - Handle token refresh for long sessions

      fix: resolve memory leak in worker pool

      - Clean up idle connections
      - Add timeout for stale workers

      Simple change example:
      fix: typo in README.md

      Very important: Do not respond with any of the examples. Your message must be based off the diff that is about to be provided, with a little bit of styling informed by the recent commits you're about to see.

      Based on this format, generate appropriate commit messages. Respond with message only. DO NOT format the message in Markdown code blocks, DO NOT use backticks:

      ```diff
      %s
      ```
      ]],
                vim.fn.system "git diff --no-ext-diff --staged"
              )
            end,

            opts = {
              fetch_key = function() return vim.env.DEEPSEEK_API_KEY end,
              url = "https://api.deepseek.com/chat/completions",
              model = "deepseek-chat",
              api_type = "openai",
              enter_flexible_window = true,
              apply_visual_selection = false,
              win_opts = {
                relative = "editor",
                position = "50%",
              },
              accept = {
                mapping = {
                  mode = "n",
                  keys = "<cr>",
                },
                action = function()
                  local contents = vim.api.nvim_buf_get_lines(0, 0, -1, true)
                  vim.api.nvim_command(string.format('!git commit -m "%s"', table.concat(contents, '" -m "')))

                  -- just for lazygit
                  vim.schedule(function() vim.api.nvim_command "LazyGit" end)
                end,
              },
            },
          },
          Ask = {
            -- handler = tools.disposable_ask_handler,
            handler = tools.side_by_side_handler,
            opts = {
              position = {
                row = 2,
                col = 0,
              },
              title = " Ask ",
              inline_assistant = true,
              language = "Chinese",
              url = "https://api.deepseek.com/chat/completions",
              model = "deepseek-chat",
              api_type = "openai",
              fetch_key = function() return vim.env.DEEPSEEK_API_KEY end,
              display = {
                mapping = {
                  mode = "n",
                  keys = { "d" },
                },
                action = nil,
              },
              accept = {
                mapping = {
                  mode = "n",
                  keys = { "Y", "y" },
                },
                action = nil,
              },
              reject = {
                mapping = {
                  mode = "n",
                  keys = { "N", "n" },
                },
                action = nil,
              },
              close = {
                mapping = {
                  mode = "n",
                  keys = { "<esc>" },
                },
                action = nil,
              },
            },
          },
        },
      }
    end,
    keys = {
      { "<leader>ac", mode = "n", "<cmd>LLMSessionToggle<cr>", desc = " Toggle LLM Chat(llm)" },
      { "<leader>ts", mode = "x", "<cmd>LLMAppHandler WordTranslate<cr>", desc = " Word Translate(llm)" },
      { "<leader>ae", mode = "v", "<cmd>LLMAppHandler CodeExplain<cr>", desc = " Explain the Code(llm)" },
      { "<leader>at", mode = "n", "<cmd>LLMAppHandler Translate<cr>", desc = " AI Translator(llm)" },
      { "<leader>tc", mode = "x", "<cmd>LLMAppHandler TestCode<cr>", desc = " Generate Test Cases(llm)" },
      { "<leader>ao", mode = "x", "<cmd>LLMAppHandler OptimCompare<cr>", desc = " Optimize the Code(llm)" },
      { "<leader>au", mode = "n", "<cmd>LLMAppHandler UserInfo<cr>", desc = " Check Account Information(llm)" },
      { "<leader>ag", mode = "n", "<cmd>LLMAppHandler CommitMsg<cr>", desc = " Generate AI Commit Message(llm)" },
      { "<leader>ad", mode = "v", "<cmd>LLMAppHandler DocString<cr>", desc = " Generate a Docstring(llm)" },
      { "<leader>ak", mode = { "v", "n" }, "<cmd>LLMAppHandler Ask<cr>", desc = " Ask LLM(llm)" },
      {
        "<leader>aa",
        mode = { "v", "n" },
        "<cmd>LLMAppHandler AttachToChat<cr>",
        desc = " Ask LLM (multi-turn)(llm)",
      },
      -- { "<leader>ao", mode = "x", "<cmd>LLMAppHandler OptimizeCode<cr>" },
      -- { "<leader>ae", mode = "v", "<cmd>LLMSelectedTextHandler 请解释下面这段代码<cr>" },
      -- { "<leader>ts", mode = "x", "<cmd>LLMSelectedTextHandler 英译汉<cr>" },
    },
  },
}
