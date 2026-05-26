return {
    {
        "nvim-neotest/neotest",
        dependencies = {
            "nvim-neotest/nvim-nio",
            "nvim-lua/plenary.nvim",
            "nvim-treesitter/nvim-treesitter",
            "antoinemadec/FixCursorHold.nvim",
            "nvim-neotest/neotest-python",
        },
        config = function()
            local neotest = require("neotest")

            neotest.setup({
                python = {
                    args = { "--no-header", "--tb=short", "-s" },
                    runner = "pytest",
                },
                icons = {
                    expanded = "",
                    collapsed = "",
                    running = "",
                    passed = "",
                    failed = "",
                    error = "",
                    skipped = "",
                    unknown = "",
                },
                floating = {
                    border = "rounded",
                    max_height = 0.8,
                    max_width = 0.8,
                },
            })

            -- Neotest keymaps (<leader>nt = "neotest tree")
            vim.keymap.set("n", "<leader>tn", "<cmd>Neotest nearest<CR>", { desc = "test: run nearest" })
            vim.keymap.set("n", "<leader>tf", "<cmd>Neotest file<CR>", { desc = "test: run file" })
            vim.keymap.set("n", "<leader>ta", "<cmd>Neotest suite<CR>", { desc = "test: run suite" })
            vim.keymap.set("n", "<leader>tl", "<cmd>Neotest run <leader>fl<CR>", { desc = "test: run last" })
            vim.keymap.set("n", "<leader>td", "<cmd>Neotest debug nearest<CR>", { desc = "test: debug nearest" })
            vim.keymap.set("n", "<leader>to", "<cmd>Neotest output<CR>", { desc = "test: show output" })
            vim.keymap.set("n", "<leader>ts", "<cmd>Neotest output-pane<CR>", { desc = "test: show output pane" })
            vim.keymap.set("n", "<leader>tt", "<cmd>Neotest summary<CR>", { desc = "test: summary tree" })
        end,
    },
}
