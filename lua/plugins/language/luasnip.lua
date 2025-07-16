return {
    "L3MON4D3/LuaSnip",
    event = { "InsertEnter" },
    config = function()
        local types = require("luasnip.util.types")
        require("luasnip.loaders.from_vscode").lazy_load()
        require("luasnip.loaders.from_snipmate").lazy_load()
        require("luasnip.loaders.from_lua").load({ paths = vim.fn.stdpath("config") .. "/snippets/" })
        require("luasnip").setup({
            -- Display a cursor-like placeholder in unvisited nodes of the snippet.
            delete_check_events = "TextChanged",
            ext_opts = {
                [types.choiceNode] = {
                    active = {
                        virt_text = { { "●", "GruvboxOrange" } },
                    },
                },
                [types.insertNode] = {
                    active = {
                        virt_text = { { "●", "GruvboxBlue" } },
                    },
                },
            },
        })
    end,
}
