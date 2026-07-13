return {
  "folke/flash.nvim",
  event = "VeryLazy",
  ---@type Flash.Config
  opts = {},
  -- stylua: ignore
  keys = {
    -- 在屏幕上快速跳转到任意位置。
    { "s", mode = { "n", "x", "o" }, function() require("flash").jump() end, desc = "Flash" },
    -- 不是按字符跳，而是按 Treesitter 节点跳。
    { "S", mode = { "n", "o", "x" }, function() require("flash").treesitter() end, desc = "Flash Treesitter" },
    -- 在远处执行 operator。如直接复制/删除远处的内容
    { "r", mode = "o", function() require("flash").remote() end, desc = "Remote Flash" },
    -- 利用 Treesitter 选择语法节点
    { "R", mode = { "o", "x" }, function() require("flash").treesitter_search() end, desc = "Treesitter Search" },
    { "<c-s>", mode = { "c" }, function() require("flash").toggle() end, desc = "Toggle Flash Search" },
  },
}
