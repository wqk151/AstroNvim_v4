return {
  {
    "L3MON4D3/LuaSnip",
    config = function(plugin, opts)
      require "astronvim.plugins.configs.luasnip"(plugin, opts) -- include the default astronvim config that calls the setup call
      -- add more custom luasnip configuration such as filetype extend or custom snippets
      local luasnip_loader = require "luasnip.loaders.from_lua"
      -- local luasnip_loader = require "luasnip"
      luasnip_loader.lazy_load {
        paths = { "~/.config/nvim/lua/snippets/" },
      }
    end,
  },
}
