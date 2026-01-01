-- Monokai Pro Colour Scheme
-- Credit to Josean Martinez "How I Setup Neovim to Makr it AMAZING in 2024: The Ultimate Guide
return {
  "phanviet/vim-monokai-pro",
  priority = 1000,
  config = function()
    vim.cmd("colorscheme monokai_pro")
  end
}
