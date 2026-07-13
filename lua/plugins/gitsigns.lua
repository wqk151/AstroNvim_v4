return {
  "lewis6991/gitsigns.nvim",
  event = "User AstroGitFile",
  opts = function(_, opts)
    -- 保留 AstroNvim 原来的 on_attach
    local old_on_attach = opts.on_attach

    opts.signs = {
      add = { text = "+" },
      change = { text = "~" },
      delete = { text = "_" },
      changedelete = { text = "║" },
      topdelete = { text = "‾" },
      untracked = { text = "┆" },
    }

    opts.signs_staged = {
      add = { text = "+" },
      change = { text = "~" },
      delete = { text = "_" },
      changedelete = { text = "║" },
      topdelete = { text = "‾" },
      untracked = { text = "┆" },
    }

    -- 覆盖 on_attach
    opts.on_attach = function(bufnr)
      -- 先执行 AstroNvim 默认配置
      if old_on_attach then old_on_attach(bufnr) end

      -- 覆盖 <Leader>gp
      vim.keymap.set("n", "<Leader>gp", function() require("gitsigns").preview_hunk() end, {
        buffer = bufnr,
        desc = "Preview Git hunk",
      })
    end
  end,
}
