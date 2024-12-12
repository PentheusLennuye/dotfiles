-- [[ plug.lua ]]

local vim = vim
local Plug = vim.fn['plug#']

vim.call('plug#begin')

-- File Manager
Plug('preservim/nerdtree', { ['on'] = 'NERDTreeToggle'})

-- Tabs
Plug('nvim-tree/nvim-web-devicons')
Plug('lewis6991/gitsigns.nvim')
Plug('romgrk/barbar.nvim')

-- Terminals
Plug('akinsho/toggleterm.nvim', { ['tag'] = '*'})

-- IDE assistance
Plug('sbdchd/neoformat')
Plug('mfussenegger/nvim-lint')
Plug('neovim/nvim-lspconfig')

vim.call('plug#end')

