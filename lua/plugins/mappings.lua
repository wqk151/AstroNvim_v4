return {
  {
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
          -- tables with just a `desc` key will be registered with which-key if it's installed
          -- this is useful for naming menus
          -- ["<Leader>b"] = { desc = "Buffers" },
          -- setting a mapping to false will disable it
          -- ["<C-S>"] = false,
          -- disable Terminal bindings
          ["<C-Q>"] = false,
          ["<C-S>"] = false,
          ["<Leader>n"] = false,
          ["<Leader>tn"] = false,
          ["<Leader>tp"] = false,
          ["<Leader>tt"] = false,
          ["<Leader>tl"] = false,
          -- Go to home and end using capitalized directions
          ["H"] = { "^" },
          ["L"] = { "$" },
          -- Map ; to : and save a million keystrokes
          [";"] = { ":" },
          -- Remove highlights
          ["<esc>"] = { ":noh<cr>" },

          -- Buffer nav with Tab
          ["<Tab>"] = { ":bn<CR>" },
          ["<S-Tab>"] = { ":bp<CR>" },
          -- table buffer navigation
          ["<leader>btn"] = { ":tabnext<CR>" },
          ["<leader>btp"] = { ":tabprevious<CR>" },
          ["<leader>bth"] = { ":tabfirst<CR>" },
          ["<leader>btl"] = { ":tablast<CR>" },

          ["<leader>p"] = { '"+p', desc = "paste from register" },
        },
        x = {
          -- Reselect text after indent/unindent.
          -- also with tab/s-tab
          ["<"] = { "<gv" },
          [">"] = { ">gv" },
          ["<leader>y"] = { '"+y', desc = "copy to register" },
          ["v"] = { function() vim.treesitter.select "parent" end, desc = "init_selection" },
        },
        i = {
          -- 编辑完成后跳出括号
          ["<c-j>"] = { "<Esc>la" },
        },
        c = {
          -- 命令行模式,ctrl - a到行首， -e 到行尾
          ["<c-a>"] = { "<Home>" },
          ["<c-e>"] = { "<End>" },
        },
        t = {},
      },
    },
  },
  {
    "AstroNvim/astrolsp",
    ---@type AstroLSPOpts
    opts = {
      mappings = {
        n = {
          ["<leader>la"] = { function() require("actions-preview").code_actions() end, desc = "Preview Code Actions" },
          ["grr"] = { function() Snacks.picker.lsp_references() end, desc = "References" },
          ["grt"] = { function() Snacks.picker.lsp_type_definitions() end, desc = "Goto T[y]pe Definition" },
          ["gri"] = { function() Snacks.picker.lsp_implementations() end, desc = "Goto Implementation" },
        },
      },
    },
  },
}
