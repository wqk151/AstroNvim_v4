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
    {
      "nvim-telescope/telescope-live-grep-args.nvim",
      after = "telescope.nvim",
    },
  },
  opts = function(_, opts)
    local actions = require "telescope.actions"
    return require("astrocore").extend_tbl(opts, {
      defaults = {
        -- Default configuration for telescope goes here:
        -- config_key = value,
        mappings = {
          i = {
            -- map actions.which_key to <C-h> (default: <C-/>)
            -- actions.which_key shows the mappings for your picker,
            -- e.g. git_{create, delete, ...}_branch for the git_branches picker
            ["<C-j>"] = actions.move_selection_next,
            ["<Tab>"] = actions.move_selection_next,
            ["<C-k>"] = actions.move_selection_previous,
            ["<S-Tab>"] = actions.move_selection_previous,
            ["<CR>"] = actions.select_default + actions.center,
            ["<Esc>"] = actions.close,
            ["<C-h>"] = "which_key",
            ["<C-p>"] = actions.cycle_history_prev,
            ["<C-n>"] = actions.cycle_history_next,
          },
        },
      },
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
    require("configs").telescope_drop(_, opts)

    -- require telescope and load extensions as necessary
    local telescope = require "telescope"

    telescope.load_extension "projects"
    telescope.load_extension "goimpl"
    telescope.load_extension "live_grep_args"
    -- telescope.load_extension "media_files"
  end,
}
