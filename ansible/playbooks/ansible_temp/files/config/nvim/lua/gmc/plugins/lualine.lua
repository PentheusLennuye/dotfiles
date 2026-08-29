-- Better status lines
-- Credit to Josean Martinez "How I Setup Neovim to Make it AMAZING in 2024: The Ultimate Guide
return {
  "nvim-lualine/lualine.nvim",
  dependencies = { "nvim-tree/nvim-web-devicons" },
  config = function()
    local luaLine = require("lualine")
    local lazy_status = require("lazy.status")

    local colours = {
      blue = "#65d1ff",
      green = "#3effdc",
      violet = "#ff61ef",
      yellow = "#ffda7b",
      red = "#ff4a4a",
      fg = "#c3ccdc",
      bg = "#112638",
      inactive_bg = "#2c3043"
    }

    local gmc_theme = {
      normal = {
        a = { bg = colours.blue, fg = colours.bg, gui = "bold" },
        b = { bg = colours.bg, fg = colours.fg },
        c = { bg = colours.bg, fg = colours.fg },
      },
      insert = {
        a = { bg = colours.green, fg = colours.bg, gui = "bold" },
        b = { bg = colours.bg, fg = colours.fg },
        c = { bg = colours.bg, fg = colours.fg },
      },
      visual = {
        a = { bg = colours.violet, fg = colours.bg, gui = "bold" },
        b = { bg = colours.bg, fg = colours.fg },
        c = { bg = colours.bg, fg = colours.fg },
      },
      command = {
        a = { bg = colours.yellow, fg = colours.bg, gui = "bold" },
        b = { bg = colours.bg, fg = colours.fg },
        c = { bg = colours.bg, fg = colours.fg },
      }
    }

    luaLine.setup({
      options = {
        theme = gmc_theme
      },
      sections = {
        lualine_x = { -- x is the third section from the right
          {
            lazy_status.updates,
            cond = lazy_status.has_updates,
            color = { fg = "#ff9e64" }
          },
          { "encoding" },
          { "fileformat" },
          { "filetype" }
        }
      }
    })
  end
}
