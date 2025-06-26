return {
    {
        "folke/which-key.nvim",
        opts = {},
        config = function()
            require("which-key").add({
                { "<leader>g", name = "[G]it" },
                { "<leader>s", name = "[S]earch" },
                { "<leader>w", name = "[W]indow" },
                { "<leader>b", name = "[B]uffer" },
                { "<leader>f", name = "[F]ormat/Lint" },
                { "<leader>m", name = "[M]arkdown" },
                { "<leader>t", name = "[T]erminal" },
                { "<leader>x", name = "Trouble" },
                { "<leader>n", name = "[N]eorg" },
            })
            -- register which-key VISUAL mode
            -- required for visual <leader>hs (hunk stage) to work
            require("which-key").add({
                mode = "v",
                -- { "<leader>", name = "VISUAL <leader>" },
                { "<leader>H", "Git [H]unk" },
            })
        end,
    },
}
