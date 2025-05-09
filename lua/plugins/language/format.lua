return {
    "stevearc/conform.nvim",
    event = { "BufReadPre", "BufNewFile" },
    config = function()
        require("conform").setup({
            formatters_by_ft = {
                javascript = { "prettier" },
                typescript = { "prettier" },
                css = { "prettier" },
                html = { "prettier" },
                json = { "prettier" },
                yaml = { "prettier" },
                markdown = { "prettier" },
                lua = { "stylua" },
                -- python = { "ruff_format" }, -- not needed with ruff server
                sql = { "sqlfmt" },
                bash = { "shfmt" },
                c = { "clang_format" },
                cpp = { "clang_format" },
                h = { "clang_format" },
                hpp = { "clang_format" },
                tex = { "latexindent" },
            },
            format_on_save = {
                lsp_fallback = true,
                async = false,
                timeout_ms = 1000,
            },
        })
    end,
}
