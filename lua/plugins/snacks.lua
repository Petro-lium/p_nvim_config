return {
	"folke/snacks.nvim",
	priority = 1000,
	lazy = false,
	opts = {
		dashboard = {
			enabled = false,
		},
		picker = {
			enabled = true,
		},
		notifier = {
			enabled = true,
			timeout = 3000,
		},
		scroll = {
			enabled = true,
			animate = {
				enabled = true,
				easing = "outQuad",
				duration = {
					step = 20,
					total = 300,
				},
			},
		},
		indent = {
			enabled = true,
			char = "│",
		},
		words = {
			enabled = true,
		},
		bigfile = {
			enabled = true,
		},
		quickfile = {
			enabled = true,
		},
	},
	keys = {
		{
			"<C-p>",
			function()
				Snacks.picker.smart()
			end,
			desc = "picker: smart (files + grep + buffers)",
		},
		{
			"<leader>fg",
			function()
				Snacks.picker.grep()
			end,
			desc = "picker: live grep",
		},
		{
			"<leader>ff",
			function()
				Snacks.picker.files()
			end,
			desc = "picker: all files",
		},
		{
			"<leader>gl",
			function()
				Snacks.lazygit()
			end,
			desc = "git: LazyGit",
		},
	},
}
