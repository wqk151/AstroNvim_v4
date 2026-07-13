local prefix = "<leader>z"
local home = vim.fn.expand "~/data/notes/zettelkasten"
return {
  "nvim-telekasten/telekasten.nvim",
  -- commit = "4a5e57eee9c5154ed77423bb7fa6619fdb0784cd",
  dependencies = { "nvim-telescope/telescope.nvim" },
  cmd = { "Telekasten" },
  ft = "markdown",
  opts = {
    home = home,
    -- if true, telekasten will be enabled when opening a note within the configured home
    take_over_my_home = true,

    -- auto-set telekasten filetype: if false, the telekasten filetype will not be used
    -- and thus the telekasten syntax will not be loaded either
    auto_set_filetype = false,
    -- dir names for special notes (absolute path or subdir name)
    dailies = home .. "/" .. "daily",
    weeklies = home .. "/" .. "weekly",
    templates = home .. "/" .. "templates",
    --
    -- image (sub)dir for pasting
    -- dir name (absolute path or subdir name)
    -- or nil if pasted images shouldn't go into a special subdir
    image_subdir = "img",

    -- markdown file extension
    extension = ".md",

    -- Generate note filenames. One of:
    -- "title" (default) - Use title if supplied, uuid otherwise
    -- "uuid" - Use uuid
    -- "uuid-title" - Prefix title by uuid
    -- "title-uuid" - Suffix title with uuid
    new_note_filename = "title",
    -- file uuid type ("rand" or input for os.date()")
    uuid_type = "%Y%m%d%H%M%S",
    -- UUID separator
    uuid_sep = "-",

    -- following a link to a non-existing note will create it
    follow_creates_nonexisting = true,
    dailies_create_nonexisting = true,
    weeklies_create_nonexisting = true,

    -- skip telescope prompt for goto_today and goto_thisweek
    journal_auto_open = false,

    -- template for new notes (new_note, follow_link)
    -- set to `nil` or do not specify if you do not want a template
    template_new_note = home .. "/" .. "templates/new_note.md",

    -- template for newly created daily notes (goto_today)
    -- set to `nil` or do not specify if you do not want a template
    template_new_daily = home .. "/" .. "templates/daily.md",

    -- template for newly created weekly notes (goto_thisweek)
    -- set to `nil` or do not specify if you do not want a template
    template_new_weekly = home .. "/" .. "templates/weekly.md",

    -- image link style
    -- wiki:     ![[image name]]
    -- markdown: ![](image_subdir/xxxxx.png)
    image_link_style = "markdown",

    -- default sort option: 'filename', 'modified'
    sort = "filename",

    -- integrate with calendar-vim
    plug_into_calendar = true,
    calendar_opts = {
      -- calendar week display mode: 1 .. 'WK01', 2 .. 'WK 1', 3 .. 'KW01', 4 .. 'KW 1', 5 .. '1'
      weeknm = 4,
      -- use monday as first day of week: 1 .. true, 0 .. false
      calendar_monday = 1,
      -- calendar mark: where to put mark for marked days: 'left', 'right', 'left-fit'
      calendar_mark = "left-fit",
    },
    -- telescope actions behavior
    close_after_yanking = false,
    insert_after_inserting = true,

    -- tag notation: '#tag', ':tag:', 'yaml-bare'
    tag_notation = "#tag",

    -- command palette theme: dropdown (window) or ivy (bottom panel)
    command_palette_theme = "dropdown",

    -- tag list theme:
    -- get_cursor: small tag list at cursor; ivy and dropdown like above
    show_tags_theme = "dropdown",

    -- when linking to a note in subdir/, create a [[subdir/title]] link
    -- instead of a [[title only]] link
    subdirs_in_links = true,

    -- template_handling
    -- What to do when creating a new note via `new_note()` or `follow_link()`
    -- to a non-existing note
    -- - prefer_new_note: use `new_note` template
    -- - smart: if day or week is detected in title, use daily / weekly templates (default)
    -- - always_ask: always ask before creating a note
    template_handling = "smart",

    -- path handling:
    --   this applies to:
    --     - new_note()
    --     - new_templated_note()
    --     - follow_link() to non-existing note
    --
    --   it does NOT apply to:
    --     - goto_today()
    --     - goto_thisweek()
    --
    --   Valid options:
    --     - smart: put daily-looking notes in daily, weekly-looking ones in weekly,
    --              all other ones in home, except for notes/with/subdirs/in/title.
    --              (default)
    --
    --     - prefer_home: put all notes in home except for goto_today(), goto_thisweek()
    --                    except for notes with subdirs/in/title.
    --
    --     - same_as_current: put all new notes in the dir of the current note if
    --                        present or else in home
    --                        except for notes/with/subdirs/in/title.
    new_note_location = "smart",

    -- should all links be updated when a file is renamed
    rename_update_links = true,

    -- vaults = {
    --   work = {
    --     -- alternate configuration for vault2 here. Missing values are defaulted to
    --     -- default values from telekasten.
    --     -- e.g.
    --     -- home = "/home/user/vaults/personal",
    --     -- markdown file extension
    --     extension = ".md",
    --     template_handling = "smart",
    --     home = home .. "/" .. "work",
    --     dailies = home .. "/" .. "work/daily",
    --     weeklies = home .. "/" .. "work/weekly",
    --     templates = home .. "/" .. "work/templates",
    --   },
    -- },

    -- how to preview media files
    -- "telescope-media-files" if you have telescope-media-files.nvim installed
    -- "catimg-previewer" if you have catimg installed
    media_previewer = "telescope-media-files",

    -- A customizable fallback handler for urls.
    follow_url_fallback = nil,
  },
  init = function()
    local group = vim.api.nvim_create_augroup("TelekastenMarkdownMappings", { clear = true })

    vim.api.nvim_create_autocmd("FileType", {
      group = group,
      pattern = "markdown",
      callback = function(args)
        vim.keymap.set("i", "[[", "<cmd>Telekasten insert_link<CR>", {
          buffer = args.buf,
          desc = "Insert a link to a note",
        })
      end,
    })
  end,
  specs = {
    {
      "AstroNvim/astrocore",
      opts = {
        mappings = {
          n = {
            [prefix] = { name = " Zettelkasten" },
            [prefix .. "f"] = { "<cmd>Telekasten find_notes<CR>", desc = "Find notes by title (filename)" },
            [prefix .. "g"] = { "<cmd>Telekasten search_notes<CR>", desc = "Search (grep) in all notes" },
            [prefix .. "r"] = {
              "<cmd>Telekasten rename_note<CR>",
              desc = "Rename current note and update the links pointing to it",
            },
            [prefix .. "d"] = { "<cmd>Telekasten toggle_todo<CR>", desc = "Toggle todo status of a line" },
            [prefix .. "z"] = { "<cmd>Telekasten follow_link<CR>", desc = "Follow the link under the cursor" },
            [prefix .. "n"] = { "<cmd>Telekasten new_note<CR>", desc = "Create a new note, prompts for title" },
            [prefix .. "c"] = { "<cmd>Telekasten show_calendar<CR>", desc = "Show the calendar" },
            [prefix .. "b"] = {
              "<cmd>Telekasten show_backlinks<CR>",
              desc = "Show all notes linking to the current one",
            },
            [prefix .. "t"] = { "<cmd>Telekasten show_tags<CR>", desc = "brings up the tag list" },
            [prefix .. "i"] = {
              "<cmd>Telekasten paste_img_and_link<CR>",
              desc = "Paste an image from the clipboard into a file and inserts a link to it",
            },
            [prefix .. "I"] = {
              "<cmd>Telekasten insert_img_link<CR>",
              desc = "Browse images/media files and insert a link to the selected one",
            },
          },
        },
      },
    },
  },
}
