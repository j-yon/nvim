-- Icons to use in the completion menu.
local symbol_kinds = {
    Class = "",
    Color = "",
    Constant = "",
    Constructor = "",
    Enum = "",
    EnumMember = "",
    Event = "",
    Field = "",
    File = "",
    Folder = "",
    Function = "",
    Interface = "",
    Keyword = "",
    Method = "",
    Module = "",
    Operator = "",
    Property = "",
    Reference = "",
    Snippet = "",
    Struct = "",
    Text = "",
    TypeParameter = "",
    Unit = "",
    Value = "",
    Variable = "",
}

return {
    "hrsh7th/nvim-cmp",
    dependencies = {
        -- Snippets and snippet autocompletion
        {
            "L3MON4D3/LuaSnip",
            config = function()
                local types = require("luasnip.util.types")
                require("luasnip.loaders.from_vscode").lazy_load()
                require("luasnip").setup({
                    -- Display a cursor-like placeholder in unvisited nodes of the snippet.
                    ext_opts = {
                        [types.insertNode] = {
                            unvisited = {
                                virt_text = { { "|", "Conceal" } },
                                virt_text_pos = "inline",
                            },
                        },
                        [types.exitNode] = {
                            unvisited = {
                                virt_text = { { "|", "Conceal" } },
                                virt_text_pos = "inline",
                            },
                        },
                    },
                })
            end,
        },
        "saadparwaiz1/cmp_luasnip",

        -- LSP autocompletion
        "hrsh7th/cmp-nvim-lsp",

        -- Adds a number of user-friendly snippets
        "rafamadriz/friendly-snippets",
        "hrsh7th/cmp-path",
    },
    config = function()
        local cmp = require("cmp")
        local luasnip = require("luasnip")
        cmp.setup({
            -- Disable preselect
            preselect = cmp.PreselectMode.None,

            -- Add icons to the completion menu
            formatting = {
                format = function(_, vim_item)
                    vim_item.kind = (symbol_kinds[vim_item.kind] or "") .. "  " .. vim_item.kind
                    return vim_item
                end,
            },
            completion = {
                completeopt = "menu,menuone,noinsert",
            },
            snippet = {
                expand = function(args)
                    luasnip.lsp_expand(args.body)
                end,
            },
            window = {
                -- Make the completion menu bordered.
                completion = cmp.config.window.bordered(),
                documentation = cmp.config.window.bordered(),
            },
            view = {
                -- Explicitly request documentation.
                docs = { auto_open = false },
            },
            mapping = cmp.mapping.preset.insert({
                ["<C-n>"] = cmp.mapping.select_next_item(),
                ["<C-p>"] = cmp.mapping.select_prev_item(),
                ["<C-u>"] = cmp.mapping.scroll_docs(-4),
                ["<C-d>"] = cmp.mapping.scroll_docs(4),
                ["<C-y>"] = cmp.mapping.confirm({
                    behavior = cmp.ConfirmBehavior.Replace,
                    select = true,
                }),
                -- Explicitly request completions.
                ["<C-Space>"] = cmp.mapping.complete(),
                ["<S-BS>"] = cmp.mapping.close(),
                ["<Tab>"] = cmp.mapping(function(fallback)
                    if luasnip.expand_or_locally_jumpable() then
                        luasnip.expand_or_jump()
                    else
                        fallback()
                    end
                end, { "i", "s" }),
                ["<S-Tab>"] = cmp.mapping(function(fallback)
                    if luasnip.expand_or_locally_jumpable(-1) then
                        luasnip.jump(-1)
                    else
                        fallback()
                    end
                end, { "i", "s" }),
                ["<C-e>"] = function()
                    if cmp.visible_docs() then
                        cmp.close_docs()
                    else
                        cmp.open_docs()
                    end
                end,
            }),
            sources = cmp.config.sources({
                { name = "copilot" },
                { name = "nvim_lsp" },
                { name = "luasnip" },
                { name = "path" },
                { name = "buffer" },
            }),
        })
    end,
}
