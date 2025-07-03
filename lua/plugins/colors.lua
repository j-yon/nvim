return {
    { -- Gruvbox
        "ellisonleao/gruvbox.nvim",
        enabled = true,
        priority = 1000,
        name = "gruvbox",
        config = function()
            vim.cmd.colorscheme("gruvbox")
        end,
    },
    { -- Catppuccin
        "catppuccin/nvim",
        enabled = false,
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
        lazy = false,
        priority = 1000,
        name = "onedark",
        config = function()
            require("onedark").setup({
                style = "darker",
            })
            -- vim.cmd.colorscheme("onedark")
        end,
    },
    { -- TokyoNight
        "folke/tokyonight.nvim",
        enabled = false,
        priority = 1000,
        config = function()
            require("tokyonight").setup({
                style = "moon",
            })
            -- vim.cmd.colorscheme("tokyonight")
        end,
    },
}
