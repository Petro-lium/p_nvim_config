return {
  "vim-test/vim-test",
  -- no extra dependencies needed when using Neovim terminal strategy
  config = function()
    -- Use <leader>t as prefix to avoid conflicts with:
    -- <leader>l (LSP: ld, lr), <leader>g (git: gh, gb, gd, gn, gN, ga, gu)
    vim.keymap.set("n", "<leader>tn", ":TestNearest<CR>", { silent = true, desc = "test: nearest" })
    vim.keymap.set("n", "<leader>tf", ":TestFile<CR>", { silent = true, desc = "test: current file" })
    vim.keymap.set("n", "<leader>ta", ":TestSuite<CR>", { silent = true, desc = "test: run suite" })
    vim.keymap.set("n", "<leader>tl", ":TestLast<CR>", { silent = true, desc = "test: run last" })
    vim.keymap.set("n", "<leader>tg", ":TestVisit<CR>", { silent = true, desc = "test: go to test" })
    vim.cmd("let test#strategy = 'neovim'")
  end,
}
