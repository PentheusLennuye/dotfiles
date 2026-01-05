-- Install mason lsp package manager
-- Credit to Josean Martinez "How to Setup Neovim LSP Like a Pro in 2025 (v0.11+)
return {
  "williamboman/mason-lspconfig.nvim",
  opts = {
    ensure_installed = {
      "ansible-language-server",
      "ansible-lint",
      "bash-language-server",
      "black",
      "cmake-language-server",
      "cmake-lint",
      "cspell-lsp",
      "css-lsp",
      "dockerfile-language-server",
      "gh-actions-language-server",
      "gopls",
      "graphql-language-service-cli",
      "helm-ls",
      "html-lsp",
      "jinja-lsp",
      "json-lsp",
      "jsonlint",
      "lua-language-server",
      "markdownlint",
      "marksman",
      "nginx-language-server",
      "postgres-language-server",
      "pydocstyle",
      "pylint",
      "pyright",
      "rstcheck",
      "rust-analyzer",
      "systemd-lsp",
      "systemdlint",
      "terraform",
      "terraformls",
      "yaml-language-server",
      "yamllint",
    }
  },
  dependencies = {
    {
      "williamboman/mason.nvim",
      opts = {
        ui = {
          icons = {
            package_installed = "✓",
            package_pending = "→",     -- rightwards arrow
            package_uninstalled = "✗"  -- ballot
          }         
        }
      }
    },
    "neovim/nvim-lspconfig"
  }
}
