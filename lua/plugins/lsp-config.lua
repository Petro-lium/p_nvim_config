return {
    {
        "williamboman/mason.nvim",
        lazy = false,
        config = function()
            require("mason").setup(
                {
                    ui = {
                        icons = {
                            package_installed = "✓",
                            package_pending = "➜",
                            package_uninstalled = "✗"
                        }
                    }
                }
            )
        end,
    },
    {
        "williamboman/mason-lspconfig.nvim",
        lazy = false,
        opts = {
            auto_install = true,
        },
    },
    {
        "neovim/nvim-lspconfig",
        lazy = false,
        config = function()
            local capabilities = require('cmp_nvim_lsp').default_capabilities()

            vim.lsp.config('djlint', {
                capabilities = capabilities
            })
            vim.lsp.config('html', {
                capabilities = capabilities
            })
            vim.lsp.config('ruff', {
                capabilities = capabilities,
                init_options = {
                    settings = {
                        args = {},
                    }
                }
            })

            vim.keymap.set("n", "K", vim.lsp.buf.hover, { desc = "LSP: hover" })
            vim.keymap.set("n", "<leader>ld", vim.lsp.buf.definition, { desc = "LSP: Go to definition" })
            vim.keymap.set("n", "<leader>lr", vim.lsp.buf.references, { desc = "LSP: Show references" })
            vim.keymap.set("n", "<leader>ca", vim.lsp.buf.code_action, { desc = "LSP: Code action" })
        end,
    },
}
