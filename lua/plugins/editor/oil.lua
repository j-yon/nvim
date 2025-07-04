return {
    {
        "stevearc/oil.nvim",
        ---@module 'oil'
        ---@type oil.SetupOpts
        opts = {},
        -- Optional dependencies
        dependencies = { { "echasnovski/mini.icons", opts = {} } },
        config = function()
            require("oil").setup({
                column = { "icon" },
                keymaps = {
                    ["<C-h>"] = false,
                    -- ["<M-h>"] = "actions.select_split",
                },
                view_options = {
                    show_hidden = true,
                },
            })
        end,

        -- Lazy loading is not recommended because it is very tricky to make it work correctly in all situations.
        lazy = false,
    },
}
