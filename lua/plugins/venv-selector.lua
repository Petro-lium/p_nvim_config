return {
	"linux-cultist/venv-selector.nvim",
	dependencies = {
        "neovim/nvim-lspconfig",
        "nvim-telescope/telescope.nvim"
    },
	config = function()
		require("venv-selector").setup({
			name = ".venv",
			auto_refresh = true,
		})
	end,
	event = "VeryLazy",
}
