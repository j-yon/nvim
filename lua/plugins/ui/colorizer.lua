return {
    "catgoose/nvim-colorizer.lua",
    event = "BufReadPre",
    opts = {},
    config = function()
        require("colorizer").setup({
            "css",
            "javascript",
            html = {
                mode = "foreground",
            },
            "python",
        })
    end,
}
