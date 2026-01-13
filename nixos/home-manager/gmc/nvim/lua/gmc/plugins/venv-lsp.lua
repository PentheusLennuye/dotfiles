-- Ensure a linters detect the virtual environment
return {
	"jglasovic/venv-lsp.nvim",
	config = function()
		require("venv-lsp").setup()
	end,
	lazy = false,
}
