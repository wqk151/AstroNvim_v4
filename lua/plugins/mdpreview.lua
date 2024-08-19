return {
  "mrjones2014/mdpreview.nvim",
  ft = "markdown", -- you can lazy load on markdown files only
  -- requires the `terminal` filetype to render ASCII color and format codes
  dependencies = { "norcalli/nvim-terminal.lua", config = true },
  config = function()
    require("mdpreview").setup {
      -- specify manually if `glow` is not on `$PATH` or you want to use another CLI, or use different args
      cli_args = {
        "glow",
        -- glow assumes you want no colors if not run in a TTY
        "-s",
        "dark",
        -- let nvim handle word wrapping, disable glow word wrap
        "-w",
        "1",
        -- don't unexpectedly make network connections
        "--local",
      },
      -- enabled on these filetypes
      filetypes = { "markdown", "markdown.pandoc", "markdown.gfm" },
      renderer = {
        -- use the nvim buffer renderer, currently `buffer` is the only available backend
        backend = "buffer",
        -- options for the renderer backend
        opts = {
          -- if you don't want to use a vertical split, create your own window
          -- and return the window ID. May be a function or a number if you already
          -- have the window ID
          winnr = function()
            vim.cmd "vsp"
            return vim.api.nvim_get_current_win()
          end,
          -- options that will be set on the preview window
          win_opts = {
            signcolumn = "no",
            number = false,
            concealcursor = "niv",
            wrap = true,
            linebreak = true,
          },
        },
      },
    }
  end,
}
