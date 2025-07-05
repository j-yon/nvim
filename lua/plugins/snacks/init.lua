return {
    "folke/snacks.nvim",
    priority = 1000,
    lazy = false,
    dependencies = { -- needed for dashboard
        "MaximilianLloyd/ascii.nvim",
        "rubiin/fortune.nvim",
    },
    import = "plugins.snacks",
}
