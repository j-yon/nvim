return {
    { -- Gruvbox
        "ellisonleao/gruvbox.nvim",
        priority = 1000,
        name = "gruvbox",
        config = function()
            require("gruvbox").setup({
                underline = false,
            })
            -- vim.cmd.colorscheme("gruvbox")
        end,
    },
    { -- Catppuccin
        "catppuccin/nvim",
        priority = 1000,
        name = "catppuccin",
        opts = {
            integrations = {
                mason = true,
                lsp_trouble = true,
                which_key = true,
            },
        },
        config = function()
            require("catppuccin").setup({
                flavour = "macchiato",
                background = {
                    light = "latte",
                    dark = "macchiato",
                },
            })
            -- vim.cmd.colorscheme("catppuccin")
        end,
    },
    { -- OneDark
        "navarasu/onedark.nvim",
        priority = 1000,
        name = "onedark",
        config = function()
            require("onedark").setup({
                style = "darker",
                lualine = {
                    transparent = true,
                },
            })
            -- vim.cmd.colorscheme("onedark")
        end,
    },
    { -- TokyoNight
        "folke/tokyonight.nvim",
        priority = 1000,
        config = function()
            require("tokyonight").setup({
                style = "moon",
            })
            -- vim.cmd.colorscheme("tokyonight")
        end,
    },
    { -- Dracula
        "Mofiqul/dracula.nvim",
        priority = 1000,
        name = "dracula",
        config = function()
            require("dracula").setup({
                -- customize dracula color palette
                colors = {
                    bg = "#282A36",
                    fg = "#F8F8F2",
                    selection = "#44475A",
                    comment = "#6272A4",
                    red = "#FF5555",
                    orange = "#FFB86C",
                    yellow = "#F1FA8C",
                    green = "#50fa7b",
                    purple = "#BD93F9",
                    cyan = "#8BE9FD",
                    pink = "#FF79C6",
                    bright_red = "#FF6E6E",
                    bright_green = "#69FF94",
                    bright_yellow = "#FFFFA5",
                    bright_blue = "#D6ACFF",
                    bright_magenta = "#FF92DF",
                    bright_cyan = "#A4FFFF",
                    bright_white = "#FFFFFF",
                    menu = "#21222C",
                    visual = "#3E4452",
                    gutter_fg = "#4B5263",
                    nontext = "#3B4048",
                    white = "#ABB2BF",
                    black = "#191A21",
                },
                -- show the '~' characters after the end of buffers
                show_end_of_buffer = true, -- default false
                -- use transparent background
                transparent_bg = true, -- default false
                -- set custom lualine background color
                lualine_bg_color = "#44475a", -- default nil
                -- set italic comment
                italic_comment = true, -- default false
                -- overrides the default highlights with table see `:h synIDattr`
                overrides = {},
                -- You can use overrides as table like this
                -- overrides = {
                --   NonText = { fg = "white" }, -- set NonText fg to white
                --   NvimTreeIndentMarker = { link = "NonText" }, -- link to NonText highlight
                --   Nothing = {} -- clear highlight of Nothing
                -- },
                -- Or you can also use it like a function to get color from theme
                -- overrides = function (colors)
                --   return {
                --     NonText = { fg = colors.white }, -- set NonText fg to white of theme
                --   }
                -- end,
            })
            -- vim.cmd.colorscheme("dracula")
        end,
    },
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
                                bg_visual = "#2D4F67",
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
                        NormalDark = { fg = theme.ui.fg_dim, bg = theme.ui.bg_m3 },

                        -- Popular plugins that open floats will link to NormalFloat by default;
                        -- set their background accordingly if you wish to keep them dark and borderless
                        LazyNormal = { bg = theme.ui.bg_m3, fg = theme.ui.fg_dim },
                        MasonNormal = { bg = theme.ui.bg_m3, fg = theme.ui.fg_dim },
                    }
                end,
            })
            vim.cmd.colorscheme("kanagawa")
        end,
    },
}
