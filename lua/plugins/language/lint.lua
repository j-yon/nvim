return {
    "mfussenegger/nvim-lint",
    event = { "BufReadPre", "BufNewFile" },
    config = function()
        require("lint").linters_by_ft = {
            javascript = { "eslint_d" },
            typescript = { "eslint_d" },
            -- python = { "ruff" }, -- not needed with ruff server
            bash = { "shellcheck" },
            c = { "cpplint" },
            cpp = { "cpplint" },
            h = { "cpplint" },
            hpp = { "cpplint" },
        }
    end,
}
