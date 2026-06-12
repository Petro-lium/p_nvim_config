return {
	{
		"nvim-neo-tree/neo-tree.nvim",
		branch = "v3.x",
		dependencies = {
			"nvim-lua/plenary.nvim",
			"nvim-tree/nvim-web-devicons",
			"MunifTanjim/nui.nvim",
		},
		lazy = false,
		config = function()
			vim.keymap.set("n", "<C-n>", ":Neotree toggle<CR>", { desc = "neo-tree: toggle" })
			vim.keymap.set("n", "<leader>bf", ":Neotree buffers reveal float<CR>", { desc = "neo-tree: open buffers" })
		end,
	},
	{
		"akinsho/bufferline.nvim",
		version = "*",
		dependencies = "nvim-tree/nvim-web-devicons",
		lazy = false,
		config = function()
			vim.opt.termguicolors = true
			require("bufferline").setup({})
		end,
	},
}
