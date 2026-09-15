-- Template permits the insertions of templates
return {
	"nvimdev/template.nvim",
	branch = "main",
	cmd = { "Template", "TemProject" },
	config = function()
		local t = require("template")
		t.setup({
			author = "George Cummings",
			temp_dir = "~/.config/nvim/templates",
		})
	end,
}
