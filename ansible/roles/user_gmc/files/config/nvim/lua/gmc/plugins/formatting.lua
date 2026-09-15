-- Install formatting
-- Credit to Josean Martinez "How to Setup Neovim LSP Like a Pro in 2025 (v0.11+)
return {
	"stevearc/conform.nvim",
	event = { "BufReadPre", "BufNewFile" },
	config = function()
		local conform = require("conform")

		conform.setup({
			formatters = {
				["markdown-toc"] = {
					condition = function(_, ctx)
						for _, line in ipairs(vim.api.nvim_buf_get_lines(ctx.buf, 0, -1, false)) do
							if line:find("<%-%- toc %-%->") then
								return true
							end
						end
						return false
					end,
				},
				["markdown-cli2"] = {
					condition = function(_, ctx)
						local diagnostic = vim.tbl_filter(function(d)
							return d.source == "markdownlint"
						end, vim.diagnostic.get(ctx.buf))
						return #diagnostic > 0
					end,
				},
			},
			formatters_by_ft = {
				css = { "prettier" },
				go = { "gopls" },
				graphql = { "prettier" },
				haskell = { "ormolu" },
				html = { "prettier" },
				json = { "prettier" },
				lua = { "stylua" },
				markdown = { "prettier" },
				python = { "isort", "black" },
				rust = { "rust_analyzer" },
				terraform = { "terraform" },
				yaml = { "yamlfmt" },
			},
			format_on_save = {
				lsp_fallback = true,
				async = false,
				timeout_ms = 3000,
			},
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
				timeout_ms = 1000,
			})
		end, { desc = "Format file or range (in visual mode)" })
	end,
}
