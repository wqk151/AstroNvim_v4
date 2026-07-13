return {
  "Kurama622/llm.nvim",
  -- If code completion uses Codeium, it requires `Exafunction/codeium.nvim`; otherwise, it does not.
  dependencies = { "nvim-lua/plenary.nvim", "MunifTanjim/nui.nvim" },
  cmd = { "LLMSessionToggle", "LLMSelectedTextHandler", "LLMAppHandler" },
  -- vim.api.nvim_set_hl(0, "Query", { fg = "#6aa84f", bg = "NONE" })
  opts = function()
    local tools = require "llm.tools"
    return {
      -- [[deepseek]]
      url = "https://api.deepseek.com/chat/completions",
      model = "deepseek-v4-flash",
      enable_thinking = false,
      api_type = "openai",
      max_tokens = 4096,
      fetch_key = function() return vim.env.DEEPSEEK_API_KEY end,
      temperature = 0.3,
      top_p = 0.7,

      prompt = "You are a helpful chinese assistant.",

      spinner = {
        text = {
          "󰧞󰧞",
          "󰧞󰧞",
          "󰧞󰧞",
          "󰧞󰧞",
        },
        hl = "Title",
      },

      prefix = {
        -- 
        user = { text = "😃 ", hl = "Title" },
        assistant = { text = "  ", hl = "Added" },
      },

      display = {
        diff = {
          layout = "vertical", -- vertical|horizontal split for default provider
          opts = { "internal", "filler", "closeoff", "algorithm:patience", "followwrap", "linematch:120" },
          provider = "mini_diff", -- default|mini_diff
        },
      },
      -- style = "right",
      save_session = true,
      max_history = 15,
      max_history_name_length = 20,

        -- stylua: ignore
        -- popup window options
        popwin_opts = {
          relative = "cursor", enter = true,
          focusable = true, zindex = 50,
          position = { row = -7, col = 15, },
          size = { height = 15, width = "50%", },
          border = { style = "single",
            text = { top = " Explain ", top_align = "center" },
          },
          win_options = {
            winblend = 0,
            winhighlight = "Normal:Normal,FloatBorder:FloatBorder",
          },
        },

        -- stylua: ignore
        keys = {
          -- The keyboard mapping for the input window.
          -- ["Input:Submit"]      = { mode = "n", key = "<cr>" },
          ["Input:Submit"]      = { mode = { "i" }, key = "<C-s>" },
          ["Input:Cancel"]      = { mode = { "n", "i" }, key = "<C-c>" },
          ["Input:Resend"]      = { mode = { "n", "i" }, key = "<C-r>" },

          -- only works when "save_session = true"
          ["Input:HistoryNext"] = { mode = { "n", "i" }, key = "<C-j>" },
          ["Input:HistoryPrev"] = { mode = { "n", "i" }, key = "<C-k>" },

          -- The keyboard mapping for the output window in "split" style.
          ["Output:Ask"]        = { mode = "n", key = "i" },
          ["Output:Cancel"]     = { mode = "n", key = "<C-c>" },
          ["Output:Resend"]     = { mode = "n", key = "<C-r>" },

          -- The keyboard mapping for the output and input windows in "float" style.
          ["Session:Toggle"]    = { mode = "n", key = "<leader>ac" },
          ["Session:Close"]     = { mode = "n", key = { "<esc>", "Q" } },

          -- Scroll [default]
          ["PageUp"]            = { mode = { "i", "n" }, key = "<C-b>" },
          ["PageDown"]          = { mode = { "i", "n" }, key = "<C-f>" },
          ["HalfPageUp"]        = { mode = { "i", "n" }, key = "<C-u>" },
          ["HalfPageDown"]      = { mode = { "i", "n" }, key = "<C-d>" },
          ["JumpToTop"]         = { mode = "n", key = "gg" },
          ["JumpToBottom"]      = { mode = "n", key = "G" }
        },

      app_handler = {
        OptimizeCode = {
          handler = tools.side_by_side_handler,
          opts = {
            -- streaming_handler = local_llm_streaming_handler,
            left = {
              focusable = false,
            },
          },
        },
        TestCode = {
          handler = tools.side_by_side_handler,
          prompt = [[Write some test cases for the following code, only return the test cases.
            Give the code content directly, do not use code blocks or other tags to wrap it.]],
          opts = {
            right = {
              title = " Test Cases ",
            },
          },
        },
        OptimCompare = {
          handler = tools.action_handler,
          opts = {
            fetch_key = function() return vim.env.DEEPSEEK_API_KEY end,
            url = "https://api.deepseek.com/chat/completions",
            model = "deepseek-v4-flash",
            enable_thinking = false,
            api_type = "openai",
            max_tokens = 4096,
            language = "Chinese",
          },
        },

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
            model = "deepseek-v4-flash",
            enable_thinking = false,
            api_type = "openai",
            max_tokens = 4096,
            only_display_diff = true,
            templates = {
              lua = [[- For the Lua language, you should use the LDoc style.
- Start all comment lines with "---".
]],
            },
          },
        },
        Translate = {
          prompt = "Translate the following text to Chinese, please only return the translation",
          handler = tools.qa_handler,
          opts = {
            fetch_key = function() return vim.env.DEEPSEEK_API_KEY end,
            url = "https://api.deepseek.com/chat/completions",
            model = "deepseek-v4-flash",
            enable_thinking = false,
            api_type = "openai",
            max_tokens = 4096,

            component_width = "60%",
            component_height = "50%",
            query = {
              title = " 󰊿 Trans ",
              hl = { link = "Define" },
            },
            input_box_opts = {
              size = "15%",
              win_options = {
                winhighlight = "Normal:Normal,FloatBorder:FloatBorder",
              },
            },
            preview_box_opts = {
              size = "85%",
              win_options = {
                winhighlight = "Normal:Normal,FloatBorder:FloatBorder",
              },
            },
          },
        },

        WordTranslate = {
          handler = tools.flexi_handler,
          prompt = function()
            return string.format [[You are an English vocabulary assistant.

            When the user provides an English word or phrase, output the result strictly in the following Markdown format:

            “<word>” most commonly means <Chinese explanation>. Briefly explain its most common meanings and different usages if necessary.

            - Part of SpeechNoun (n.) / Verb (v.) / Adjective (adj.) / Adverb (adv.), etc.
            - PronunciationUK /.../, US /.../
            - Common Collocations
                - collocation 1 (Chinese meaning)
                - collocation 2 (Chinese meaning)
                - collocation 3 (Chinese meaning)
            - Example SentenceAn easy, natural, and commonly used English sentence. (Chinese translation.)

            Requirements:
            1. Explain the meaning in concise and natural Chinese.
            2. If the word has multiple common parts of speech, list all of them.
            3. Provide accurate British and American pronunciations in IPA.
            4. Include 3–5 high-frequency collocations with Chinese translations.
            5. Provide one simple and practical example sentence with a Chinese translation.
            6. Keep the exact Markdown structure, indentation, and bullet style shown above.
            7. Do not output any additional explanations, notes, or headings outside the template.

            Example input:
            environment

            Example output:
            “environment”最常见的意思是环境，既可指自然生态环境，也可指工作、学习、编程运行这类人为/软件运行环境。
            - 词性名词 (n.)
            - 音标英 /ɪnˈvaɪrənmənt/，美 /ɪnˈvaɪrənmənt/
            - 常见搭配
                - development environment（开发环境）
                - protect the environment（保护环境）
                - working environment（工作环境）
            - 例句：This plugin runs smoothly in my local development environment.（这个插件在我的本地开发环境中运行流畅。）          
            ]]
          end,
          -- prompt = "Translate the following text to English, please only return the translation",
          opts = {
            fetch_key = function() return vim.env.DEEPSEEK_API_KEY end,
            url = "https://api.deepseek.com/chat/completions",
            model = "deepseek-v4-flash",
            enable_thinking = false,
            api_type = "openai",
            -- args = [=[return string.format([[curl %s -N -X POST -H "Content-Type: application/json" -H "Authorization: Bearer %s" -d '%s']], url, DEEPSEEK_API_KEY, vim.fn.json_encode(body))]=],
            exit_on_move = true,
            enter_flexible_window = false,
          },
        },
        CodeExplain = {
          handler = tools.flexi_handler,
          prompt = "Explain the following code, please only return the explanation, and answer in Chinese",
          opts = {
            fetch_key = function() return vim.env.DEEPSEEK_API_KEY end,
            url = "https://api.deepseek.com/chat/completions",
            model = "deepseek-v4-flash",
            enable_thinking = false,
            api_type = "openai",
            enter_flexible_window = true,
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
            model = "deepseek-v4-flash",
            enable_thinking = false,
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
          handler = tools.disposable_ask_handler,
          opts = {
            position = {
              row = 2,
              col = 0,
            },
            title = " Ask ",
            inline_assistant = true,
            language = "Chinese",
            url = "https://api.deepseek.com/chat/completions",
            model = "deepseek-v4-flash",
            enable_thinking = false,
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
        AttachToChat = {
          handler = tools.attach_to_chat_handler,
          opts = {
            is_codeblock = true,
            inline_assistant = true,
            language = "Chinese",
          },
        },
        Completion = {
          handler = tools.completion_handler,
          opts = {
            -------------------------------------------------
            ---                 deepseek
            -------------------------------------------------
            url = "https://api.deepseek.com/beta/completions",
            model = "deepseek-v4-flash",
            enable_thinking = false,
            api_type = "deepseek",
            fetch_key = function() return vim.env.DEEPSEEK_API_KEY end,
            ------------------ end deepseek -----------------

            n_completions = 1,
            context_window = 512,
            max_tokens = 256,
            filetypes = { sh = false },
            default_filetype_enabled = true,
            auto_trigger = true,
            style = "virtual_text", -- nvim-cmp or blink.cmp, virtual_text
            --------------------------------
            ---   just for virtual_text
            --------------------------------
            keymap = {
              toggle = {
                mode = "n",
                keys = "<leader>cp",
              },
              virtual_text = {
                accept = {
                  mode = "i",
                  -- keys = "<C-i>",
                  keys = "<A-a>",
                },
                next = {
                  mode = "i",
                  keys = "<A-n>",
                },
                prev = {
                  mode = "i",
                  keys = "<A-p>",
                },
              },
            },
          },
        },
      },
    }
  end,
  specs = {
    {
      "AstroNvim/astrocore",
      opts = function(_, opts)
        local prefix = "<Leader>A"
        opts.mappings.n[prefix] = { desc = "󰭻 AI" }
        opts.mappings.v[prefix] = { desc = "󰭻 AI" }
        opts.mappings.x[prefix] = { desc = "󰭻 AI" }
        -- opts.mappings.n[prefix .. "c"] = { "<cmd>LLMSessionToggle<cr>", desc = "Toggle chat" }
        opts.mappings.n[prefix .. "g"] = { "<cmd>LLMAppHandler CommitMsg<cr>", desc = "Generate commit message" }
        opts.mappings.n[prefix .. "t"] = { "<cmd>LLMAppHandler Translate<cr>", desc = "AI Translate" }
        -- opts.mappings.n[prefix .. "k"] = { "<cmd>LLMAppHandler Ask<cr>", desc = "Ask llm" }
        -- opts.mappings.n[prefix .. "a"] = { "<cmd>LLMAppHandler AttachToChat<cr>", desc = "Ask (multi-turn)" }
        opts.mappings.x[prefix .. "w"] = { "<cmd>LLMAppHandler WordTranslate<cr>", desc = "Woord translation" }
        -- opts.mappings.v[prefix .. "e"] = { "<cmd>LLMAppHandler CodeExplain<cr>", desc = "Explain selected code" }
        opts.mappings.v[prefix .. "d"] = { "<cmd>LLMAppHandler Docstring<cr>", desc = "Generate docstring" }
        -- opts.mappings.v[prefix .. "k"] = { "<cmd>LLMAppHandler Ask<cr>", desc = "Ask llm" }
        -- opts.mappings.v[prefix .. "a"] = { "<cmd>LLMAppHandler AttachToChat<cr>", desc = "Ask (multi-turn)" }
      end,
    },
    {
      "saghen/blink.cmp",
      optional = true,
      opts = {
        sources = {
          default = { "llm" },
          providers = {
            llm = {
              name = "LLM",
              module = "llm.common.completion.frontends.blink",
              timeout_ms = 10000,
              score_offset = 100,
              async = true,
            },
          },
        },
      },
    },
  },
}
