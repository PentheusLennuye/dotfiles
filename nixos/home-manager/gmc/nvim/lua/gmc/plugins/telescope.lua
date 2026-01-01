-- Telescope is a fuzzy finder
-- Credit to Josean Martinez "How I Setup Neovim to Makr it AMAZING in 2024: The Ultimate Guide
return {
  "nvim-telescope/telescope.nvim",
  branch = "0.1.x",

  dependencies = {
    -- required
    "nvim-lua/plenary.nvim",
    -- "nvim-treesitter/nvim-treesitter.nvim",
    -- "BurntSushi/ripgrep.nvim",
    -- "sharkdp/fd.nvim",
    -- "nvim-treesitter/nvim-treesitter.nvim",
    -- optional
    { "nvim-telescope/telescope-fzf-native.nvim", build = "make" }, -- improved search
    "nvim-tree/nvim-web-devicons",
  },

  config = function()
    local telescope = require("telescope")
    local actions = require("telescope.actions")
    telescope.setup({
      defaults = {
        path_display = "smart",
        mappings = {  -- Use tmux key mappings for consistency
          i = {
            ["<C-k>"] = actions.move_selection_previous,
            ["<C-j>"] = actions.move_selection_next,
            ["<C-q>"] = actions.send_selected_to_qflist + actions.open_qflist
          }
        }
      }
    })
    telescope.load_extension("fzf")  -- improves search efficiency

    -- set keymaps
    local km = vim.keymap  -- to be concise
    km.set("n", "<leader>ff", "<cmd>Telescope find_files<cr>", { desc="Fuzzy find files in cwd" })
    km.set("n", "<leader>fr", "<cmd>Telescope oldfiles<cr>", { desc="Fuzzy find recent files" })
    km.set("n", "<leader>fs", "<cmd>Telescope live_grep<cr>", { desc="Fuzzy string in cwd" })
    km.set("n", "<leader>fc", "<cmd>Telescope grep_string<cr>", { desc="Find str under cursor" })
  end
}
