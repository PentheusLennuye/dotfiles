-- Allows tree-sitter parsers, used to create syntax trees
-- Credit to Josean Martinez "How I Setup Neovim to Makr it AMAZING in 2024: The Ultimate Guide
return {
  "nvim-treesitter/nvim-treesitter",
  branch = "main",
  build = ":TSUpdate",
  config = function()
    local treesitter = require("nvim-treesitter")

    treesitter.setup({
      autotag = { enable = true },
      install = {
        "asm",
        "bash",
        "bibtex",
        "c",
        "cpp",
        "css",
        "dockerfile",
        "git_config",
        "gitcommit",
        "gitignore",
        "go",
        "gomod",
        "gosum",
        "graphql",
        "haskell",
        "haskell_persistent",
        "helm",
        "html",
        "ini",
        "jinja",
        "jinja_inline",
        "json",
        "latex",
        "lua",
        "luadoc",
        "make",
        "markdown",
        "markdown_inline",
        "mermaid",
        "nginx",
        "nix",
        "query",
        "python",
        "rust",
        "sql",
        "terraform",
        "toml",
        "vim",
        "vimdoc",
        "yaml",
        "zsh"
      },
      highlight = { enable = true },
      incremental_selection = {
        enable = true,
        keymaps = {
          init_selection = "<C-Space>",
          node_incremental = "<C-Space>",
          scope_incremental = false,
          node_decremental = "<bs>",
        }
      },
     indent = { enable = true }
    })
  end
}
