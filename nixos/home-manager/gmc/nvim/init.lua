-- [[ init.lua ]]

-- LEADER
-- These keybindings need to be defined before the first is called; otherwise
-- it will default to "\"

vim.g.mapleader = ','
vim.g.localleader = '\\'

-- AWFUL SIDEBAR

vim.api.nvim_set_hl(0, "SignColumn", { bg = "#000000", fg = "#6666ff" })

-- IMPORTS

require('vars')    -- Variables
require('opts')    -- Options
require('keys')    -- Keymaps
require('plug')    -- Plugins
require('ide')     -- Developer Support    

-- ACTIVATE

require('toggleterm').setup{}
