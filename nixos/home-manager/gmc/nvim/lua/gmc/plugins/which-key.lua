-- How to remember the key maps
-- Credit to Josean Martinez "How I Setup Neovim to Makr it AMAZING in 2024: The Ultimate Guide
return {
  "folke/which-key.nvim",
  event = "VeryLazy",  -- not required at load
  init = function()
    vim.o.timeout = true
    vim.o.timeoutlen = 500 -- 0.5 seconds
  end,
  opts = {
    -- default configuration for now
  }
}
