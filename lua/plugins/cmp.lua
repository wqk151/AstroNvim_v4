-- https://github.com/Bowser1704/dotfiles/blob/master/nvim/lua/plugins/lsp/cmp.lua
return {
  "hrsh7th/nvim-cmp",
  dependencies = {
    { "hrsh7th/cmp-nvim-lsp-signature-help" },
    "hrsh7th/cmp-nvim-lsp",
    "hrsh7th/cmp-buffer",
    "hrsh7th/cmp-path",
    "hrsh7th/cmp-emoji",
    "onsails/lspkind.nvim",
    {
      "Exafunction/codeium.nvim",
      -- commit = "b1ff0d6c993e3d87a4362d2ccd6c660f7444599f", -- for first installtion
      dependencies = {
        "nvim-lua/plenary.nvim",
        "hrsh7th/nvim-cmp",
      },
      cmd = "Codeium",
      build = ":Codeium auth",
      config = function() require("codeium").setup {} end,
    },
  },
  opts = function(_, opts)
    local cmp = require "cmp"
    local compare = require "cmp.config.compare"
    local luasnip = require "luasnip"
    local neogen = require "neogen"

    local function has_words_before()
      local line, col = unpack(vim.api.nvim_win_get_cursor(0))
      return col ~= 0 and vim.api.nvim_buf_get_lines(0, line - 1, line, true)[1]:sub(col, col):match "%s" == nil
    end

    local toCamelCase = function(str)
      return str:gsub("(%a)(%w*)", function(first, rest) return first:upper() .. rest:lower() end)
    end

    return require("astrocore").extend_tbl(opts, {
      window = {
        completion = {
          border = "rounded",
          col_offset = -1,
          side_padding = 0,
        },
      },
      sources = cmp.config.sources {
        { name = "nvim_lsp",               priority = 1000, keyword_length = 1 },
        { name = "codeium",                priority = 900,  keyword_length = 2 },
        { name = "luasnip",                priority = 750,  keyword_length = 2 },
        { name = "buffer",                 priority = 300,  keyword_length = 2 },
        { name = "path",                   priority = 250 },
        { name = "nvim_lsp_signature_help" },
      },
      formatting = {
        format = require("lspkind").cmp_format {
          mode = "symbol_text",
          maxwidth = 50,
          ellipsis_char = "...",
          symbol_map = { Codeium = "" },
          menu = setmetatable({
            nvim_lsp = "[LSP]",
            luasnip = "[Snip]",
          }, {
            -- convert other source to camel case use metatable
            __index = function(obj, key)
              rawset(obj, key, "[" .. toCamelCase(key) .. "]")
              return rawget(obj, key)
            end,
          }),
        },
      },
      sorting = {
        comparators = {
          compare.locality,
          compare.recently_used,
          compare.score,
          compare.offset,
          compare.order,
        },
      },

      mapping = {
        ["<Up>"] = cmp.mapping.select_prev_item { behavior = cmp.SelectBehavior.Select },
        ["<Down>"] = cmp.mapping.select_next_item { behavior = cmp.SelectBehavior.Select },
        ["<C-p>"] = cmp.mapping.select_prev_item { behavior = cmp.SelectBehavior.Insert },
        ["<C-n>"] = cmp.mapping.select_next_item { behavior = cmp.SelectBehavior.Insert },
        ["<C-k>"] = cmp.mapping.select_prev_item { behavior = cmp.SelectBehavior.Insert },
        ["<C-j>"] = cmp.mapping.select_next_item { behavior = cmp.SelectBehavior.Insert },
        ["<C-u>"] = cmp.mapping(cmp.mapping.scroll_docs(-4), { "i", "c" }),
        ["<C-d>"] = cmp.mapping(cmp.mapping.scroll_docs(4), { "i", "c" }),
        ["<C-Space>"] = cmp.mapping(cmp.mapping.complete(), { "i", "c" }),
        ["<C-y>"] = cmp.config.disable,
        ["<C-e>"] = cmp.mapping { i = cmp.mapping.abort(), c = cmp.mapping.close() },
        ["<CR>"] = cmp.mapping.confirm { select = false },
        ["<Tab>"] = cmp.mapping(function(fallback)
          if cmp.visible() then
            cmp.select_next_item()
          elseif luasnip.expand_or_jumpable() then
            luasnip.expand_or_jump()
          elseif neogen.jumpable() then
            neogen.jump_next()
          elseif has_words_before() then
            cmp.complete()
          else
            fallback()
          end
        end, { "i", "s" }),
        ["<S-Tab>"] = cmp.mapping(function(fallback)
          if cmp.visible() then
            cmp.select_prev_item()
          elseif luasnip.jumpable(-1) then
            luasnip.jump(-1)
          elseif neogen.jumpable(-1) then
            neogen.jump_prev()
          else
            fallback()
          end
        end, { "i", "s" }),
      },
      experimental = { ghost_text = true },
    })
  end,
}
