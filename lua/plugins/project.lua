return {
  "ahmedkhalf/project.nvim",
  dependencies = {
    "nvim-telescope/telescope.nvim",
  },
  lazy = false,
  config = function()
    require("project_nvim").setup {
      ignore_lsp = { "lua_ls", "julials" },
      patterns = {
        ".git",
        "_darcs",
        ".hg",
        ".bzr",
        ".svn",
        "Makefile",
        "package.json",
        "CmakeLists.txt",
        "compile_commands.json",
        ".catkin_workspace",
      },
      exclude_dirs = { "build/*", "cmake_build/*" },
      silent_chdir = true,
      manual_mode = true,
      scope_chdir = "tab",
    }
  end,
}
