vim.cmd("set expandtab")
vim.cmd("set tabstop=4")
vim.cmd("set softtabstop=4")
vim.cmd("set shiftwidth=4")
vim.cmd("set relativenumber")
vim.g.mapleader = " "

vim.opt.swapfile = false

-- Navigate vim panes better
vim.keymap.set("n", "<c-k>", ":wincmd k<CR>", { desc = "window: up" })
vim.keymap.set("n", "<c-j>", ":wincmd j<CR>", { desc = "window: down" })
vim.keymap.set("n", "<c-h>", ":wincmd h<CR>", { desc = "window: left" })
vim.keymap.set("n", "<c-l>", ":wincmd l<CR>", { desc = "window: right" })

-- Terminal escape
vim.keymap.set("t", "<Esc>", [[<C-\><C-n>]], { desc = "terminal: exit to normal mode" })

-- Quick terminal (floating window)
vim.keymap.set("n", "<leader>pt", function()
	Snacks.terminal("powershell -NoExit -ExecutionPolicy Bypass", {
		win = { style = "float", width = 0.7, height = 0.7 },
	})
end, { desc = "terminal: open floating powershell" })

vim.keymap.set("n", "<leader>h", ":nohlsearch<CR>", { desc = "clear search highlight" })
vim.wo.number = true

vim.filetype.add({
	extension = {
		http = "http",
		rest = "http",
	},
})

-- ====================================================
-- Динамические отступы в зависимости от типа файла
-- ====================================================
local indent_group = vim.api.nvim_create_augroup("UserIndentSettings", { clear = true })

-- 4 пробела для Python
vim.api.nvim_create_autocmd("FileType", {
	group = indent_group,
	pattern = "python",
	callback = function()
		vim.opt_local.expandtab = true
		vim.opt_local.tabstop = 4
		vim.opt_local.softtabstop = 4
		vim.opt_local.shiftwidth = 4
	end,
})

-- 2 пробела для JavaScript, TypeScript, Lua и веб-языков
vim.api.nvim_create_autocmd("FileType", {
	group = indent_group,
	pattern = {
		"javascript",
		"javascriptreact",
		"typescript",
		"typescriptreact",
		"lua",
		"html",
		"css",
		"sql",
		"json",
		"yaml",
		"markdown",
	},
	callback = function()
		vim.opt_local.expandtab = true
		vim.opt_local.tabstop = 2
		vim.opt_local.softtabstop = 2
		vim.opt_local.shiftwidth = 2
	end,
})

-- ZIG
-- vim.env.CC = "clang"
