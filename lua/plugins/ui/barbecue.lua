local icons = require("util.icons")
return {
    "utilyre/barbecue.nvim",
    name = "barbecue",
    version = "*",
    event = { "BufReadPre", "BufNewFile" },
    dependencies = {
        "SmiteshP/nvim-navic",
        "nvim-tree/nvim-web-devicons", -- optional dependency
    },
    opts = {
        symbols = {
            separator = icons.ui.ExpandShort,
            modified = icons.git.FileUnstaged,
        },
    },
}
