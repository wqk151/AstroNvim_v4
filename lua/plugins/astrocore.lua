-- if true then return {} end -- WARN: REMOVE THIS LINE TO ACTIVATE THIS FILE

-- AstroCore provides a central place to modify mappings, vim options, autocommands, and more!
-- Configuration documentation can be found with `:h astrocore`
-- NOTE: We highly recommend setting up the Lua Language Server (`:LspInstall lua_ls`)
--       as this provides autocomplete and documentation while editing
local configs = require "configs"
local sections = {
  z = { desc = " Zettelkasten" },
  x = { desc = " Trouble" },
  m = { desc = " Markdown" },
  n = { desc = "󰞋 Noegen" },
  r = { desc = " Run" },
}

---@type LazySpec
return {
  "AstroNvim/astrocore",
  ---@type AstroCoreOpts
  opts = {
    -- Configure core features of AstroNvim
    features = {
      large_buf = { size = 1024 * 256, lines = 10000 }, -- set global limits for large files for disabling features like treesitter
      autopairs = true, -- enable autopairs at start
      cmp = true, -- enable completion at start
      diagnostics_mode = 3, -- diagnostic mode on start (0 = off, 1 = no signs/virtual text, 2 = no virtual text, 3 = on)
      highlighturl = true, -- highlight URLs at start
      notifications = true, -- enable notifications at start
    },
    -- Diagnostics configuration (for vim.diagnostics.config({...})) when diagnostics are on
    diagnostics = {
      virtual_text = true,
      underline = true,
    },
    -- vim options can be configured here
    options = {
      opt = { -- vim.opt.<key>
        relativenumber = true, -- sets vim.opt.relativenumber
        number = true, -- sets vim.opt.number
        spell = false, -- sets vim.opt.spell
        signcolumn = "yes", -- sets vim.opt.signcolumn to yes
        wrap = true, -- sets vim.opt.wrap
        clipboard = "",
        showbreak = "↪ ",
      },
      o = {
        cursorline = true,
        cursorcolumn = true,
        -- background = "dark", // terminal是浅色主题时打开
        -- mouse = "",
      },

      g = { -- vim.g.<key>
        -- configure global vim variables (vim.g)
        -- NOTE: `mapleader` and `maplocalleader` must be set in the AstroNvim opts or before `lazy.setup`
        -- This can be found in the `lua/lazy_setup.lua` file
      },
    },
    -- Mappings can be configured through AstroCore as well.
    -- NOTE: keycodes follow the casing in the vimdocs. For example, `<Leader>` must be capitalized
    mappings = {
      -- first key is the mode
      n = {
        -- second key is the lefthand side of the map

        -- navigate buffer tabs
        ["]b"] = { function() require("astrocore.buffer").nav(vim.v.count1) end, desc = "Next buffer" },
        ["[b"] = { function() require("astrocore.buffer").nav(-vim.v.count1) end, desc = "Previous buffer" },

        -- mappings seen under group name "Buffer"
        ["<Leader>bd"] = {
          function()
            require("astroui.status.heirline").buffer_picker(
              function(bufnr) require("astrocore.buffer").close(bufnr) end
            )
          end,
          desc = "Close buffer from tabline",
        },
        -- tables with just a `desc` key will be registered with which-key if it's installed
        -- this is useful for naming menus
        -- ["<Leader>b"] = { desc = "Buffers" },
        -- setting a mapping to false will disable it
        -- ["<C-S>"] = false,
        -- disable Terminal bindings
        ["<leader>gg"] = false,
        ["<leader>tl"] = false,
        ["<leader>tn"] = false,
        ["<leader>tu"] = false,
        ["<leader>tt"] = false,
        ["<leader>tp"] = false,
        -- ["<leader>n"] = false,
        -- Go to home and end using capitalized directions
        ["H"] = { "^" },
        ["L"] = { "$" },
        -- Map ; to : and save a million keystrokes
        [";"] = { ":" },
        -- Buffer nav with Tab
        ["<Tab>"] = { ":bn<CR>" },
        ["<S-Tab>"] = { ":bp<CR>" },
        -- table buffer navigation
        ["<leader>btn"] = { ":tabnext<CR>" },
        ["<leader>btp"] = { ":tabprevious<CR>" },
        ["<leader>bth"] = { ":tabfirst<CR>" },
        ["<leader>btl"] = { ":tablast<CR>" },
        ["<leader>p"] = { '"+p', desc = "paste from register" },
        -- Hop
        ["<leader>jl"] = { "<cmd>HopLine<cr>", desc = "Line" },
        ["<leader>jw"] = { "<cmd>HopWord<cr>", desc = "Word" },
        -- telekasten.nvim
        ["<leader>z"] = sections.z,
        ["<leader>zf"] = { "<cmd>Telekasten find_notes<CR>", desc = "Find notes by title (filename)" },
        ["<leader>zg"] = { "<cmd>Telekasten search_notes<CR>", desc = "Search (grep) in all notes" },
        ["<leader>zr"] = {
          "<cmd>Telekasten rename_note<CR>",
          desc = "Rename current note and update the links pointing to it",
        },
        ["<leader>zd"] = { "<cmd>Telekasten goto_today<CR>", desc = "Open today's daily note" },
        ["<leader>zz"] = { "<cmd>Telekasten follow_link<CR>", desc = "Follow the link under the cursor" },
        ["<leader>zn"] = { "<cmd>Telekasten new_note<CR>", desc = "Create a new note, prompts for title" },
        ["<leader>zc"] = { "<cmd>Telekasten show_calendar<CR>", desc = "Show the calendar" },
        ["<leader>zb"] = { "<cmd>Telekasten show_backlinks<CR>", desc = "Show all notes linking to the current one" },
        ["<leader>zt"] = { "<cmd>Telekasten show_tags<CR>", desc = "brings up the tag list" },
        ["<leader>zi"] = {
          "<cmd>Telekasten paste_img_and_link<CR>",
          desc = "Paste an image from the clipboard into a file and inserts a link to it",
        },
        ["<leader>zI"] = {
          "<cmd>Telekasten insert_img_link<CR>",
          desc = "Browse images/media files and insert a link to the selected one",
        },

        -- code runner
        ["<leader>r"] = sections.r,
        ["<leader>rr"] = { "<cmd>RunCode<cr>", desc = "Run Code file" },
        ["<leader>rb"] = { "<cmd>MdEval<cr>", desc = "Run C++ Code block in Markdown" },

        -- view markdown
        ["<leader>m"] = sections.m,
        ["<leader>mp"] = { "<cmd>Mdpreview<cr>", desc = "Markdown view in a vertical split" },
        ["<leader>mb"] = { "<cmd>MdpreviewCurrent<cr>", desc = "Markdown view in the current window" },

        -- todo-comments
        ["<leader>fT"] = { "<cmd>TodoTelescope<cr>", desc = "Find TODOs in wrokspace" },

        -- projects
        ["<leader>fp"] = { "<cmd>Telescope projects<cr>", desc = "Search projects" },

        -- remap <leader>ll to Search symbols
        ["<leader>ll"] = { function() require("telescope.builtin").lsp_document_symbols() end, desc = "Search symbols" },

        -- goimpl
        ["<leader>fi"] = { "<cmd>Telescope goimpl<CR>", desc = "Search GoImpl" },

        -- noegen
        ["<leader>n"] = sections.n,
        ["<Leader>nf"] = { "<cmd>Neogen func<CR>", desc = "Autodocstring func" },
        ["<Leader>nc"] = { "<cmd>Neogen class<CR>", desc = "Autodocstring class" },

        -- Trouble
        ["<leader>x"] = sections.x,
        ["<leader>xx"] = { "<cmd>TroubleToggle document_diagnostics<cr>", desc = "Document Diagnostics (Trouble)" },
        ["<leader>xX"] = { "<cmd>TroubleToggle workspace_diagnostics<cr>", desc = "Workspace Diagnostics (Trouble)" },
        ["<leader>xl"] = { "<cmd>TroubleToggle loclist<cr>", desc = "Location List (Trouble)" },
        ["<leader>xq"] = { "<cmd>TroubleToggle quickfix<cr>", desc = "Quickfix List (Trouble)" },
        ["<leader>xT"] = { "<cmd>TodoTrouble<cr>", desc = "TODOs (Trouble)" },

        -- terminal
        ["<leader>ti"] = {
          function() configs.toggle_term_cmd "ipython" end,
          desc = "ToggleTerm ipython",
        },
        ["<leader>tj"] = {
          function() configs.toggle_term_cmd "joshuto" end,
          desc = "ToggleTerm ipython",
        },
      },
      v = {
        -- Reselect text after indent/unindent.
        -- also with tab/s-tab
        ["<"] = { "<gv" },
        [">"] = { ">gv" },
        ["<leader>y"] = { '"+y', desc = "copy to register" },
      },
      i = {
        -- 编辑完成后跳出括号
        ["<c-j>"] = { "<Esc>la" },
        -- Call insert link automatically when we start typing a link
        ["[["] = { "<cmd>Telekasten insert_link<CR>", desc = "Insert a link to a note" },
      },
      c = {
        -- 命令行模式,ctrl - a到行首， -e 到行尾
        ["<c-a>"] = { "<Home>" },
        ["<c-e>"] = { "<End>" },
      },
      t = {
        -- terminal mappings
        ["<C-q>"] = { "<C-\\><C-n>", desc = "Terminal normal mode" },
        ["<esc><esc>"] = { "<C-\\><C-n>:q<cr>", desc = "Terminal quit" },
      },
    },
  },
}
