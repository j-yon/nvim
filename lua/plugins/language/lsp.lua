local servers = {
    "bashls",
    "clangd",
    "cmake",
    "html",
    "jsonls",
    "lua_ls",
    "pyright",
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

            vim.lsp.config("pyright", {
                capabilities = (function()
                    local capabilities = vim.lsp.protocol.make_client_capabilities()
                    capabilities.textDocument.publishDiagnostics.tagSupport.valueSet = { 2 }
                    return capabilities
                end)(),
                settings = {
                    python = {
                        analysis = {
                            useLibraryCodeForTypes = true,
                            typeCheckingMode = "basic",
                            autoImportCompletions = true,
                            diagnosticSeverityOverrides = {
                                reportUnusedImport = "none", -- or anything
                            },
                        },
                    },
                },
            })

            vim.lsp.config("tailwindcss", {
                filetypes = {
                    -- html
                    "aspnetcorerazor",
                    "astro",
                    "astro-markdown",
                    "blade",
                    "clojure",
                    "django-html",
                    "htmldjango",
                    "edge",
                    "eelixir", -- vim ft
                    "elixir",
                    "ejs",
                    "erb",
                    "eruby", -- vim ft
                    "gohtml",
                    "gohtmltmpl",
                    "haml",
                    "handlebars",
                    "hbs",
                    "html",
                    "htmlangular",
                    "html-eex",
                    "heex",
                    "jade",
                    "leaf",
                    "liquid",
                    -- "markdown",
                    "mdx",
                    "mustache",
                    "njk",
                    "nunjucks",
                    "php",
                    "razor",
                    "slim",
                    "twig",
                    "css",
                    "less",
                    "postcss",
                    "sass",
                    "scss",
                    "stylus",
                    "sugarss",
                    -- js
                    "javascript",
                    "javascriptreact",
                    "reason",
                    "rescript",
                    "typescript",
                    "typescriptreact",
                    -- mixed
                    "vue",
                    "svelte",
                    "templ",
                },
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
