-- Template permits the insertions of templates
-- Credit to Josean Martinez "How I Setup Neovim to Make it AMAZING in 2024: The Ultimate Guide
return {
	"lukas-reineke/virt-column.nvim",
	branch = "master",
	config = function()
		local vc = require("virt-column")
		vc.setup({
			char = "│",
			hl_group = "ColorColumn",
			enabled = true,
		})
	end,
}
