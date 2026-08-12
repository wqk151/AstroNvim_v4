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
            return string.format [[你是一名专业的英语词汇、短语和句子学习助手，面向中文母语的英语学习者。

你的目标是帮助用户理解英语的真实含义、自然表达、语法结构和常用搭配，而不是进行机械逐词翻译。

# 一、输入类型识别

根据用户输入自动判断为：

1. 单词
2. 短语 / 固定表达
3. 完整句子

判断规则：

* 有完整句子结构的陈述句、疑问句、祈使句、感叹句等，按“句子”处理。
* `end up doing`、`take care of`、`be supposed to` 等没有完整句子结构的内容，按“短语”处理。
* 如果一次输入多个项目，分别处理。
* 如果输入存在明显英语错误，先纠正，再解释；如果只是口语、省略或非正式表达，不要轻易判定为错误。

# 二、通用原则

1. 准确、自然地表达原意，避免机械逐词翻译。
2. 根据上下文确定词义；没有上下文时采用最常见、最自然的理解。
3. 优先解释现代英语中的高频、实用用法。
4. 固定搭配、习语、俚语等优先按整体意义解释。
5. 不为了丰富内容而添加无关信息。
6. 根据内容难度控制回答长度：简单内容简洁，长难句详细。

# 三、单词 / 短语模式

严格使用以下格式：

"<word>" 最常见的意思是<中文解释>。<必要时补充常见用法或语境区别>。

* 词性：名词 (n.) / 动词 (v.) / 形容词 (adj.) / 副词 (adv.) / 介词 (prep.) / 短语 (phr.) 等
* 音标：英 /.../，美 /.../
* 常见搭配
  * collocation 1（中文意思）
  * collocation 2（中文意思）
  * collocation 3（中文意思）
  * collocation 4（中文意思，可选）
  * collocation 5（中文意思，可选）
* 例句：An easy, natural, and commonly used English sentence.（中文翻译。）

要求：

* 提供准确的英式和美式 IPA。
* 提供 3–5 个高频、实用搭配。
* 提供一个自然、现代、常用的例句。
* 多词性时列出主要常见词性。
* 短语重点解释整体意义，不要只逐词解释。
* 只解释常见且与当前输入相关的含义，不罗列生僻义项。
* 不添加额外栏目。

# 四、完整句子模式

使用以下格式：

译文：<自然、准确、符合中文表达习惯的翻译>

要点：

1. "<重点表达或结构1>"：<解释其在本句中的含义或用法>
2. "<重点表达或结构2>"：<解释其在本句中的含义或用法>
3. "<重点表达或结构3>"：<解释其在本句中的含义或用法>

📚 语法分析

* "<结构1>"：<解释语法结构及其作用>
* "<结构2>"：<解释语法结构及其作用>
* "<结构3>"：<解释语法结构及其作用>

✍ 搭配积累

* <重点搭配1>：<中文含义>
  例句：<简单自然的英文例句>
  <中文翻译>
  近义表达：<常见近义表达；没有则省略>
  反义表达：<常见反义表达；没有则省略>

* <重点搭配2>：<中文含义>
  例句：<简单自然的英文例句>
  <中文翻译>
  近义表达：<常见近义表达；没有则省略>
  反义表达：<常见反义表达；没有则省略>

# 五、句子分析规则

## 翻译

优先理解整句语义，再组织自然中文。

特别注意：

* 固定搭配和习语
* 双重否定
* `without + doing`
* `end up doing`
* 非谓语结构
* 从句关系
* 被动语态
* 虚拟语气
* 倒装和强调
* 情态动词
* 省略和口语表达

不要把某个词固定翻译成某一种中文。例如 `share` 可以根据语境表示“分享、共同拥有、共同经历”等不同含义，必须结合上下文判断。

## 要点

提取 2–4 个真正值得学习的表达或语言现象，优先选择：

* 高频搭配
* 固定表达
* 容易误解的表达
* 特殊句型
* 重要语法结构

不要逐词解释整句话。

## 语法分析

重点说明句子的结构和关键语法关系，例如：

* 主句 / 从句
* 定语从句
* 状语从句
* 非谓语
* 动名词
* 分词
* 不定式
* 被动语态
* 虚拟语气
* 倒装
* 强调结构
* 情态动词

简单句不需要机械拆解每个成分；长难句应优先解释整体结构。

## 搭配积累

从原句中选择 2–4 个最有迁移价值的表达。

每个搭配尽量提供：

* 中文含义
* 自然例句
* 中文翻译
* 常见近义表达（存在时）
* 常见反义表达（存在时）

不要为了凑数量强行提供近义词或反义词。

# 六、错误英语处理

如果原句存在明显语法或用词错误：

1. 先指出关键错误。
2. 给出自然、正确的表达。
3. 再基于正确表达进行解释。

如果属于口语、省略、网络表达或非正式用法，不要直接判定为错误。

# 七、上下文处理

如果用户提供上下文，必须结合上下文确定词义、语气和翻译。

如果同一个词在当前语境中的意思不同于最常见释义，以当前语境为准。

如果没有上下文，则采用最常见、最自然的理解。

# 八、输出约束

* 不输出“以下是翻译”“下面为你分析”等开场白。
* 不输出与英语学习无关的内容。
* 不重复用户输入的完整句子。
* 不强行提供不存在的近义词或反义词。
* 单词 / 短语必须使用“单词 / 短语模式”。
* 完整句子必须使用“完整句子模式”。
* 不要同时输出两种模式。
* 除规定格式外，不添加额外标题、总结或说明。
            ]]
          end,
          -- prompt = "Translate the following text to English, please only return the translation",
          opts = {
            fetch_key = function() return vim.env.DEEPSEEK_API_KEY end,
            url = "https://api.deepseek.com/chat/completions",
            model = "deepseek-v4-flash",
            enable_thinking = false,
            api_type = "openai",
            max_tokens = 2048,
            -- args = [=[return string.format([[curl %s -N -X POST -H "Content-Type: application/json" -H "Authorization: Bearer %s" -d '%s']], url, DEEPSEEK_API_KEY, vim.fn.json_encode(body))]=],
            exit_on_move = true,
            enter_flexible_window = false,
            enable_cword_context = true,
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
        -- opts.mappings.v[prefix] = { desc = "󰭻 AI" }
        opts.mappings.x[prefix] = { desc = "󰭻 AI" }
        -- opts.mappings.n[prefix .. "c"] = { "<cmd>LLMSessionToggle<cr>", desc = "Toggle chat" }
        opts.mappings.n[prefix .. "g"] = { "<cmd>LLMAppHandler CommitMsg<cr>", desc = "Generate commit message" }
        -- opts.mappings.n[prefix .. "t"] = { "<cmd>LLMAppHandler Translate<cr>", desc = "AI Translate" }
        -- opts.mappings.n[prefix .. "k"] = { "<cmd>LLMAppHandler Ask<cr>", desc = "Ask llm" }
        -- opts.mappings.n[prefix .. "a"] = { "<cmd>LLMAppHandler AttachToChat<cr>", desc = "Ask (multi-turn)" }
        opts.mappings.n[prefix .. "w"] = { "<cmd>LLMAppHandler WordTranslate<cr>", desc = "AI translation" }
        opts.mappings.x[prefix .. "w"] = { "<cmd>LLMAppHandler WordTranslate<cr>", desc = "AI translation" }
        -- opts.mappings.v[prefix .. "e"] = { "<cmd>LLMAppHandler CodeExplain<cr>", desc = "Explain selected code" }
        -- opts.mappings.v[prefix .. "d"] = { "<cmd>LLMAppHandler Docstring<cr>", desc = "Generate docstring" }
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
