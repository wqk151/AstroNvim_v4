return {
  "luozhiya/fittencode.nvim",
  event = { "InsertEnter", "CmdlineEnter" },
  config = function()
    require("fittencode").setup {
      source_completion = {
        -- Enable source completion.
        enable = false,
        -- engine support nvim-cmp and blink.cmp
        engine = "blink", -- "cmp" | "blink"
        -- trigger characters for source completion.
        -- Available options:
        -- * A  list of characters like {'a', 'b', 'c', ...}
        -- * A function that returns a list of characters like `function() return {'a', 'b', 'c', ...}`
        trigger_chars = {},
      },
      chat = {
        sidebar = {
          position = "right",
        },
      },
      disable_specific_inline_completion = {
        suffixes = {
          "TelescopePrompt",
          "neo-tree-popup",
          "AvanteInput",
          "snacks_picker_input",
          "snacks_input",
          "bigfile",
          "snacks_input",
          "snacks_notif",
          "AvanteInput",
          "snacks_picker_list",
          "dapui_watches",
          "grug-far",
          "DressingInput",
        },
      },
      use_default_keymaps = false,
      keymaps = {
        inline = {
          ["<C-i>"] = "accept_all_suggestions",
          ["<C-y>"] = "accept_line",
          -- ["<C-Right>"] = "accept_word",
          ["<C-e>"] = "revoke_line",
          -- ["<C-Left>"] = "revoke_word",
          ["<A-\\>"] = "triggering_completion",
        },
        chat = {
          ["q"] = "close",
          ["[c"] = "goto_previous_conversation",
          ["]c"] = "goto_next_conversation",
          ["c"] = "copy_conversation",
          ["C"] = "copy_all_conversations",
          ["d"] = "delete_conversation",
          ["D"] = "delete_all_conversations",
        },
      },
    }
  end,
}
