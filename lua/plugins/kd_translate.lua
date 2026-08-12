return {
  "celeste3z/kd-translator.nvim",
  -- 提供 opts 触发 lazy.nvim 默认 config → require("kd-translator").setup(opts)
  -- 否则 <Plug> 映射和 :KdTranslator 命令不会创建
  opts = {},
  keys = {
    -- 操作符,必须跟一个动作/文本对象才有意义:gtiw(词)、gtip(段)、gta((括号块)、gtG(全文)……
    -- 支持vim-repeat
    { "gt", "<Plug>(kd-translator-operator)", desc = "Kd Translate Operator", mode = "n" },
    { "gt", "<Plug>(kd-translator-visual)", desc = "Kd Translate Visual", mode = "x" },
    { "<Leader>tw", "<Plug>(kd-translator-operator)iw", desc = "Kd Translate Word", mode = "n" },
    { "<Leader>tp", "<Plug>(kd-translator-operator)ip", desc = "Kd Translate Paragraph", mode = "n" },
    { ",t", ":KdTranslator<CR>", desc = "Kd Translate Word", mode = "n" },
    { ",t", ":KdTranslator<CR>", desc = "Kd Translate Visual", mode = "x" },
  },
}
