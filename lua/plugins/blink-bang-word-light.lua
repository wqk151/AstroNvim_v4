return {
  "mei28/blink-bang-word-light.nvim",
  event = { "VeryLazy" },
  opts = {
    max_word_length = 100, -- if cursorword length > max_word_length then not highlight
    min_word_length = 2, -- if cursorword length < min_word_length then not highlight
    excluded = {
      filetypes = {
        "TelescopePrompt",
      },
    },
    highlight = {
      underline = true,
      guifg = "#05ffff", -- Foreground color
      guibg = "#3f3e48", -- Background color
    },
    enabled = true,
  },
}
