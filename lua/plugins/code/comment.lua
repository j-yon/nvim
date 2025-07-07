return {
    {
        "numToStr/Comment.nvim",
        event = { "BufReadPre", "BufNewFile" },
        opts = {
            ignore = "^$",
            toggler = { line = "//" },
            opleader = { line = "//" },
        },
    },
}
