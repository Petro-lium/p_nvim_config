return {
	{
		"tpope/vim-fugitive",
	},
	{
		"sindrets/diffview.nvim",
		event = "VeryLazy",
		config = function()
			require("diffview").setup({
				use_icons = false,
			})

			-- Глобальный обзор изменений проекта (заглавная D, чтобы не конфликтовать с gitsigns)
			vim.keymap.set("n", "<leader>gD", ":DiffviewOpen<CR>", { desc = "git: project diff view" })
			vim.keymap.set("n", "<leader>gx", ":DiffviewClose<CR>", { desc = "git: close diff view" })
		end,
	},
	{
		"lewis6991/gitsigns.nvim",
		config = function()
			require("gitsigns").setup({
				signs = {
					add = { text = "│" },
					change = { text = "│" },
					delete = { text = "_" },
					topdelete = { text = "‾" },
					changedelete = { text = "~" },
					untracked = { text = "┆" },
				},
				signcolumn = true,
				numhl = false,
				linehl = false,
				word_diff = false,
				watch_gitdir = {
					interval = 1000,
					follow_files = true,
				},
				attach_to_untracked = true,
				current_line_blame = false,
				current_line_blame_opts = {
					virt_text = true,
					virt_text_pos = "eol",
					delay = 1000,
					ignore_whitespace = false,
				},
				current_line_blame_formatter = "<author>, <author_time:%Y-%m-%d> - <summary>",
			})

			-- Git клавиши (избегаем конфликтов с LSP)
			vim.keymap.set("n", "<leader>gh", ":Gitsigns preview_hunk<CR>", { desc = "git: preview hunk" })
			vim.keymap.set("n", "<leader>gb", ":Gitsigns toggle_current_line_blame<CR>", { desc = "git: toggle blame" })
			vim.keymap.set("n", "<leader>gd", ":Gitsigns diffthis<CR>", { silent = true, desc = "Show diff" })
			vim.keymap.set("n", "<leader>gn", ":Gitsigns next_hunk<CR>", { silent = true, desc = "Next hunk" })
			vim.keymap.set("n", "<leader>gN", ":Gitsigns prev_hunk<CR>", { silent = true, desc = "Prev hunk" })
			vim.keymap.set("n", "<leader>gA", ":Git add %<CR>", { desc = "git: stage whole file" })
			vim.keymap.set("n", "<leader>ga", ":Gitsigns stage_hunk<CR>", { silent = true, desc = "Stage hunk" })
			vim.keymap.set(
				"n",
				"<leader>gu",
				":Gitsigns undo_stage_hunk<CR>",
				{ silent = true, desc = "Undo stage hunk" }
			)
		end,
	},
}
