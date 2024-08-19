return {
  "0x00-ketsu/markdown-preview.nvim",
  ft = { "md", "markdown", "mkd", "mkdn", "mdwn", "mdown", "mdtxt", "mdtext", "rmd", "wiki" },
  config = function()
    require("markdown-preview").setup {
      -- Markdown preview term
      term = {
        -- reload term when rendered markdown file changed
        reload = {
          enable = true,
          events = { "InsertLeave", "TextChanged" },
        },
        direction = "vertical", -- choices: vertical / horizontal
        keys = {
          close = { "q", "<Esc>" },
          refresh = "r",
        },
      },
    }
  end,
}
