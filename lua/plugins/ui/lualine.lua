local icons = require("util.icons")

return {
    "nvim-lualine/lualine.nvim",
    -- event = { "VeryLazy" },
    config = function()
        local lualine = require("lualine")

        lualine.setup({
            options = {
                theme = "onedark",
                section_separators = { left = icons.ui.BoldSlashDividerLeft, right = icons.ui.BoldSlashDividerRight },
                component_separators = { left = icons.ui.SlashDividerLeft, right = icons.ui.SlashDividerRight },
                disabled_filetypes = {},
                icons_enabled = true,
            },
            sections = {
                lualine_a = { { "mode" } },
                lualine_b = { { "branch" } },
                -- lualine_b = {
                --     {
                --         "buffers",
                --         show_filename_only = true,
                --         hide_filename_extension = false,
                --         show_modified_status = true,

                --         mode = 0,

                --         max_length = vim.o.columns / 2,

                --         filetype_names = {
                --             TelescopePrompt = "Telescope",
                --             dashboard = "Dashboard",
                --             packer = "Packer",
                --             fzf = "FZF",
                --             alpha = "Alpha",
                --         },

                --         use_mode_colors = false,

                --         symbols = {
                --             modified = " " .. icons.git.FileUnstaged,
                --             alternate_file = "",
                --             directory = icons.ui.FolderOpen,
                --         },
                --     },
                -- },
                lualine_c = {},
                lualine_x = {
                    {
                        "diagnostics",
                        sources = { "nvim_diagnostic" },
                        symbols = {
                            error = icons.diagnostics.BoldError,
                            warn = icons.diagnostics.BoldWarn,
                            info = icons.diagnostics.BoldInfo,
                            hint = icons.diagnostics.BoldHint,
                        },
                    },
                },
                lualine_y = {
                    {
                        "lsp_status",
                        icon = icons.ui.Gear,
                        symbols = {
                            -- Standard unicode symbols to cycle through for LSP progress:
                            spinner = { "⠋", "⠙", "⠹", "⠸", "⠼", "⠴", "⠦", "⠧", "⠇", "⠏" },
                            -- Standard unicode symbol for when LSP is done:
                            done = icons.ui.Check,
                            -- Delimiter inserted between LSP names:
                            separator = " ",
                        },
                    },
                    { "encoding" },
                },
                lualine_z = { { "progress" }, { "location" } },
            },
            inactive_sections = {
                lualine_a = {},
                -- lualine_b = { {
                --     "filename",
                --     file_status = true,
                --     path = 1,
                -- } },
                lualine_b = {},
                lualine_c = {},
                lualine_x = { "location" },
                lualine_y = {},
                lualine_z = {},
            },
            tabline = {},
            -- extensions = { "fugitive" },
        })
    end,
}
