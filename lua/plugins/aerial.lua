return {
	"stevearc/aerial.nvim",
	config = function()
		require("aerial").setup()
		vim.keymap.set("n", "<leader>o", "<cmd>AerialToggle<CR>", { desc = "aerial: toggle outline" })
	end,
}
