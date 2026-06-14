return {
	{
		"nvim-lualine/lualine.nvim",
		dependencies = { "mini.icons" },
		config = function()
			require("lualine").setup({
				options = {
					theme = "auto",
					icons_enabled = true,
					component_separators = "|",
					section_separators = "",
				},
				refresh = {
					statusline = 1000,
					tabline = 1000,
					winbar = 1000,
					refresh_time = 1000, -- ~1fps
					events = {
						"WinEnter",
						"BufEnter",
						"BufWritePost",
						"SessionLoadPost",
						"FileChangedShellPost",
						"VimResized",
						"Filetype",
						"ModeChanged",
					},
				},
				sections = {
					lualine_a = { "mode" },
					lualine_b = { "branch", "diff", "diagnostics" },
					lualine_c = {
						"filename",
						{
							function()
								local v = require("venv-selector").venv() or vim.env.VIRTUAL_ENV
								return v and vim.fn.fnamemodify(v, ":t") or ""
							end,
							-- color = { fg = "#ffffff" },
						},
					},
					lualine_x = { "encoding", "fileformat", "filetype" },
					lualine_y = { "progress" },
					lualine_z = { "location" },
				},
			})
		end,
	},
}
