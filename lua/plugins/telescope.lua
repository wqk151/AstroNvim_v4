return {
  "nvim-telescope/telescope.nvim",
  dependencies = { -- add a new dependency to telescope that is our new plugin
    "ahmedkhalf/project.nvim",
    {
      "edolphin-ydf/goimpl.nvim",
      dependencies = { "nvim-lua/popup.nvim" },
      after = "telescope.nvim",
    },
    -- {
    --   "nvim-telescope/telescope-media-files.nvim",
    --   dependencies = { "nvim-lua/popup.nvim" },
    --   after = "telescope.nvim",
    -- },
  },
  opts = function(_, opts)
    return require("astrocore").extend_tbl(opts, {
      pickers = {
        find_files = {
          hidden = true,
          find_command = function(cfg)
            local find_command = { "rg", "--files", "--color", "never", "-u" }
            if not cfg.no_ignore then
              vim.list_extend(find_command, {
                "--glob",
                "!**/.git/**",
                "--glob",
                "!cmake_build*",
                "--glob",
                "!cmake-build*",
                "--glob",
                "!CMakeFiles/*",
                "--glob",
                "!__pycache__/*",
                "--glob",
                "!.ccls-cache/*",
                "--glob",
                "!@*",
                "--glob",
                "!build*",
                "--glob",
                "!.*/*",
                "--glob",
                "!*.out",
                "--glob",
                "!*.exe",
                "--glob",
                "!*.png",
                "--glob",
                "!*.jpg",
                "--glob",
                "!*.jpeg",
                "--glob",
                "!*.tif",
                "--glob",
                "!*.tiff",
                "--glob",
                "!*.bmp",
                "--glob",
                "!*.pcd",
                "--glob",
                "!*.zip",
                "--glob",
                "!*.tar",
                "--glob",
                "!*.gz",
                "--glob",
                "!*.rar",
                "--glob",
                "!*.blob",
                "--glob",
                "!*.whl",
                "--glob",
                "!*.pyc",
                "--glob",
                "!*.npy",
                "--glob",
                "!*.so",
                "--glob",
                "!*.dll",
                "--glob",
                "!*.deb",
                "--glob",
                "!*.bag",
                "--glob",
                "!*.mp3",
                "--glob",
                "!*.mp4",
                "--glob",
                "!*.flv",
                "--glob",
                "!*.avi",
                "--glob",
                "!*.wmv",
                "--glob",
                "!*.rmvb",
                "--glob",
                "!*.mov",
              })
            end
            return find_command
          end,
        },
      },
    })
  end,
  config = function(_, opts)
    -- run the core AstroNvim configuration function with the options table
    -- require("configs").telescope_drop(_, opts)

    -- require telescope and load extensions as necessary
    local telescope = require "telescope"

    telescope.load_extension "projects"
    telescope.load_extension "goimpl"
    -- telescope.load_extension "media_files"
  end,
}
