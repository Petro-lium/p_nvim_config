vim.cmd("set expandtab")
vim.cmd("set tabstop=4")
vim.cmd("set softtabstop=4")
vim.cmd("set shiftwidth=4")
vim.cmd("set relativenumber")
vim.g.mapleader = " "
vim.g.background = "light"

vim.opt.swapfile = false

-- Navigate vim panes better
vim.keymap.set('n', '<c-k>', ':wincmd k<CR>', { desc = "window: up" })
vim.keymap.set('n', '<c-j>', ':wincmd j<CR>', { desc = "window: down" })
vim.keymap.set('n', '<c-h>', ':wincmd h<CR>', { desc = "window: left" })
vim.keymap.set('n', '<c-l>', ':wincmd l<CR>', { desc = "window: right" })

vim.keymap.set('n', '<leader>h', ':nohlsearch<CR>', { desc = "clear search highlight" })
vim.wo.number = true

-- ZIG
-- vim.env.CC = "zig cc"
