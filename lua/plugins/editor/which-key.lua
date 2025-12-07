local icons = require("util.icons")
return {
    {
        "folke/which-key.nvim",
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
                -- win = { wo = { winhighlight = "NormalFloat:Normal" } },
            })

            wk.add({
                { "<leader>", name = "Leader" },
                { "<leader>g", name = "[G]it", icon = icons.git.Git },
                { "<leader>s", name = "[S]earch", icon = icons.ui.Search },
                { "<leader>f", name = "[F]ormat/Lint", icon = icons.ui.Tools },
                { "<leader>t", name = "[T]erminal", icon = icons.ui.Terminal },
                { "<leader>x", name = "[X] Trouble", icon = icons.diagnostics.Hint },
                { "<leader>n", name = "[N]eorg", icon = icons.ui.Pencil },
                { "<leader>h", name = "[H]arpoon", icon = icons.ui.Forward },
                { "<leader>r", name = "[R]un", icon = icons.ui.Performance },
                { "<leader>b", name = "[B]uffer", icon = icons.ui.Buffer },

                { "<C-w>", name = "Window", icon = icons.ui.Window },
            })
            -- register which-key VISUAL mode
            -- required for visual <leader>hs (hunk stage) to work
            require("which-key").add({
                mode = "v",
                -- { "<leader>", name = "VISUAL <leader>" },
                { "<leader>H", "Git [H]unk" },
            })

            local bg = vim.api.nvim_get_hl(0, { name = "Normal" }).bg
            local fg1 = vim.api.nvim_get_hl(0, { name = "Question" }).fg
            local fg2 = vim.api.nvim_get_hl(0, { name = "Special" }).fg
            vim.api.nvim_set_hl(0, "WhichKey", { fg = fg1, bg = bg, underline = false })
            vim.api.nvim_set_hl(0, "WhichKeyBorder", { bg = bg, underline = false })
            vim.api.nvim_set_hl(0, "WhichKeyDesc", { bg = bg, underline = false })
            vim.api.nvim_set_hl(0, "WhichKeyGroup", { bg = bg, underline = false })
            vim.api.nvim_set_hl(0, "WhichKeyValue", { bg = bg, underline = false })
            vim.api.nvim_set_hl(0, "WhichKeySeparator", { bg = bg, underline = false })
            vim.api.nvim_set_hl(0, "WhichKeyFloat", { bg = bg, underline = false })
            vim.api.nvim_set_hl(0, "WhichKeyTitle", { fg = fg1, bg = bg, underline = false })
            vim.api.nvim_set_hl(0, "WhichKeyNormal", { bg = bg, underline = false })
            vim.api.nvim_set_hl(0, "WhichKeyIcon", { fg = fg2, bg = bg, underline = false })
        end,
    },
}
