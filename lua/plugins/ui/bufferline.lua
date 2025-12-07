local Snacks = require("snacks")
local icons = require("util.icons")

-- Get a specific highlight group's color
-- local function get_hl_color(group, attr)
--     local hl = vim.api.nvim_get_hl(0, { name = group })
--     return hl[attr] and string.format("#%06x", hl[attr]) or nil
-- end

-- Example: get the color from your colorscheme -- not sure what group to grab
-- local bg_color = get_hl_color("Normal", "bg") or "#282c34"
local fg_color = "#cccccc"
local bg_color = "#282c34"
local underline_color = "#537fad"

return {
    {
        "akinsho/bufferline.nvim",
        event = { "BufReadPre", "BufNewFile" },
        dependencies = {
            "nvim-tree/nvim-web-devicons",
        },
        config = function()
            local bufferline = require("bufferline")
            bufferline.setup({
                options = {
                    close_command = function(n)
                        Snacks.bufdelete(n)
                    end,
                    right_mouse_command = function(n)
                        Snacks.bufdelete(n)
                    end,
                    indicator = {
                        style = "underline",
                    },
                    modified_icon = icons.git.FileUnstaged,
                    show_buffer_close_icons = false,
                    separator_style = { "", "" },
                    diagnostics = "nvim_lsp",
                    always_show_bufferline = false,
                    style_preset = bufferline.style_preset.no_italic,
                    numbers = function(opts)
                        return string.format("%s", opts.ordinal)
                    end,
                    diagnostics_indicator = function(count, level, diagnostics_dict, context)
                        local icon = level:match("error") and " " or " "
                        return "" .. icon .. count
                    end,
                },
                -- have to set colors manually
                highlights = {
                    fill = {
                        bg = bg_color,
                    },
                    background = {
                        bg = bg_color,
                    },
                    tab = {
                        bg = bg_color,
                    },
                    tab_selected = {
                        bg = bg_color,
                    },
                    tab_separator = {
                        bg = bg_color,
                    },
                    tab_separator_selected = {
                        bg = bg_color,
                        underline = true,
                        sp = underline_color,
                    },
                    tab_close = {
                        bg = bg_color,
                    },
                    close_button = {
                        bg = bg_color,
                    },
                    close_button_visible = {
                        bg = bg_color,
                    },
                    close_button_selected = {
                        bg = bg_color,
                        underline = true,
                        sp = underline_color,
                    },
                    buffer_visible = {
                        bg = bg_color,
                    },
                    buffer_selected = {
                        bg = bg_color,
                        sp = underline_color,
                        bold = true,
                        underline = true,
                    },
                    numbers = {
                        bg = bg_color,
                    },
                    numbers_visible = {
                        bg = bg_color,
                    },
                    numbers_selected = {
                        bg = bg_color,
                        bold = true,
                        underline = true,
                        sp = underline_color,
                    },
                    diagnostic = {
                        bg = bg_color,
                    },
                    diagnostic_visible = {
                        bg = bg_color,
                    },
                    diagnostic_selected = {
                        bg = bg_color,
                        bold = true,
                        underline = true,
                        sp = underline_color,
                    },
                    hint = {
                        bg = bg_color,
                    },
                    hint_visible = {
                        bg = bg_color,
                    },
                    hint_selected = {
                        bg = bg_color,
                        bold = true,
                        underline = true,
                        sp = underline_color,
                    },
                    hint_diagnostic = {
                        bg = bg_color,
                    },
                    hint_diagnostic_visible = {
                        bg = bg_color,
                    },
                    hint_diagnostic_selected = {
                        bg = bg_color,
                        bold = true,
                        underline = true,
                        sp = underline_color,
                    },
                    info = {
                        bg = bg_color,
                    },
                    info_visible = {
                        bg = bg_color,
                    },
                    info_selected = {
                        bg = bg_color,
                        bold = true,
                        underline = true,
                        sp = underline_color,
                    },
                    info_diagnostic = {
                        bg = bg_color,
                    },
                    info_diagnostic_visible = {
                        bg = bg_color,
                    },
                    info_diagnostic_selected = {
                        bg = bg_color,
                        bold = true,
                        underline = true,
                        sp = underline_color,
                    },
                    warning = {
                        bg = bg_color,
                    },
                    warning_visible = {
                        bg = bg_color,
                    },
                    warning_selected = {
                        bg = bg_color,
                        bold = true,
                        underline = true,
                        sp = underline_color,
                    },
                    warning_diagnostic = {
                        bg = bg_color,
                    },
                    warning_diagnostic_visible = {
                        bg = bg_color,
                    },
                    warning_diagnostic_selected = {
                        bg = bg_color,
                        bold = true,
                        underline = true,
                        sp = underline_color,
                    },
                    error = {
                        bg = bg_color,
                    },
                    error_visible = {
                        bg = bg_color,
                    },
                    error_selected = {
                        bg = bg_color,
                        bold = true,
                        underline = true,
                        sp = underline_color,
                    },
                    error_diagnostic = {
                        bg = bg_color,
                    },
                    error_diagnostic_visible = {
                        bg = bg_color,
                    },
                    error_diagnostic_selected = {
                        bg = bg_color,
                        bold = true,
                        underline = true,
                        sp = underline_color,
                    },
                    modified = {
                        bg = bg_color,
                        fg = fg_color,
                    },
                    modified_visible = {
                        bg = bg_color,
                        fg = fg_color,
                    },
                    modified_selected = {
                        bg = bg_color,
                        fg = fg_color,
                        underline = true,
                        sp = underline_color,
                    },
                    duplicate_selected = {
                        bg = bg_color,
                        italic = true,
                        underline = true,
                        sp = underline_color,
                    },
                    duplicate_visible = {
                        bg = bg_color,
                        italic = true,
                    },
                    duplicate = {
                        bg = bg_color,
                        italic = true,
                    },
                    separator_selected = {
                        bg = bg_color,
                    },
                    separator_visible = {
                        bg = bg_color,
                    },
                    separator = {
                        bg = bg_color,
                    },
                    indicator_visible = {
                        bg = bg_color,
                        sp = underline_color,
                    },
                    indicator_selected = {
                        bg = bg_color,
                        sp = underline_color,
                        underline = true,
                    },
                    pick_selected = {
                        bg = bg_color,
                        bold = true,
                        italic = true,
                        sp = underline_color,
                    },
                    pick_visible = {
                        bg = bg_color,
                        bold = true,
                        italic = true,
                    },
                    pick = {
                        bg = bg_color,
                        bold = true,
                        italic = true,
                    },
                    offset_separator = {
                        bg = bg_color,
                    },
                    trunc_marker = {
                        bg = bg_color,
                    },
                },
            })
        end,
        keys = {
            { "<A-1>", "<cmd>BufferLineGoToBuffer 1<CR>" },
            { "<A-2>", "<cmd>BufferLineGoToBuffer 2<CR>" },
            { "<A-3>", "<cmd>BufferLineGoToBuffer 3<CR>" },
            { "<A-4>", "<cmd>BufferLineGoToBuffer 4<CR>" },
            { "<A-5>", "<cmd>BufferLineGoToBuffer 5<CR>" },
            { "<A-6>", "<cmd>BufferLineGoToBuffer 6<CR>" },
            { "<A-7>", "<cmd>BufferLineGoToBuffer 7<CR>" },
            { "<A-8>", "<cmd>BufferLineGoToBuffer 8<CR>" },
            { "<A-9>", "<cmd>BufferLineGoToBuffer 9<CR>" },
            { "<Leader>bb", "<cmd>BufferLineMovePrev<CR>", desc = "Move back" },
            { "<Leader>bl", "<cmd>BufferLineCloseLeft<CR>", desc = "Close Left" },
            { "<Leader>br", "<cmd>BufferLineCloseRight<CR>", desc = "Close Right" },
            { "<Leader>bn", "<cmd>BufferLineMoveNext<CR>", desc = "Move next" },
            { "<Leader>bp", "<cmd>BufferLinePick<CR>", desc = "Pick Buffer" },
            { "<Leader>bP", "<cmd>BufferLineTogglePin<CR>", desc = "Pin/Unpin Buffer" },
            { "<Leader>bsd", "<cmd>BufferLineSortByDirectory<CR>", desc = "Sort by directory" },
            { "<Leader>bse", "<cmd>BufferLineSortByExtension<CR>", desc = "Sort by extension" },
            { "<Leader>bsr", "<cmd>BufferLineSortByRelativeDirectory<CR>", desc = "Sort by relative dir" },
        },
    },
}
