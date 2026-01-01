-- A better explorer tree with icons
-- fredit to Josean Martinez "How I Setup Neovim to Makr it AMAZING in 2024: The Ultimate Guide
return {
  "nvim-tree/nvim-tree.lua",
  dependencies = "nvim-tree/nvim-web-devicons",

  config = function()
    local nvimtree = require("nvim-tree")
  -- recommended settings from nvim-tree documentation
  vim.g.loaded_netrw = 1
  vim.g.loaded_netrwPlugin = 1
  nvimtree.setup({
    view = {
      width = 35, -- columns
      number = true,
    },
    renderer = {
      indent_markers = {
        enable = true,
      },
      icons = {
        glyphs = {
          folder = {
            arrow_closed = "→",
            arrow_open = "↓",
          },
        },
      },
    },
    -- disable window_picker for explorer to work well with window splits
    actions = {
      open_file = {
        window_picker = {
          enable = false,
        },
      },
    },
    filters = {
      custom = { ".DS_Store" },
    },
    git = {
      ignore = false,
    },
  })

  -- Tree plugin keymaps
  local keymap = vim.keymap  -- to keep things clean
  keymap.set("n", "<leader>ee", "<cmd>NvimTreeToggle<CR>", { desc = "Toggle file explorer" })
  keymap.set("n", "<leader>ef", "<cmd>NvimTreeFindFileToggle<CR>", { desc = "Toggle file find" })
  keymap.set("n", "<leader>ec", "<cmd>NvimTreeCollapse<CR>", { desc = "Collapse the explorer" })
  keymap.set("n", "<leader>er", "<cmd>NvimTreeRefresh<CR>", { desc = "Refresh the explorer" })
  end
}
