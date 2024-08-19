local M = {}
local ls = require "luasnip"
M.ls = ls
M.s = ls.snippet
M.sn = ls.snippet_node
M.t = ls.text_node
M.i = ls.insert_node
M.f = ls.function_node
M.c = ls.choice_node
M.d = ls.dynamic_node
function M.date() return { os.date "%Y-%m-%d" } end
return M
