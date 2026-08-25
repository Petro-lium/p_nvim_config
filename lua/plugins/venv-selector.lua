return {
	"linux-cultist/venv-selector.nvim",
	dependencies = {
        "neovim/nvim-lspconfig",
    },
	config = function()
		require("venv-selector").setup({
			name = ".venv",
			auto_refresh = true,
		})
	end,
	event = "VeryLazy",
}
