-- [[ Keymaps ]]

vim.g.mapleader = " "

local keymap = vim.keymap

-- Windows management

keymap.set("n", "<leader>sv", "<C-w>v", { desc = "Split window vertically" })
keymap.set("n", "<leader>sh", "<C-w>s", { desc = "Split window horizontally" })
keymap.set("n", "<leader>se", "<C-w>=", { desc = "Equalise split areas" })
keymap.set("n", "<leader>sz", "<cmd>close<CR>", { desc = "Close current split" })

-- Tabs management
keymap.set("n", "<leader>to", "<cmd>tabnew<CR>", { desc = "Open new tab" })
keymap.set("n", "<leader>tz", "<cmd>tabclose<CR>", { desc = "Close current tab" })
keymap.set("n", "<leader>tn", "<cmd>tabn<CR>", { desc = "Cycle to next tab" })
keymap.set("n", "<leader>tp", "<cmd>tabp<CR>", { desc = "Cycle to previous tab" })
keymap.set("n", "<leader>tf", "<cmd>tabnew %<CR>", { desc = "Open buffer in new tab" })

-- Remapping cursor navigation for tarmak
keymap.set("n", "h", "m", { noremap = true })
keymap.set("n", "j", "n", { noremap = true })
keymap.set("n", "k", "e", { noremap = true })
keymap.set("n", "l", "h", { noremap = true })

-- Remapping window navigation for tarmak
keymap.set("n", "<C-h>", "<C-m>", { noremap = true, silent = true })
keymap.set("n", "<C-j>", "<C-n>", { noremap = true, silent = true })
keymap.set("n", "<C-k>", "<C-e>", { noremap = true, silent = true })
keymap.set("n", "<C-l>", "<C-l>", { noremap = true, silent = true })
