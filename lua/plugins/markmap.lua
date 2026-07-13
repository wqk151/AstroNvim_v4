--  [markdown markmap]
--  https://github.com/Zeioth/markmap.nvim
local prefix = "<Leader>m"
return {
  "Zeioth/markmap.nvim",
  build = "yarn global add markmap-cli",
  cmd = { "MarkmapOpen", "MarkmapSave", "MarkmapWatch", "MarkmapWatchStop" },
  opts = {
    html_output = "/tmp/markmap.html", -- (default) Setting a empty string "" here means: [Current buffer path].html
    hide_toolbar = false, -- (default)
    grace_period = 3600000, -- (default) Stops markmap watch after 60 minutes. Set it to 0 to disable the grace_period.
  },
  -- config = function(_, opts) require("markmap").setup(opts) end,
  specs = {
    {
      "AstroNvim/astrocore",
      opts = {
        mappings = {
          n = {
            [prefix] = { name = " Markdown" },
            [prefix .. "m"] = { "<cmd>RenderMarkdown toggle<cr>", desc = "Toggle markdown render" },
            [prefix .. "o"] = { "<cmd>MarkmapOpen<cr>", desc = "Open markmap" },
            [prefix .. "w"] = { "<cmd>MarkmapWatch<cr>", desc = "Open markmap and watch for changes" },
          },
        },
      },
    },
  },
}
