local formatters = {
    "clang-format",
    "latexindent",
    "prettier",
    "shfmt",
    "sqlfmt",
    "stylua",
}

return {
    {
        "stevearc/conform.nvim",
        event = { "BufReadPost", "BufNewFile" },
        -- dependencies = {
        --     "williamboman/mason.nvim",
        -- },
        config = function()
            require("conform").setup({
                formatters_by_ft = {
                    javascript = { "prettier" },
                    typescript = { "prettier" },
                    css = { "prettier" },
                    html = { "prettier" },
                    json = { "prettier" },
                    yaml = { "prettier" },
                    lua = { "stylua" },
                    python = { "ruff_format" },
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
    },
    {
        "zapling/mason-conform.nvim",
        event = { "BufReadPost", "BufNewFile", "User MasonLoaded" },
        dependencies = {
            "stevearc/conform.nvim",
        },
        config = function()
            require("mason-conform").setup({
                ensure_installed = formatters,
            })
        end,
    },
}
