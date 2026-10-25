return {
	"folke/noice.nvim",
	event = "VeryLazy",
	dependencies = {
		"MunifTanjim/nui.nvim",
	},
	opts = {
		cmdline = {
			enabled = true,
			view = "cmdline_popup",
		},
		views = {
			cmdline_popup = {
				position = {
					row = "30%",
					col = "50%",
				},
				size = {
					width = 60,
					height = "auto",
				},
			},
		},
		messages = {
			enabled = true,
		},
		presets = {
			bottom_search = false,
			command_palette = true,
			long_message_to_split = true,
			inc_rename = false,
			lsp_doc_border = false,
		},
	},
}
