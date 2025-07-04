return {
    "nvim-neorg/neorg",
    dependencies = {
        "nvim-treesitter",
        {
            "luarocks.nvim",
            opts = {
                rocks = { "magick" }, -- Ensure the magick rock is installed for image processing
            },
        },
        {
            "pysan3/neorg-templates",
            dependencies = { "L3MON4D3/LuaSnip" }, -- Add nvim-treesitter here
        },
        {
            "3rd/image.nvim",
            lazy = true,
            config = function()
                require("image").setup({
                    backend = "kitty",
                    processor = "magick_cli", -- or "magick_rock"
                    integrations = {
                        markdown = {
                            enabled = true,
                            clear_in_insert_mode = false,
                            download_remote_images = true,
                            only_render_image_at_cursor = false,
                            only_render_image_at_cursor_mode = "popup",
                            floating_windows = false, -- if true, images will be rendered in floating markdown windows
                            filetypes = { "markdown", "vimwiki" }, -- markdown extensions (ie. quarto) can go here
                        },
                        neorg = {
                            enabled = true,
                            filetypes = { "norg" },
                        },
                        typst = {
                            enabled = true,
                            filetypes = { "typst" },
                        },
                        html = {
                            enabled = false,
                        },
                        css = {
                            enabled = false,
                        },
                    },
                    max_width = nil,
                    max_height = nil,
                    max_width_window_percentage = nil,
                    max_height_window_percentage = 50,
                    window_overlap_clear_enabled = false, -- toggles images when windows are overlapped
                    window_overlap_clear_ft_ignore = { "cmp_menu", "cmp_docs", "snacks_notif", "scrollview", "scrollview_sign" },
                    editor_only_render_when_focused = false, -- auto show/hide images when the editor gains/looses focus
                    tmux_show_only_in_active_window = false, -- auto show/hide images in the correct Tmux window (needs visual-activity off)
                    hijack_file_patterns = { "*.png", "*.jpg", "*.jpeg", "*.gif", "*.webp", "*.avif" }, -- render image files as images when opened
                })
            end,
        },
    },
    ft = { "norg", "markdown" },
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
