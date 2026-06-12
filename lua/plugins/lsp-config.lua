return {
    {
        "williamboman/mason.nvim",
        lazy = false,
        config = function()
            require("mason").setup({
                ui = {
                    icons = {
                        package_installed = "✓",
                        package_pending = "➜",
                        package_uninstalled = "✗"
                    }
                }
            })
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
        dependencies = { "hrsh7th/cmp-nvim-lsp" },
        config = function()
            local capabilities = require('cmp_nvim_lsp').default_capabilities()

            -- Список серверов для автоматической настройки
            local servers = {
                "djlint",
                "html",
                "pyright",
                "ruff",
            }

            for _, server in ipairs(servers) do
                vim.lsp.config(server, {
                    capabilities = capabilities,
                })
            end

            -- Специальная настройка для ruff (если нужны доп. аргументы)
            vim.lsp.config("ruff", {
                capabilities = capabilities,
                settings = {
                    args = {},
                },
            })

            -- Назначаем клавиши ТОЛЬКО при подключении LSP к буферу
            vim.api.nvim_create_autocmd("LspAttach", {
                group = vim.api.nvim_create_augroup("UserLspConfig", {}),
                callback = function(ev)
                    local opts = { buffer = ev.buf }

                    vim.keymap.set("n", "K", vim.lsp.buf.hover, { buffer = ev.buf, desc = "LSP: hover" })
                    vim.keymap.set("n", "<leader>ld", vim.lsp.buf.definition, { buffer = ev.buf, desc = "LSP: Go to definition" })
                    vim.keymap.set("n", "<leader>lr", vim.lsp.buf.references, { buffer = ev.buf, desc = "LSP: Show references" })
                    vim.keymap.set("n", "<leader>ca", vim.lsp.buf.code_action, { buffer = ev.buf, desc = "LSP: Code action" })
                end,
            })
        end,
    },
}

