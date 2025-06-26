return {
    "nvim-neorg/neorg",
    dependencies = {
        "luarocks.nvim",
        "nvim-treesitter",
        {
            "pysan3/neorg-templates",
            dependencies = { "L3MON4D3/LuaSnip" }, -- Add nvim-treesitter here
        },
    },
    lazy = false, -- Disable lazy loading as some `lazy.nvim` distributions set `lazy = true` by default
    version = "*", -- Pin Neorg to the latest stable release
    config = function()
        require("neorg").setup({
            load = {
                ["core.defaults"] = {}, -- Load default Neorg modules
                ["core.concealer"] = {}, -- Enable the concealer module for better visuals
                ["core.latex.renderer"] = {}, -- Register LaTeX support
                ["core.summary"] = {},
                ["core.export.markdown"] = {},
                ["core.export"] = { -- Export functionality for Neorg files
                    config = {
                        formats = { "pdf", "html" }, -- Enable PDF and HTML export
                    },
                },
                ["core.dirman"] = { -- Directory management for Neorg files
                    config = {
                        workspaces = {
                            notes = "~/notes", -- Set your Neorg workspace directory
                        },
                    },
                },
                ["core.completion"] = { -- Enable completion features
                    config = {
                        engine = "nvim-cmp", -- Use nvim-cmp for completion
                    },
                },
                ["external.templates"] = { -- Load external templates
                    config = {
                        templates_dir = vim.fn.stdpath("config") .. "/templates/norg",
                        default_subcommand = "fload",
                        keywords = require("config.templates"),
                    },
                },
            },
        })
    end,
}
