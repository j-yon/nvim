local icons = require("util.icons")

return {
    "snacks.nvim",
    opts = {
        bigfile = {
            enabled = true,
            size = 1.5 * 1024 * 1024, -- 1.5 MB
            line_length = 1000,
        },
        bufdelete = {
            enabled = true,
        },
        notifier = {
            enabled = true,
            timeout = 2000,
            style = "fancy",
        },
        indent = {
            indent = {
                char = icons.ui.BoldLineLeft,
            },
            scope = {
                char = icons.ui.BoldLineLeft,
                only_current = true,
            },
            animate = {
                enabled = false,
            },
        },
        statuscolumn = {
            enabled = true,
            folds = {
                open = true,
                git_hl = true,
            },
        },
        styles = {
            nofification = {
                wo = { wrap = true },
            },
        },
    },
}
