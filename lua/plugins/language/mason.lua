local servers = {
    "bashls",
    "clangd",
    "cmake",
    "fortls",
    "html",
    "jsonls",
    "lua_ls",
    "marksman",
    "pylsp",
    "ruff",
    "sqls",
    "tailwindcss",
    "texlab",
    "ts_ls",
    "vimls",
    "yamlls",
}

local linters = {
    "cpplint",
    "eslint_d",
    "ruff",
    "shellcheck",
}

local formatters = {
    "clang-format",
    "latexindent",
    "prettier",
    "ruff",
    "shfmt",
    "sqlfmt",
    "stylua",
}

local function merge_arrays(t1, t2)
    for i = 1, #t2 do
        t1[#t1 + 1] = t2[i]
    end
    return t1
end

return {
    "williamboman/mason.nvim",
    version = "^1.0.0",
    event = { "BufReadPre", "BufNewFile" },
    dependencies = {
        {
            "williamboman/mason-lspconfig.nvim",
            version = "^1.0.0",
        },
        "WhoIsSethDaniel/mason-tool-installer.nvim",
    },
    config = function()
        local mason = require("mason")
        local mason_lspconfig = require("mason-lspconfig")
        local mason_tool_installer = require("mason-tool-installer")

        mason.setup({
            ui = {
                icons = {
                    package_installed = "✓",
                    package_pending = "➜",
                    package_uninstalled = "✗",
                },
            },
        })

        mason_lspconfig.setup({
            automatic_enable = true,
            ensure_installed = servers,
        })

        mason_tool_installer.setup({
            ensure_installed = merge_arrays(linters, formatters),
        })
    end,
}
