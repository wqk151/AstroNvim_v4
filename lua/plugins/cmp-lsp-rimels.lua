return {
  "liubianshi/cmp-lsp-rimels",
  branch = "blink.cmp",
  config = function()
    vim.system({ "rime_ls", "--listen", "127.0.0.1:9257" }, { detach = true })
    require("rimels").setup {
      cmd = vim.lsp.rpc.connect("127.0.0.1", 9257),
    }
  end,
}
