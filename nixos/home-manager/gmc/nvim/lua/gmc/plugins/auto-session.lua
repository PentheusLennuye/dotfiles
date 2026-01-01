-- Restore an nvim session
-- Credit to Josean Martinez "How I Setup Neovim to Make it AMAZING in 2024: The Ultimate Guide
return {
  "rmagatti/auto-session",
  config = function()
    local auto_session = require("auto-session")

    auto_session.setup({
      auto_restore_enabled = false,
      auto_session_suppress_dirs = { "~/", "~/extra/", "~/nltk_data", "~/sources", "~/Zotero" },
    })

    local keymap = vim.keymap  -- keep it concise
    keymap.set(
      "n", "<leader>wr", "<cmd>AutoSession restore<CR>", { desc = "Restore session for cwd" }
    )
    keymap.set(
      "n", "<leader>ws", "<cmd>Autosession save<CR>",
      { desc = "Save session for auto session root dir" }
    )
  end
}
