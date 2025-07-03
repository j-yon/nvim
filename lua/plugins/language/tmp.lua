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
    basedpyright = {
        typeCheckingMode = "basic", -- or "strict" or "off"
        analysis = {
            reportUnknownVariableType = "none",
            reportUnknownMemberType = "none",
            reportMissingTypeStubs = "none",
        },
    },
    bashls = {
        filetypes = { "sh", "bash", "zsh" },
    },
    clangd = {},
    cmake = {},
    html = {},
    jsonls = {},
    lua_ls = {},
    sqls = {},
    tailwindcss = {},
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
    ts_ls = {},
    vimls = {},
    yamlls = {},
}

return {
    -- "williamboman/mason-lspconfig.nvim",
    -- event = { "BufReadPre", "BufNewFile" },
    -- dependencies = {
    --     "williamboman/mason.nvim",
    --     "neovim/nvim-lspconfig",
    --     "j-hui/fidget.nvim",
    --     {
    --         "folke/lazydev.nvim",
    --         ft = "lua", -- only load on lua files
    --         opts = {
    --             library = {
    --                 { path = "${3rd}/luv/library", words = { "vim%.uv" } },
    --             },
    --         },
    --     },
    --     {
    --         "hrsh7th/nvim-cmp",
    --         opts = function(_, opts)
    --             opts.sources = opts.sources or {}
    --             table.insert(opts.sources, {
    --                 name = "lazydev",
    --                 group_index = 0, -- set group index to 0 to skip loading LuaLS completions
    --             })
    --         end,
    --     },
    -- },
    -- config = function()
    --     local lspconfig = require("lspconfig")
    --     require("lazydev").setup()

    --     -- Use mason to setup LSPs
    --     -- require("mason-lspconfig").setup_handlers({
    --     --     function(server)
    --     --         lspconfig[server].setup({
    --     --             on_attach = on_attach,
    --     --             settings = {
    --     --                 server = servers[server],
    --     --             },
    --     --             filetypes = (servers[server] or {}).filetypes,
    --     --         })
    --     --     end,
    --     --     ["clangd"] = function()
    --     --         lspconfig.clangd.setup({
    --     --             cmd = {
    --     --                 "clangd",
    --     --                 "--log=verbose",
    --     --                 "--compile-commands-dir=./build",
    --     --                 "--query-driver=/usr/bin/g++," .. conda_cpp_path,
    --     --             },
    --     --         })
    --     --     end,
    --     -- })
    --     -- end)
    -- end,
}
