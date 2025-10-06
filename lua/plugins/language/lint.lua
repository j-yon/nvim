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
            local lint = require("lint")

            lint.linters_by_ft = {
                javascript = { "eslint_d" },
                typescript = { "eslint_d" },
                python = { "ruff" },
                bash = { "shellcheck" },
                c = { "cpplint" },
                cpp = { "cpplint" },
                h = { "cpplint" },
                hpp = { "cpplint" },
            }

            lint.linters.ruff = {
                cmd = "ruff",
                name = "ruff-lint",
                stdin = false,
                args = { "check", "--quiet", "--exit-zero", "--format", "text" },
                ignore_exitcode = true,
                stream = "stdout",
                parser = require("lint.parser").from_errorformat("%f:%l:%c: %m", {
                    source = "ruff",
                    severity = vim.diagnostic.severity.WARN,
                }),
            }
        end,
    },
    {
        "rshkarin/mason-nvim-lint",
        event = { "BufReadPost", "BufNewFile", "User MasonLoaded" },
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
