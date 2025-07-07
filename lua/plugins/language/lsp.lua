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
        event = { "BufReadPost", "BufNewFile", "User MasonLoaded" },
        dependencies = {
            "neovim/nvim-lspconfig",
        },
        config = function()
            require("mason-lspconfig").setup({
                ensure_installed = servers,
            })
        end,
    },
    {
        "folke/lazydev.nvim",
        ft = "lua", -- only load on lua files
        opts = {
            library = {
                -- See the configuration section for more details
                -- Load luvit types when the `vim.uv` word is found
                { path = "${3rd}/luv/library", words = { "vim%.uv" } },
            },
        },
    },
}
