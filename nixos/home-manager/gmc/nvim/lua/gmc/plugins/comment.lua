-- Allows mass comments in the language context
-- Sort of like :,$s/^/#/ but using <space>gcG instead.
-- <space>gcc comments out the current lin
-- <space>gcG comments out from current line to EOF
-- <space>gc2j comments the current line and the next two lines
-- Credit to Josean Martinez "How I Setup Neovim to Make it AMAZING in 2024: The Ultimate Guide
return {
  "numToStr/Comment.nvim",
  event = { "BufReadPre", "BufNewFile" },
  dependencies = {
    "JoosepAlviste/nvim-ts-context-commentstring"
  },

  config = function()
    local comment = require("Comment")
    local ts_context_commentstring = require("ts_context_commentstring.integrations.comment_nvim")
    
    comment.setup({
      pre_hook = ts_context_commentstring.create_pre_hook()
    })
  end
}
