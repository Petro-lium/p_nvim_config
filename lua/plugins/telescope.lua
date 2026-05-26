return {
    {
        "nvim-telescope/telescope-ui-select.nvim",
    },
    {
        "nvim-telescope/telescope.nvim",
        version = "*",
        dependencies = {
            "nvim-lua/plenary.nvim",
            "nvim-treesitter/nvim-treesitter",
            { "nvim-telescope/telescope-fzf-native.nvim", build = 'make' },
        },
        config = function()
            require("telescope").setup({
                extensions = {
                    ["ui-select"] = {
                        require("telescope.themes").get_dropdown({}),
                    },
                },
            })
            local builtin = require("telescope.builtin")
            vim.keymap.set("n", "<C-p>", builtin.find_files, { desc = "telescope: find files" })
            vim.keymap.set("n", "<leader>fg", builtin.live_grep, { desc = "telescope: live grep" })
            vim.keymap.set("n", "<leader><leader>", builtin.oldfiles, { desc = "telescope: old files" })

            require("telescope").load_extension("ui-select")
        end,
    },
}
