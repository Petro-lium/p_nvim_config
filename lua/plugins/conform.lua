return {
    {
        "stevearc/conform.nvim",
        lazy = false,
        config = function()
            local conform = require("conform")

            conform.setup({
                formatters_by_ft = {
                    lua = { "stylua" },
                    python = { "ruff_fix", "ruff_format" },
                    html = { "djlint" },
                    javascript = { "prettier" },
                    javascriptreact = { "prettier" },
                    typescript = { "prettier" },
                    typescriptreact = { "prettier" },
                    json = { "prettier" },
                    css = { "prettier" },
                    yaml = { "prettier" },
                    markdown = { "prettier" },
                },
                format_on_save = {
                    timeout_ms = 1000,
                    lsp_fallback = true,
                },
            })

            vim.keymap.set("n", "<leader>gf", function()
                conform.format({ lsp_fallback = true })
            end, { desc = "format: run formatter" })
        end,
    },
}
