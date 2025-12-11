local comment_fg = vim.api.nvim_get_hl(0, { name = "Comment" }).fg
local cursorline_bg = vim.api.nvim_get_hl(0, { name = "CursorLine" }).bg

vim.api.nvim_set_hl(0, "GitBlameVirtualTextCursorLine", {
    fg = comment_fg,
    bg = "#363646",
    italic = true, -- optional, matches typical Comment style
})

return {
    -- {
    --     "tpope/vim-fugitive",
    --     dependencies = {
    --         "tpope/vim-rhubarb", -- for :GBrowse
    --     },
    -- },
    -- {
    --     "lewis6991/gitsigns.nvim",
    --     opts = {
    --         -- See `:help gitsigns.txt`
    --         signs = {
    --             add = { text = "+" },
    --             change = { text = "~" },
    --             delete = { text = "_" },
    --             topdelete = { text = "‾" },
    --             changedelete = { text = "~" },
    --         },
    --         on_attach = function(bufnr)
    --             local gs = package.loaded.gitsigns

    --             local function map(mode, l, r, opts)
    --                 opts = opts or {}
    --                 opts.buffer = bufnr
    --                 vim.keymap.set(mode, l, r, opts)
    --             end

    --             -- Navigation
    --             map({ "n", "v" }, "]c", function()
    --                 if vim.wo.diff then
    --                     return "]c"
    --                 end
    --                 vim.schedule(function()
    --                     gs.next_hunk()
    --                 end)
    --                 return "<Ignore>"
    --             end, { expr = true, desc = "Jump to next hunk" })

    --             map({ "n", "v" }, "[c", function()
    --                 if vim.wo.diff then
    --                     return "[c"
    --                 end
    --                 vim.schedule(function()
    --                     gs.prev_hunk()
    --                 end)
    --                 return "<Ignore>"
    --             end, { expr = true, desc = "Jump to previous hunk" })

    --             -- Actions
    --             -- visual mode
    --             map("v", "<leader>hs", function()
    --                 gs.stage_hunk({ vim.fn.line("."), vim.fn.line("v") })
    --             end, { desc = "stage git hunk" })
    --             map("v", "<leader>hr", function()
    --                 gs.reset_hunk({ vim.fn.line("."), vim.fn.line("v") })
    --             end, { desc = "reset git hunk" })
    --             -- normal mode
    --             map("n", "<leader>hs", gs.stage_hunk, { desc = "git stage hunk" })
    --             map("n", "<leader>hr", gs.reset_hunk, { desc = "git reset hunk" })
    --             map("n", "<leader>hS", gs.stage_buffer, { desc = "git Stage buffer" })
    --             map("n", "<leader>hu", gs.undo_stage_hunk, { desc = "undo stage hunk" })
    --             map("n", "<leader>hR", gs.reset_buffer, { desc = "git Reset buffer" })
    --             map("n", "<leader>hp", gs.preview_hunk_inline, { desc = "preview git hunk" })
    --             map("n", "<leader>hb", function()
    --                 gs.blame_line({ full = false })
    --             end, { desc = "git blame line" })
    --             map("n", "<leader>hd", gs.diffthis, { desc = "git diff against index" })
    --             map("n", "<leader>hD", function()
    --                 gs.diffthis("~")
    --             end, { desc = "git diff against last commit" })

    --             -- Toggles
    --             -- map("n", "<leader>tb", gs.toggle_current_line_blame, { desc = "toggle git blame line" })
    --             -- map("n", "<leader>td", gs.toggle_deleted, { desc = "toggle git show deleted" })
    --         end,
    --     },
    -- },
    {
        "f-person/git-blame.nvim",
        -- load the plugin at startup
        event = "VeryLazy",
        -- Because of the keys part, you will be lazy loading this plugin.
        -- The plugin will only load once one of the keys is used.
        -- If you want to load the plugin at startup, add something like event = "VeryLazy",
        -- or lazy = false. One of both options will work.
        opts = {
            enabled = true, -- if you want to enable the plugin
            message_template = " <author>, <date> • <summary> (<sha>)", -- template for the blame message, check the Message template section for more options
            date_format = "%m-%d-%Y %H:%M:%S", -- template for the date, check Date format section for more options
            virtual_text_column = 1, -- virtual text start column, check Start virtual text at column section for more options
            delay = 0,
            message_when_not_committed = "",
            highlight_group = "GitBlameVirtualTextCursorLine",
        },
    },
}
