local on_attach = function(client, bufnr)
    local nmap = function(keys, func, desc)
        if desc then
            desc = "LSP: " .. desc
        end
        vim.keymap.set("n", keys, func, { buffer = bufnr, desc = desc })
    end

    nmap("gd", require("telescope.builtin").lsp_definitions, "[G]oto [D]efinition")
    nmap("gr", require("telescope.builtin").lsp_references, "[G]oto [R]eferences")
    nmap("gI", require("telescope.builtin").lsp_implementations, "[G]oto [I]mplementation")

    -- format on save
    if client.server_capabilities.documentFormattingProvider then
        vim.api.nvim_create_autocmd("BufWritePre", {
            group = vim.api.nvim_create_augroup("Format", { clear = true }),
            buffer = bufnr,
            callback = function()
                vim.lsp.buf.format()
            end,
        })
    end
end

-- Needed for clangd
local conda_path = vim.fn.expand("$CONDA_PREFIX/bin")
local conda_cpp_path = conda_path
local os_name = vim.loop.os_uname().sysname
if os_name == "Darwin" then
    conda_cpp_path = conda_cpp_path .. "x86_64-apple-darwin13.4.0-clang++" -- need to check my actual version
elseif os_name == "Linux" then
    conda_cpp_path = conda_cpp_path .. "x86_64-conda-linux-gnu-c++"
else
    conda_cpp_path = "" -- no available cpp path, will cause errors
end

local servers = {
    bashls = {},
    clangd = {},
    cmake = {},
    fortls = {},
    html = {},
    jsonls = {},
    lua_ls = {
        Lua = {
            diagnostics = {
                globals = { "vim" },
            },
            workspace = {
                library = vim.api.nvim_get_runtime_file("", true),
                checkThirdParty = false,
            },
            telemetry = {
                enable = false,
            },
        },
    },
    marksman = {},
    pylsp = {},
    ruff = {},
    sqls = {},
    tailwindcss = {},
    texlab = {},
    ts_ls = {},
    vimls = {},
    yamlls = {},
}

return {
    "neovim/nvim-lspconfig",
    event = { "BufReadPre", "BufNewFile" },
    dependencies = {
        "williamboman/mason.nvim",
        "williamboman/mason-lspconfig.nvim",
        "hrsh7th/cmp-nvim-lsp",
        {
            "folke/lazydev.nvim",
            ft = "lua", -- only load on lua files
            opts = {
                library = {
                    { path = "${3rd}/luv/library", words = { "vim%.uv" } },
                },
            },
        },
        {
            "hrsh7th/nvim-cmp",
            opts = function(_, opts)
                opts.sources = opts.sources or {}
                table.insert(opts.sources, {
                    name = "lazydev",
                    group_index = 0, -- set group index to 0 to skip loading LuaLS completions
                })
            end,
        },
        {
            "j-hui/fidget.nvim",
            opts = {},
        },
    },
    config = function()
        local lspconfig = require("lspconfig")
        local capabilities = require("cmp_nvim_lsp").default_capabilities(vim.lsp.protocol.make_client_capabilities())
        require("lazydev").setup()

        -- Use mason to setup LSPs
        require("mason-lspconfig").setup_handlers({
            function(server)
                lspconfig[server].setup({
                    capabilities = capabilities,
                    on_attach = on_attach,
                    settings = servers[server],
                    filetypes = (servers[server] or {}).filetypes,
                })
            end,
            ["bashls"] = function()
                lspconfig.bashls.setup({
                    capabilities = capabilities,
                    on_attach = on_attach,
                    filetypes = { "sh", "bash", "zsh" },
                })
            end,
            ["clangd"] = function()
                lspconfig.clangd.setup({
                    cmd = {
                        "clangd",
                        "--log=verbose",
                        "--compile-commands-dir=./build",
                        "--query-driver=/usr/bin/g++," .. conda_cpp_path,
                    },
                    capabilities = capabilities,
                })
            end,
            ["lua_ls"] = function()
                lspconfig.lua_ls.setup({
                    capabilities = capabilities,
                    settings = {
                        Lua = {
                            runtime = {
                                version = "LuaJIT",
                                path = vim.split(package.path, ";"),
                            },
                            diagnostics = {
                                globals = { "vim" },
                            },
                            workspace = {
                                library = {
                                    [vim.fn.expand("$VIMRUNTIME/lua")] = true,
                                    [vim.fn.expand("$VIMRUNTIME/lua/vim/lsp")] = true,
                                },
                            },
                        },
                    },
                })
            end,
            ["pylsp"] = function()
                local py_cap = require("cmp_nvim_lsp").default_capabilities(vim.lsp.protocol.make_client_capabilities())
                py_cap.offsetEncoding = "utf-8"
                lspconfig.pylsp.setup({
                    on_attach = on_attach,
                    capabilities = py_cap,
                    settings = {
                        pylsp = {
                            plugins = {
                                black = { enabled = false },
                                isort = { enabled = false },
                                autopep8 = { enabled = false },
                                mccabe = { enabled = false },
                                pylint = { enabled = false },
                                pyflakes = { enabled = false },
                                pycodestyle = { enabled = false },
                                yapf = { enabled = false },
                            },
                        },
                    },
                })
            end,
            ["texlab"] = function()
                lspconfig.texlab.setup({
                    capabilities = capabilities,
                    on_attach = on_attach,
                    settings = {
                        texlab = {
                            rootDirectory = nil,
                            build = {
                                executable = "latexmk",
                                args = { "-pdf", "-interaction=nonstopmode", "-synctex=1", "%f" },
                                onSave = false,
                                forwardSearchAfter = false,
                            },
                            auxDirectory = ".",
                            forwardSearch = {
                                executable = nil,
                                args = {},
                            },
                            chktex = {
                                onOpenAndSave = false,
                                onEdit = false,
                            },
                            diagnosticsDelay = 300,
                            latexFormatter = "latexindent",
                            latexindent = {
                                extra_args = { "-l", vim.fn.expand("$HOME/.indentconfig.yaml"), "-m" },
                            },
                            bibtexFormatter = "texlab",
                            formatterLineLength = 30,
                        },
                    },
                })
            end,
            ["yamlls"] = function()
                lspconfig.yamlls.setup({
                    capabilities = capabilities,
                    on_attach = on_attach,
                    filetypes = { "yaml", "yml" },
                })
            end,
        })
        -- end)
    end,
}
