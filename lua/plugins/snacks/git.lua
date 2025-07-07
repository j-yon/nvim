return {
    "snacks.nvim",
    opts = {
        git = {
            enabled = true,
        },
        gitbrowse = {
            enabled = true,
        },
        lazygit = {
            enabled = true,
        },
    },
    keys = {
        {
            "<leader>gB",
            function()
                require("snacks").gitbrowse()
            end,
            desc = "Git browse",
        },

        {
            "<leader>gg",
            function()
                require("snacks").lazygit()
            end,
            desc = "Lazygit",
        },
    },
}
