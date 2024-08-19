return {
  "Mr-LLLLL/interestingwords.nvim",
  event = "VeryLazy",
  config = function()
    require("interestingwords").setup {
      colors = { "#aeee00", "#ff0000", "#0000ff", "#b88823", "#ffa724", "#ff2c4b" },
      search_count = true,
      navigation = true,
      search_key = "<leader>s",
      cancel_search_key = "<esc>",
      color_key = "<leader>k",
      cancel_color_key = "<esc>",
    }
  end,
}
