-- [[ Keymaps ]]

vim.g.mapleader = " "

local keymap = vim.keymap

-- ┌────────────────────┐
-- │ Windows management ├─────────────────────────────────────────────────────────────────────────┐
-- └┬───────────────────┘                                                                         │
--  │ In Vim, windows are known as "splits"                                                       │
--  │                                                                                             │
--  └─────────────────────────────────────────────────────────────────────────────────────────────┘

keymap.set("n", "<leader>sv", "<C-w>v", { desc = "Split window vertically" })
keymap.set("n", "<leader>sh", "<C-w>s", { desc = "Split window horizontally" })
keymap.set("n", "<leader>se", "<C-w>=", { desc = "Equalise split areas" })
keymap.set("n", "<leader>sz", "<cmd>close<CR>", { desc = "Close current split" })
keymap.set("n", "<C-0>", "<C-w><", { desc = "Decrease current window size" })
keymap.set("n", "<C-->", "<C-w>-", { desc = "Increase current window size" })

-- ┌────────────────────┐
-- │ Tabs management    ├─────────────────────────────────────────────────────────────────────────┐
-- └┬───────────────────┘                                                                         │
--  │                                                                                             │
--  │                                                                                             │
--  └─────────────────────────────────────────────────────────────────────────────────────────────┘

keymap.set("n", "<leader>to", "<cmd>tabnew<CR>", { desc = "Open new tab" })
keymap.set("n", "<leader>tz", "<cmd>tabclose<CR>", { desc = "Close current tab" })
keymap.set("n", "<leader>tn", "<cmd>tabn<CR>", { desc = "Cycle to next tab" })
keymap.set("n", "<leader>tp", "<cmd>tabp<CR>", { desc = "Cycle to previous tab" })
keymap.set("n", "<leader>tf", "<cmd>tabnew %<CR>", { desc = "Open buffer in new tab" })

-- ┌────────────────────┐
-- │ Navigation         ├─────────────────────────────────────────────────────────────────────────┐
-- └┬───────────────────┘                                                                         │
--  │                                                                                             │
--  │                                                                                             │
--  └─────────────────────────────────────────────────────────────────────────────────────────────┘

-- Remapping cursor navigation for tarmak
keymap.set("n", "m", "h", { noremap = true })
keymap.set("n", "n", "j", { noremap = true })
keymap.set("n", "e", "k", { noremap = true })
-- keymap.set("n", "l", "l", { noremap = true })

-- N for next has been compromised above, so use H, the Cyrillic n.
keymap.set("n", "h", "n", { noremap = true })

-- Remapping window ("split") navigation for Colemak
keymap.set("n", "<C-m>", "<C-w>h", { noremap = true, silent = true })
keymap.set("n", "<C-n>", "<C-w>j", { noremap = true, silent = true })
keymap.set("n", "<C-e>", "<C-w>k", { noremap = true, silent = true })
keymap.set("n", "<C-l>", "<C-w>l", { noremap = true, silent = true })
