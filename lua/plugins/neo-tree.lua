return {
	{
		"nvim-neo-tree/neo-tree.nvim",
		branch = "v3.x",
		dependencies = {
			"nvim-lua/plenary.nvim",
			"mini.icons",
			"MunifTanjim/nui.nvim",
		},
		lazy = false,
		config = function()
			vim.keymap.set("n", "<C-n>", "<cmd>Neotree toggle<CR>", { desc = "neo-tree: toggle" })
			vim.keymap.set("n", "<leader>bf", "<cmd>Neotree buffers reveal float<CR>", { desc = "neo-tree: open buffers" })
		end,
	},
	{
		"akinsho/bufferline.nvim",
		version = "*",
		dependencies = "mini.icons",
		lazy = false,
		config = function()
			vim.opt.termguicolors = true
			require("bufferline").setup({})
		end,
	},
}
