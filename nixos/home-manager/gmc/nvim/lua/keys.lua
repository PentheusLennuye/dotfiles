-- [[ keys.lua ]]

local map = vim.api.nvim_set_keymap

-- NERDTree File Manager
map('n', '<Leader>1', '<cmd>NERDTreeToggle<cr>', {})

-- Barbar Tab Plugin
map('n', '<A-,>', '<cmd>BufferPrevious<cr>', {})
map('n', '<A-.>', '<cmd>BufferNext<cr>', {})
map('n', '<A-<>', '<cmd>BufferMovePrevious<cr>', {})
map('n', '<A->>', '<cmd>BufferMoveNext<cr>', {})
map('n', '<A-c>', '<cmd>BufferClose<cr>', {})

-- ToggleTerm terminal
map('n', '<A-t>', '<cmd>ToggleTerm size=15 direction=horizontal<cr>', {})

