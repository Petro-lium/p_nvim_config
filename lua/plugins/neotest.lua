return {
	{
		"nvim-neotest/neotest",
		dependencies = {
			"nvim-neotest/nvim-nio",
			"nvim-lua/plenary.nvim",
			"nvim-treesitter/nvim-treesitter",
			"antoinemadec/FixCursorHold.nvim",
			"nvim-neotest/neotest-python",
		},
		config = function()
			local neotest = require("neotest")

			local adapter = require("neotest-python")({
				args = { "--no-header", "--tb=short", "-s" },
				runner = "pytest",
			})

			neotest.setup({
				adapters = { adapter },
				icons = {
					expanded = "",
					collapsed = "",
					running = "",
					passed = "",
					failed = "",
					error = "",
					skipped = "",
					unknown = "",
				},
				floating = {
					border = "rounded",
					max_height = 0.8,
					max_width = 0.8,
				},
			})

			-- Neotest keymaps
			vim.keymap.set("n", "<leader>tn", "<cmd>Neotest run<CR>", { desc = "test: run nearest" })
			vim.keymap.set("n", "<leader>tf", "<cmd>Neotest run file<CR>", { desc = "test: run file" })
			vim.keymap.set("n", "<leader>ta", function()
				require("neotest").run.run(vim.fn.getcwd())
			end, { desc = "test: run all in project" })
			vim.keymap.set("n", "<leader>tl", "<cmd>Neotest run last<CR>", { desc = "test: run last" })
			vim.keymap.set("n", "<leader>td", function()
				require("neotest").run.run({ strategy = "dap" })
			end, { desc = "test: debug nearest" })
			vim.keymap.set("n", "<leader>to", "<cmd>Neotest output<CR>", { desc = "test: show output" })
			vim.keymap.set("n", "<leader>ts", "<cmd>Neotest output-panel<CR>", { desc = "test: toggle output panel" })
			vim.keymap.set("n", "<leader>tt", "<cmd>Neotest summary<CR>", { desc = "test: summary tree" })
		end,
	},
}
