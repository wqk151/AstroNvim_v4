return {
  "nvim-telescope/telescope.nvim",
  dependencies = {
    "nvim-lua/plenary.nvim",
    {
      "edolphin-ydf/goimpl.nvim",
      dependencies = { "nvim-lua/popup.nvim" },
      after = "telescope.nvim",
    },
    {
      "nvim-telescope/telescope-live-grep-args.nvim",
      after = "telescope.nvim",
    },
  },
  config = function()
    local actions = require "telescope.actions"
    local get_icon = require("astroui").get_icon
    require("telescope").setup {

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
        prompt_prefix = string.format("%s ", get_icon "Search"),
        selection_caret = string.format("%s ", get_icon "Selected"),
        path_display = { "truncate" },
        sorting_strategy = "ascending",
        layout_config = {
          horizontal = {
            prompt_position = "top",
            preview_width = 0.55,
          },
          vertical = {
            mirror = false,
          },
          width = 0.87,
          height = 0.80,
          preview_cutoff = 120,
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
      extensions = {
        -- Your extension configuration goes here:
        -- extension_name = {
        --   extension_config_key = value,
        -- }
        -- please take a look at the readme of the extension you want to configure
        goimpl = {},
        live_grep_args = {},
      },
    }
  end,
}
