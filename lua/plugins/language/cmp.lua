local source_mapping = {
    nvim_lsp = "[LSP]",
    nvim_lua = "[LUA]",
    luasnip = "[SNIP]",
    buffer = "[BUF]",
    path = "[PATH]",
    treesitter = "[TREE]",
    ["vim-dadbod-completion"] = "[DB]",
}

local function sanitize_snippet(snippet)
    -- Replace ${1:foo} with foo
    snippet = snippet:gsub("%${%d+:([^}]+)}", "%1")
    -- Remove $1, $2, etc.
    snippet = snippet:gsub("%$%d+", "")
    -- Optional: replace ~ or other trailing markers
    snippet = snippet:gsub("~$", "")
    return snippet
end

return {
    "hrsh7th/nvim-cmp",
    event = { "InsertEnter" },
    dependencies = {
        "L3MON4D3/LuaSnip",
        "saadparwaiz1/cmp_luasnip",
        "hrsh7th/cmp-nvim-lsp",
        "hrsh7th/cmp-path",
        "onsails/lspkind-nvim",
        "rafamadriz/friendly-snippets",
    },
    config = function()
        local cmp = require("cmp")
        local types = require("cmp.types")
        local str = require("cmp.utils.str")

        local luasnip = require("luasnip")
        local lspkind = require("lspkind")
        cmp.setup({
            preselect = cmp.PreselectMode.None,
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
                completion = cmp.config.window.bordered({
                    winhighlight = "Normal:Normal,FloatBorder:BorderBG,CursorLine:DiffText,Search:None",
                }),
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
                ["<S-BS>"] = cmp.mapping.close(),
                ["<Tab>"] = cmp.mapping(function(fallback)
                    if luasnip.expand_or_locally_jumpable() then
                        luasnip.expand_or_jump()
                    else
                        fallback()
                    end
                end, { "i", "s" }),
                ["<S-Tab>"] = cmp.mapping(function(fallback)
                    if luasnip.expand_or_locally_jumpable() then
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
            formatting = {
                format = lspkind.cmp_format({
                    mode = "symbol", -- show only symbol annotations
                    maxwidth = {
                        menu = 50, -- leading text (labelDetails)
                        abbr = 50, -- actual suggestion item
                    },
                    ellipsis_char = "...", -- when popup menu exceed maxwidth, the truncated part would show ellipsis_char instead (must define maxwidth first)
                    show_labelDetails = true, -- show labelDetails in menu. Disabled by default

                    before = function(entry, vim_item)
                        local word = entry:get_insert_text()
                        if entry.completion_item.insertTextFormat == types.lsp.InsertTextFormat.Snippet then
                            word = sanitize_snippet(word)
                        end
                        word = str.oneline(word)
                        if entry.completion_item.insertTextFormat == types.lsp.InsertTextFormat.Snippet and string.sub(vim_item.abbr, -1, -1) == "~" then
                            word = word .. "~"
                        end
                        vim_item.abbr = word
                        return vim_item
                    end,
                    menu = source_mapping,
                }),
            },
            sources = cmp.config.sources({
                {
                    name = "luasnip",
                    group_index = 1,
                    option = { use_show_condition = true },
                    entry_filter = function()
                        local context = require("cmp.config.context")
                        return not context.in_treesitter_capture("string") and not context.in_syntax_group("String")
                    end,
                },
                { name = "nvim_lsp", group_index = 2 },
                { name = "nvim_lua", group_index = 3 },
                { name = "treesitter", keyword_length = 4, group_index = 4 },
                { name = "path", keyword_length = 4, group_index = 5 },
                {
                    name = "buffer",
                    keyword_length = 3,
                    group_index = 6,
                    option = {
                        get_bufnrs = function()
                            local bufs = {}
                            for _, win in ipairs(vim.api.nvim_list_wins()) do
                                bufs[vim.api.nvim_win_get_buf(win)] = true
                            end
                            return vim.tbl_keys(bufs)
                        end,
                    },
                },
                { name = "copilot", group_index = 7 },
                { name = "lazydev", keyword_length = 2, group_index = 8 },
            }),
        })
    end,
}
