return {
	"stevearc/aerial.nvim",
	config = function()
		require("aerial").setup()
		vim.keymap.set("n", "<leader>o", ":AerialToggle<CR>", { desc = "aerial: toggle outline" })
	end,
}
