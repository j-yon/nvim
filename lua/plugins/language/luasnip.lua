return {
    "L3MON4D3/LuaSnip",
    event = { "InsertEnter" },
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
}
