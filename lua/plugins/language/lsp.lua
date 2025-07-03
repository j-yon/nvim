local servers = {
    "basedpyright",
    "bashls",
    "clangd",
    "cmake",
    "html",
    "jsonls",
    "lua_ls",
    "sqls",
    "tailwindcss",
    "texlab",
    "ts_ls",
    "vimls",
    "yamlls",
}

return {
    {
        "neovim/nvim-lspconfig",
        event = { "BufReadPost", "BufNewFile" },
        -- dependencies = {
        --     "williamboman/mason.nvim",
        -- },
        config = function()
            vim.lsp.config("*", {
                capabilities = vim.lsp.protocol.make_client_capabilities(),
            })
        end,
    },
    {
        "williamboman/mason-lspconfig.nvim",
        event = "User MasonLoaded",
        dependencies = {
            "neovim/nvim-lspconfig",
        },
        config = function()
            require("mason-lspconfig").setup({
                ensure_installed = servers,
            })
        end,
    },
}
