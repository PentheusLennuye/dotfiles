-- [[ Keymaps ]]

vim.g.mapleader = ' '

local keymap = vim.keymap

-- Windows management

keymap.set("n", "<leader>sv", "<C-w>v", { desc = "Split window vertically" })
keymap.set("n", "<leader>sh", "<C-w>s", { desc = "Split window horizontally" })
keymap.set("n", "<leader>se", "<C-w>=", { desc = "Equalize split areas" })
keymap.set("n", "<leader>sz", "<cmd>close<CR>", { desc = "Close current split" })

-- Tabs management
keymap.set("n", "<leader>to", "<cmd>tabnew<CR>", { desc = "Open new tab" })
keymap.set("n", "<leader>tz", "<cmd>tabclose<CR>", { desc = "Close current tab" })
keymap.set("n", "<leader>tn", "<cmd>tabn<CR>", { desc = "Cycle to next tab" })
keymap.set("n", "<leader>tp", "<cmd>tabp<CR>", { desc = "Cycle to previous tab" })
keymap.set("n", "<leader>tf", "<cmd>tabnew %<CR>", { desc = "Open buffer in new tab" })

