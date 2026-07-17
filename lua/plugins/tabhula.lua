return {
  "lilibyte/tabhula.nvim",
  event = "InsertEnter",
  opts = {
    tabkey = "<C-l>",
    backward_tabkey = "<C-h>",
    evil_tabkey = "<M-Tab>",
    evil_backward_tabkey = "<M-S-Tab>",
    completion = nil,
    range = nil,
    forward_characters = {
      [")"] = function() return 1 end,
      ["]"] = function() return 1 end,
      ["}"] = function() return 1 end,
      ['"'] = function() return 1 end,
      ["'"] = function() return 1 end,
      ["`"] = function() return 1 end,
    },
    backward_characters = {
      ["("] = function() return 1 end,
      ["["] = function() return 1 end,
      ["{"] = function() return 1 end,
      ['"'] = function() return 1 end,
      ["'"] = function() return 1 end,
      ["`"] = function() return 1 end,
    },
  },
}
