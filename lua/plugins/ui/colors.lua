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
            })
            vim.cmd.colorscheme("onedark")
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
}
