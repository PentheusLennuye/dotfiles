-- Install lazy plugin manager
-- Credit to Josean Martinez "How I Setup Neovim to Make it AMAZING in 2024: The Ultimate Guide

local lazyPath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
---@diagnostic disable-next-line: undefined-field
if not vim.uv.fs_stat(lazyPath) then
  vim.fn.system({
    "git",
    "clone",
    "--filter=blob:none",
    "https://github.com/folke/lazy.nvim.git",
    "--branch=stable",
    lazyPath,
  })
end
vim.opt.rtp:prepend(lazyPath)

require("lazy").setup({
  spec = {
    { import = "gmc.plugins" },
    { import = "gmc.plugins.lsp" }
  },
  change_detection = {
    notify = false
  },
  checker = {
    enabled = true,
    notify = false
  }
})
