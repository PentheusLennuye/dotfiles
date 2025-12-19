-- [[ ide.lua ]]

-- IDE Support

local nvim_lsp = require('lspconfig')
local lint = require('lint')
local g = vim.g

-- Linters
require('lint').linters_by_ft = {
    markdown = {'markdownlint',}
}
vim.api.nvim_create_autocmd({ "BufWritePost" }, {
    callback = function()
        lint.try_lint()
    end,
})

vim.cmd[[ colorscheme NeoSolarized ]]

-- Markdown
nvim_lsp.marksman.setup{}
g.neoformat_markdown_mdformat = {
    exe = 'mdformat', args = { '-', '--wrap 99' }, stdin = 1
}
g.neoformat_enabled_markdown = { 'mdformat' }

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

