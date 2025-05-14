return {
  "saghen/blink.cmp",
  opts = {
    completion = {
      -- 示例：使用'prefix'对于'foo_|_bar'单词将匹配'foo_'(光标前面的部分),使用'full'将匹配'foo__bar'(整个单词)
      keyword = { range = "full" },
      -- Don't select by default, auto insert on selection
      list = { selection = { preselect = false, auto_insert = true } },
      menu = {
        -- Don't automatically show the completion menu
        -- auto_show = true,
        -- border = "rounded",
        -- nvim-cmp style menu
        draw = {
          columns = {
            { "label", "label_description", gap = 1 },
            { "kind_icon", "kind", "source_name" },
          },
          components = {
            label = {
              text = function(ctx) return require("colorful-menu").blink_components_text(ctx) end,
              highlight = function(ctx) return require("colorful-menu").blink_components_highlight(ctx) end,
            },
            source_name = {
              width = { max = 30 },
              text = function(ctx) return ctx.source_name end,
              highlight = "BlinkCmpSource",
            },
          },
        },
      },
      -- Display a preview of the selected item on the current line
      ghost_text = { enabled = true, show_with_selection = true },
    },
    sources = {
      providers = {
        lsp = {
          enabled = true,
          transform_items = function(_, items)
            -- the default transformer will do this
            for _, item in ipairs(items) do
              if item.kind == require("blink.cmp.types").CompletionItemKind.Snippet then
                item.score_offset = item.score_offset - 3
              end
              if
                item.kind == require("blink.cmp.types").CompletionItemKind.Text
                and item.source_id == "lsp"
                and vim.lsp.get_client_by_id(item.client_id).name == "rime_ls"
              then
                item.score_offset = item.score_offset - 3
              end
            end
            -- you can define your own filter for rime item
            return items
          end,
        },
      },
    },
    -- 指定文件类型启用/禁用
    enabled = function()
      return not vim.tbl_contains({
        -- "lua",
        -- "markdown"
      }, vim.bo.filetype) and vim.bo.buftype ~= "prompt" and vim.b.completion ~= false
    end,
  },
}
