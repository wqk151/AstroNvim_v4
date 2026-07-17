return {
  "L3MON4D3/LuaSnip",
  require("luasnip.loaders.from_lua").lazy_load {
    paths = { "~/.config/nvim/lua/snippets/" },
  },
}
