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
                enabled = true,
                char = icons.ui.BoldLineLeft,
            },
            animate = {
                enabled = false,
            },
            scope = {
                enabled = true,
                hl = "Include",
            },
            chunk = {
                enabled = true,
                hl = "Include",
                char = {
                    corner_top = icons.ui.ChunkCornerTopCurve,
                    corner_bottom = icons.ui.ChunkCornerBottomCurve,
                    horizontal = icons.ui.ChunkHorizontal,
                    vertical = icons.ui.ChunkVertical,
                    arrow = icons.ui.ChunkHorizontal,
                },
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
