-- Close HTML tags in files such as html and markdown
return {
  "windwp/nvim-ts-autotag",
  config = function()
    local autoTag = require("nvim-ts-autotag")

    autoTag.setup({
      opts = {
        enable_close = true,
        enable_close_on_slash = false,
        enable_rename = true
      }
    })
  end
}
