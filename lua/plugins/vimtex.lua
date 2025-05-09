return {
    "lervag/vimtex",
    lazy = false, -- we don't want to lazy load VimTeX
    -- tag = "v2.15", -- uncomment to pin to a specific release
    init = function()
        -- VimTeX configuration goes here, e.g.
        -- vim.g.vimtex_view_method = "okular"
        vim.g.vimtex_view_general_viewer = "okular"
        vim.cmd([[
            let g:vimtex_quickfix_open_on_warning = 0
        ]])

        vim.g.vimtex_format_enabled = 1
        -- vim.g.vimtex_compiler_generic = {
        --     command = "pdflatex",
        -- }
        -- vim.g.vimtex_compiler_method = "arara"
    end,
}
