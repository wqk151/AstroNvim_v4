-- https://github.com/linkarzu/dotfiles-latest/blob/main/neovim/neobean/lua/plugins/render-markdown.lua
local color1_bg = "#ee99a0"
local color2_bg = "#8bd5ca"
local color3_bg = "#a6da95"
local color4_bg = "#cba6f7"
local color5_bg = "#eed49f"
local color6_bg = "#7dc4e4"
local color_fg = "#323449"
-- Heading colors (when not hovered over), extends through the entire line
vim.cmd(string.format([[highlight Headline1Bg guifg=%s guibg=%s]], color_fg, color1_bg))
vim.cmd(string.format([[highlight Headline2Bg guifg=%s guibg=%s]], color_fg, color2_bg))
vim.cmd(string.format([[highlight Headline3Bg guifg=%s guibg=%s]], color_fg, color3_bg))
vim.cmd(string.format([[highlight Headline4Bg guifg=%s guibg=%s]], color_fg, color4_bg))
vim.cmd(string.format([[highlight Headline5Bg guifg=%s guibg=%s]], color_fg, color5_bg))
vim.cmd(string.format([[highlight Headline6Bg guifg=%s guibg=%s]], color_fg, color6_bg))

-- Highlight for the heading and sign icons (symbol on the left)
-- I have the sign disabled for now, so this makes no effect
vim.cmd(string.format([[highlight Headline1Fg cterm=bold gui=bold guifg=%s]], color1_bg))
vim.cmd(string.format([[highlight Headline2Fg cterm=bold gui=bold guifg=%s]], color2_bg))
vim.cmd(string.format([[highlight Headline3Fg cterm=bold gui=bold guifg=%s]], color3_bg))
vim.cmd(string.format([[highlight Headline4Fg cterm=bold gui=bold guifg=%s]], color4_bg))
vim.cmd(string.format([[highlight Headline5Fg cterm=bold gui=bold guifg=%s]], color5_bg))
vim.cmd(string.format([[highlight Headline6Fg cterm=bold gui=bold guifg=%s]], color6_bg))
return {
  "MeanderingProgrammer/render-markdown.nvim",
  cmd = "RenderMarkdown",
  ft = { "markdown", "norg", "rmd", "org" },
  opts = {},
  -- dependencies = { 'nvim-treesitter/nvim-treesitter', 'echasnovski/mini.nvim' }, -- if you use the mini.nvim suite
  -- dependencies = { 'nvim-treesitter/nvim-treesitter', 'echasnovski/mini.icons' }, -- if you use standalone mini plugins
  dependencies = { "nvim-treesitter/nvim-treesitter", "nvim-tree/nvim-web-devicons" }, -- if you prefer nvim-web-devicons

  config = function()
    require("render-markdown").setup {
      enabled = true,
      render_modes = { "n", "v", "i", "c", "s" },
      heading = {
        -- position = "inline",
        -- border = true,
        -- backgrounds = {
        --   "Headline1Bg",
        --   "Headline2Bg",
        --   "Headline3Bg",
        --   "Headline4Bg",
        --   "Headline5Bg",
        --   "Headline6Bg",
        -- },
      },
    }
  end,
}
