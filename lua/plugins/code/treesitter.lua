return {
    {
        -- Highlight, edit, and navigate code
        "nvim-treesitter/nvim-treesitter",
        branch = "main",
        dependencies = {
            -- "nvim-treesitter/nvim-treesitter-textobjects",
            "nvim-treesitter/nvim-treesitter-context",
        },
        lazy = false,
        build = ":TSUpdate",
        config = function()
            require("nvim-treesitter").install({
                "bash",
                "c",
                "cpp",
                "css",
                "dockerfile",
                "go",
                "html",
                "javascript",
                "json",
                "lua",
                "make",
                "markdown",
                "python",
                "regex",
                "rust",
                "sql",
                "toml",
                "typescript",
                "vimdoc",
                "yaml",
            })
            require("treesitter-context").setup({
                enable = true, -- Enable this plugin (Can be enabled/disabled later via commands)
                max_lines = 2, -- How many lines the window should span. Values <= 0 mean no limit.
                trim_scope = "outer", -- Which context lines to trim out of view. Choices: 'inner', 'outer'
                min_window_height = 0, -- Minimum editor window height to enable context
                line_numbers = true, -- Whether to display line numbers
                mode = "cursor", -- Line used to calculate context. Choices: 'cursor', 'topline'
            })
            vim.api.nvim_set_hl(0, "TreesitterContext", { bg = "NONE" })
            vim.api.nvim_set_hl(0, "TreesitterContextLineNumber", { bg = "NONE" })
            vim.api.nvim_set_hl(0, "TreesitterContextSeparator", { bg = "NONE" })
        end,
    },
}
