return {
	{
		"stevearc/conform.nvim",
		lazy = false,
		config = function()
			local conform = require("conform")

			conform.setup({
				formatters = {
					sqlfluff = {
						command = "sqlfluff",
						-- аргументы: диалект postgres, читать stdin
						args = { "fix", "--dialect", "postgres", "-" },
						-- если диалект нужно менять для разных проектов, можно убрать "--dialect"
						-- и создать файл .sqlfluff в корне проекта
					},
				},
				formatters_by_ft = {
					lua = { "stylua" },
					python = { "ruff_format" },
					html = { "djlint" },
					javascript = { "prettier" },
					javascriptreact = { "prettier" },
					typescript = { "prettier" },
					typescriptreact = { "prettier" },
					json = { "prettier" },
					css = { "prettier" },
					yaml = { "prettier" },
					markdown = { "prettier" },
					sql = { "sqlfluff" },
				},
				format_on_save = {
					timeout_ms = 2000,
					lsp_fallback = true,
				},
			})

			vim.keymap.set("n", "<leader>gf", function()
				conform.format({ lsp_format = "fallback", timeout_ms = 2000 })
			end, { desc = "format: run formatter" })
		end,
	},
}
