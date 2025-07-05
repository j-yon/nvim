local icons = require("util.icons")

return {
    "snacks.nvim", -- only the name of the plugin needs to be specified since it already exists
    opts = {
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
    },
}
