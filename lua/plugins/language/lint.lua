local linters = {
    "cpplint",
    "eslint_d",
    "ruff",
    "shellcheck",
}

return {
    {
        "mfussenegger/nvim-lint",
        event = { "BufReadPost", "BufNewFile" },
        -- dependencies = {
        --     "williamboman/mason.nvim",
        -- },
        config = function()
            require("lint").linters_by_ft = {
                javascript = { "eslint_d" },
                typescript = { "eslint_d" },
                python = { "ruff" },
                bash = { "shellcheck" },
                c = { "cpplint" },
                cpp = { "cpplint" },
                h = { "cpplint" },
                hpp = { "cpplint" },
            }
        end,
    },
    {
        "rshkarin/mason-nvim-lint",
        event = "User MasonLoaded",
        dependencies = {
            "mfussenegger/nvim-lint",
        },
        config = function()
            require("mason-nvim-lint").setup({
                ensure_installed = linters,
            })
        end,
    },
}
