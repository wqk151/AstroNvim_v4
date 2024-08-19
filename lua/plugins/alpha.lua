return {
  "goolord/alpha-nvim",
  cmd = "Alpha",
  opts = function(_, opts)
    opts.section.header.val = {
      " █████  ███████ ████████ ██████   ██████",
      "██   ██ ██         ██    ██   ██ ██    ██",
      "███████ ███████    ██    ██████  ██    ██",
      "██   ██      ██    ██    ██   ██ ██    ██",
      "██   ██ ███████    ██    ██   ██  ██████",
      " ",
      "    ███    ██ ██    ██ ██ ███    ███",
      "    ████   ██ ██    ██ ██ ████  ████",
      "    ██ ██  ██ ██    ██ ██ ██ ████ ██",
      "    ██  ██ ██  ██  ██  ██ ██  ██  ██",
      "    ██   ████   ████   ██ ██      ██",
    }

    local get_icon = require("astroui").get_icon
    opts.section.buttons.val = {
      opts.button("LDR f f", get_icon("Search", 2, true) .. "Find File  "),
      opts.button("LDR z f", get_icon("Search", 2, true) .. "Find Notes  "),
      opts.button("LDR z t", get_icon("Search", 2, true) .. "Find Notes Tags  "),
      opts.button("LDR z n", get_icon("FileNew", 2, true) .. "New Note  "),
      opts.button("LDR f o", get_icon("DefaultFile", 2, true) .. "Recents  "),
      opts.button("LDR f w", get_icon("WordFile", 2, true) .. "Find Word  "),
      opts.button("LDR f '", get_icon("Bookmarks", 2, true) .. "Bookmarks  "),
      -- button("LDR S l", get_icon("Refresh", 2, true) .. "Last Session  "),
    }
  end,
}
