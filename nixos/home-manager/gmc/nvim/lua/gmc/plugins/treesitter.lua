-- From Google AI
-- Allows tree-sitter parsers, used to create syntax trees
return {
  "nvim-treesitter/nvim-treesitter",
  build = ":TSUpdate",
  opts = {
    ensure_installed = {
      "bash",
      "c",
      "diff",
      "html",
      "lua",
      "luadoc",
      "markdown",
      "markdown_inline",
      "query",
      "vim",
      "vimdoc",
    },
    auto_install = true, -- Automatically installs missing parsers
    highlight = {
      enable = true, -- Enables Treesitter highlighting
    },
    indent = {
      enable = true, -- Enables Treesitter indentation
    },
  },
  config = function(_, opts)
  end,
}
