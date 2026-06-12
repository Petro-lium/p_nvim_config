return {
	"mistweaverco/kulala.nvim",
	ft = { "http", "rest" },
	lazy = true,
	config = function()
		require("kulala").setup({
			global_keymaps = false,
		})
	end,
	keys = {
		{
			"<leader>Rs",
			function()
				require("kulala").run()
			end,
			desc = "Kulala: Send request",
		},
		{
			"<leader>Ra",
			function()
				require("kulala").run_all()
			end,
			desc = "Kulala: Send all requests",
		},
		{
			"<leader>Rb",
			function()
				require("kulala").scratchpad()
			end,
			desc = "Kulala: Scratchpad",
		},
	},
}
