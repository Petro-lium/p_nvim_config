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
			animate = true,
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
			desc = "Snacks: Smart Picker",
		},
		{
			"<leader><leader>",
			function()
				Snacks.picker.files({ smart = true })
			end,
			desc = "Snacks: Recent Files",
		},
		{
			"<leader>gs",
			function()
				-- Запуск lazygit в новом терминале (плавающем окне), чтобы он не блокировал экран
				vim.cmd("split | term lazygit")
			end,
			desc = "Git: LazyGit",
		},
		{
			"<leader>s",
			function()
				Snacks.notifier.notify("Snacks is working!")
			end,
			desc = "Snacks Test",
		},
	},
}
