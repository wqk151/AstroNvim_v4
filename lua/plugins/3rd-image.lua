-- install lua: sudo apt install liblua5.1-0 lua5.1-0-dev
-- install luarocks: https://luarocks.org/#quick-start
-- run: luarocks --local --lua-version=5.1 install magick
-- render local images, can not use quotation marks and `./`,eg: ![test](test.png)
return {
  "3rd/image.nvim",
  branch = "feat/toggle-rendering",
  dependencies = {
    "leafo/magick",
    "nvim-treesitter/nvim-treesitter",
    {
      "vhyrro/luarocks.nvim",
      config = function()
        package.path = package.path .. ";" .. vim.fn.expand "$HOME" .. "/.luarocks/share/lua/5.1/?/init.lua"
        package.path = package.path .. ";" .. vim.fn.expand "$HOME" .. "/.luarocks/share/lua/5.1/?.lua"
        require("image").setup {}
      end,
    },
  },
}
