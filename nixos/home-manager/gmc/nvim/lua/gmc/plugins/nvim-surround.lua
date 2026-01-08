-- Add, delete and modify surrounding symbols and tags
-- Credit to Josean Martinez "How I Setup Neovim to Make it AMAZING in 2024: The Ultimate Guide
return {
  "kylechui/nvim-surround",
  event = { "BufReadPre", "BufNewFile" },
  version = "*",
  config = true,
}
