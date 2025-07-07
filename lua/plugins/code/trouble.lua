return {
    "folke/trouble.nvim",
    cmd = "Trouble",
    dependencies = {
        "nvim-tree/nvim-web-devicons",
        "folke/snacks.nvim",
    },
    opts = {
        focus = true,
        win = {
            type = "float",
            relative = "editor",
            border = "rounded",
            title = "Diagnostics",
            title_pos = "center",
            position = { 0.8, 0.5 },
            size = { width = 0.9, height = 0.3 },
            zindex = 200,
            wo = {
                winhighlight = "NormalFloat:Normal",
            },
        },
    },
    keys = {
        {
            "<leader>xx",
            "<cmd>Trouble diagnostics toggle<cr>",
            desc = "Diagnostics (Trouble)",
        },
        {
            "<leader>xX",
            "<cmd>Trouble diagnostics toggle filter.buf=0<cr>",
            desc = "Buffer Diagnostics (Trouble)",
        },
        {
            "<leader>xs",
            "<cmd>Trouble symbols toggle focus=false<cr>",
            desc = "Symbols (Trouble)",
        },
        {
            "<leader>xl",
            "<cmd>Trouble lsp toggle focus=false win.position=right<cr>",
            desc = "LSP Definitions / references / ... (Trouble)",
        },
        {
            "<leader>xL",
            "<cmd>Trouble loclist toggle<cr>",
            desc = "Location List (Trouble)",
        },
        {
            "<leader>xQ",
            "<cmd>Trouble qflist toggle<cr>",
            desc = "Quickfix List (Trouble)",
        },
        {
            "<leader>xT",
            "<cmd>Trouble todo toggle filter = {tag = {TODO,FIX,WARN,HACK,PERF,NOTE,TEST}}<cr>",
            desc = "Search Todos (Trouble)",
        },
    },
}
