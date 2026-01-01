-- Close HTML tags in files such as html and markdown
return {
  "windwp/nvim-ts-autotag",
  config = function()
    local autotag = require("nvim-ts-autotag")
    
    autotag.setup({
      opts = {
        enable_close = true,
        enable_close_on_slash = false,
        enable_rename = true
      }
    })
  end
}
