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
                float = {
                    border = "rounded",
                    win_options = {
                        winhighlight = "NormalFloat:Normal,FloatBorder:Normal",
                    },
                    override = function(conf)
                        conf.col = vim.opt.columns:get()
                        conf.row = 1
                        conf.width = math.floor(vim.opt.columns:get() * 0.2)
                        conf.height = math.floor(vim.opt.lines:get() * 0.85)
                        return conf
                    end,
                },
                confirmation = {
                    border = "rounded",
                    win_options = {
                        winhighlight = "NormalFloat:Normal,FloatBorder:Normal",
                    },
                },
            })
        end,

        -- Lazy loading is not recommended because it is very tricky to make it work correctly in all situations.
        lazy = false,
    },
}
