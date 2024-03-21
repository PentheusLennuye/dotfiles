-- [[ ide.lua ]]
--
-- IDE Support

local nvim_lsp = require('lspconfig')
local lint = require('lint')

-- Linter
lint.linters_by_ft = {
    markdown = {'markdownlint'}
}

-- Marksman
nvim_lsp.marksman.setup{}

-- Python
nvim_lsp.jedi_language_server.setup{}

-- Rust
nvim_lsp.rust_analyzer.setup{
    settings = {
        ["rust-analyzer"] = {
            workspace = {
                symbol = {
                    search = {
                        kind = "all_symbols"
                    }
                }
            }
         }
    }
}

