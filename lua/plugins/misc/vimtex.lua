return {
    "lervag/vimtex",
    ft = { "tex", "plaintex", "latex" },
    -- lazy = false, -- we don't want to lazy load VimTeX
    -- tag = "v2.15", -- uncomment to pin to a specific release
    config = function()
        vim.g.vimtex_view_general_viewer = "okular"
        vim.cmd([[
            let g:vimtex_quickfix_open_on_warning = 0
        ]])

        vim.g.vimtex_format_enabled = 1
    end,
}
