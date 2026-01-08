-- Install formatting
-- Credit to Josean Martinez "How to Setup Neovim LSP Like a Pro in 2025 (v0.11+)
return {
  "stevearc/conform.nvim",
  event = { "BufReadPre", "BufNewFile" },
  config = function()
    local conform = require("conform")

    conform.setup({
      formatters_by_ft = {
        css = { "prettier" },
        html = { "prettier" },
        json = { "prettier" },
        yaml = { "prettier" },
        markdown = { "prettier" },
        graphql = { "prettier" },
        lua = { "stylua" },
        python = { "isort", "black" }
      },
      format_on_save = {
        lsp_fallback = true,
        async = false,
        timeout_ms = 3000
      }
    })
    -- Toggle autoformat for current buffer
    vim.keymap.set("n", "<leader>mf", function()
      vim.b.autoformat = not vim.b.autoformat
      vim.notify("Autoformat for this buffer: " .. (vim.b.autoformat and "ON" or "OFF"))
    end, { desc = "Toggle format on save" })

    vim.keymap.set({ "n", "v" }, "<leader>mp", function()
      conform.format({
        lsp_fallback = true,
        async = false,
        timeout_ms = 1000
      })
    end, { desc = "Format file or range (in visual mode)" })
  end
}
