-- if true then return {} end -- WARN: REMOVE THIS LINE TO ACTIVATE THIS FILE
return {
  "stevearc/aerial.nvim",
  opts = {
    backends = {
      ["_"] = { "lsp", "treesitter" },
      markdown = { "treesitter" },
      rust = { "lsp" },
    },
    filter_kind = {
      python = {
        "Class",
        "Constructor",
        "Enum",
        "Field",
        "Function",
        "Interface",
        "Method",
        "Module",
        "Namespace",
        "Package",
        "Property",
        "Struct",
        "Trait",
      },
    },
  },
}
