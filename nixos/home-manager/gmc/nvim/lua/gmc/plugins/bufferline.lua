-- Better tab rendering
-- Credit to Josean Martinez "How I Setup Neovim to Makr it AMAZING in 2024: The Ultimate Guide
return {
  "akinsho/bufferline.nvim",
  dependencies = { "nvim-tree/nvim-web-devicons" },
  version = "*",
  opts = {
    options = {
      mode = "tabs",
      separator_style = "slant",
    }
  }
}
