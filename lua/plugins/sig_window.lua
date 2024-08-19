return {
  "erhickey/sig-window-nvim",
  event = "VeryLazy",
  config = function()
    require("sig-window-nvim").setup {
      window_config = function(label, config, width, height, other_labels)
        local r, c = unpack(vim.api.nvim_win_get_cursor(0))
        return {
          relative = "editor",
          anchor = "NE",
          width = width,
          height = height,
          row = r - height - 3,
          col = c,
          focusable = false,
          zindex = config.zindex,
          style = "minimal",
          border = config.border,
        }
      end,
    }
  end,
}
