return {
	"tpope/vim-dadbod",
	dependencies = {
		"kristijanhusak/vim-dadbod-ui",
	},
	config = function()
		vim.keymap.set("n", "<leader>dd", "<cmd>DBUI<CR>", { silent = true, desc = "db: toggle UI" })
	end,
}
