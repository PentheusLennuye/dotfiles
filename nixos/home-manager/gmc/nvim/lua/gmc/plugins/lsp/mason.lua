-- Install mason lsp package manager
-- Credit to Josean Martinez "How to Setup Neovim LSP Like a Pro in 2025 (v0.11+)
return {
  {
    "mason-org/mason-lspconfig.nvim",
    opts = {
      ensure_installed = {
        "asm_lsp", -- in NixOS, see README.md
        "ansiblels",
        "bashls",
        "cmake",
        "codebook",
        "cssls",
        "dockerls",
        "gh_actions_ls",
        "gopls",
        "graphql",
        "helm_ls", -- Haskell is taken care of by its own plugin
        "html",
        "jinja_lsp",
        "jsonls",
        "lua_ls",
        "marksman",
        "nginx_language_server",
        "nil_ls", -- Nix language server
        "postgres_lsp",
        "pyright",
        "rust_analyzer",
        "systemd_lsp",
        "terraformls",
        "yamlls",
      }
    },
    dependencies = {
      {
        "mason-org/mason.nvim",
        opts = {
          ui = {
            icons = {
              package_installed = "✓",
              package_pending = "→", -- rightwards arrow
              package_uninstalled = "✗" -- ballot
            }
          }
        }
      },
      "neovim/nvim-lspconfig"
    }
  },
  {
    "WhoIsSethDaniel/mason-tool-installer.nvim",
    opts = {
      ensure_installed = {
        -- "ansible-lint",
        "black",
        "cmakelint",
        "isort",
        "jsonlint",
        "markdownlint",
        "pydocstyle",
        "pylint",
        "rstcheck",
        "systemdlint",
        "terraform",
        "yamllint"
      }
    },
    dependencies = {
      {
        "mason-org/mason.nvim",
      }
    }
  }
}
