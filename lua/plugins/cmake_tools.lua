return {
  "Civitasv/cmake-tools.nvim",
  config = function()
    require("cmake-tools").setup {
      cmake_build_directory = "cmake_build/${variant:buildType}", -- this is used to specify generate directory for cmake, allows macro expansion, relative to vim.loop.cwd()
    }
  end,
}
