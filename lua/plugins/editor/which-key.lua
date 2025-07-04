local icons = require("util.icons")
return {
    {
        "folke/which-key.nvim",
        opts = {},
        config = function()
            local wk = require("which-key")
            wk.setup({
                preset = "helix",
                -- sort = "alphanum", -- this breaks it for some reason?
                plugins = {
                    spelling = {
                        enabled = true,
                        suggestions = 20,
                    },
                },
            })

            wk.add({
                { "<leader>", name = "Leader" },
                { "<leader>g", name = "[G]it", icon = icons.git.Git },
                { "<leader>s", name = "[S]earch", icon = icons.ui.Search },
                { "<leader>f", name = "[F]ormat/Lint", icon = icons.ui.Tools },
                { "<leader>t", name = "[T]erminal", icon = icons.ui.Terminal },
                { "<leader>x", name = "Trouble", icon = icons.diagnostics.Hint },
                { "<leader>n", name = "[N]eorg", icon = icons.ui.Pencil },

                { "z", name = "Fold", icon = icons.kinds.Collapsed },
                { "g", name = "Go To", icon = icons.ui.BoldArrowRight },
                { '"', name = "Registers", icons.ui.CiruitBoard },
                { "'", name = "Marks", icon = icons.ui.BookMark },
                { "`", name = "Marks", icon = icons.ui.BookMark },
                { "[", name = "Previous" },
                { "]", name = "Next" },
                { "<C-w>", name = "Window", icon = icons.ui.Window },
            })
            -- register which-key VISUAL mode
            -- required for visual <leader>hs (hunk stage) to work
            require("which-key").add({
                mode = "v",
                -- { "<leader>", name = "VISUAL <leader>" },
                { "<leader>H", "Git [H]unk" },
            })

            vim.api.nvim_set_hl(0, "WhichKey", { underline = false })
            vim.api.nvim_set_hl(0, "WhichKeyDesc", { underline = false })
            vim.api.nvim_set_hl(0, "WhichKeyGroup", { underline = false })
            vim.api.nvim_set_hl(0, "WhichKeyValue", { underline = false })
            vim.api.nvim_set_hl(0, "WhichKeySeparator", { underline = false })
            vim.api.nvim_set_hl(0, "WhichKeyFloat", { underline = false })
        end,
    },
}
