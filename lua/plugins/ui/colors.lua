return {
    {
        "rebelot/kanagawa.nvim",
        priority = 1000,
        name = "kanagawa",
        config = function()
            require("kanagawa").setup({
                theme = "wave",
                colors = {
                    theme = {
                        all = {
                            ui = {
                                bg_gutter = "none",
                            },
                        },
                        wave = {
                            ui = {
                                bg_visual = "#363646",
                            },
                        },
                    },
                },
                overrides = function(colors)
                    local theme = colors.theme
                    return {
                        NormalFloat = { bg = "none" },
                        FloatBorder = { bg = "none" },
                        FloatTitle = { bg = "none" },

                        -- Save an hlgroup with dark background and dimmed foreground
                        -- so that you can use it where your still want darker windows.
                        -- E.g.: autocmd TermOpen * setlocal winhighlight=Normal:NormalDark
                        NormalDark = { fg = theme.ui.fg_dim, bg = theme.ui.bg_p2 },

                        -- Popular plugins that open floats will link to NormalFloat by default;
                        -- set their background accordingly if you wish to keep them dark and borderless
                        LazyNormal = { bg = theme.ui.bg_p1, fg = theme.ui.fg_dim },
                        MasonNormal = { bg = theme.ui.bg_p1, fg = theme.ui.fg_dim },
                    }
                end,
            })
            vim.cmd.colorscheme("kanagawa")
        end,
    },

    -- transparency
    {
        "xiyaowong/transparent.nvim",
        priority = 1000,
        name = "transparent",
        config = function()
            require("transparent").setup({
                enable = true, -- boolean: enable transparent
                extra_groups = { -- table/string: additional groups that should be cleared
                    -- In particular, when you set it to 'all', that means all groups
                    "BufferLineTabClose",
                    "BufferLineFill",
                    "BufferLineBackground",
                    "BufferLineSeparator",
                    "BufferLineIndicatorSelected",
                },
                exclude_groups = {}, -- table: groups you don't want to clear
            })

            -- require("transparent").clear_prefix("lualine")
        end,
    },
}
