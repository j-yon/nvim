local api = vim.api

-- Highlight on yank
api.nvim_create_autocmd("TextYankPost", {
    callback = function()
        vim.highlight.on_yank()
    end,
    group = api.nvim_create_augroup("YankHighlight", { clear = true }),
    pattern = "*",
})
-- Add this autocmd to handle files opened from dashboard
api.nvim_create_autocmd("BufEnter", {
    callback = function()
        local buf = vim.api.nvim_get_current_buf()
        local ft = vim.api.nvim_buf_get_option(buf, "filetype")

        -- If filetype is empty and file exists, force detection
        if ft == "" and vim.fn.filereadable(vim.api.nvim_buf_get_name(buf)) == 1 then
            vim.cmd("filetype detect")
            vim.cmd("doautocmd BufRead")
        end
    end,
})

-- Cancel the snippet session when leaving insert mode.
-- local luasnip = require("luasnip")
-- api.nvim_create_autocmd("ModeChanged", {
--     group = api.nvim_create_augroup("UnlinkSnippetOnModeChange", { clear = true }),
--     pattern = { "s:n", "i:*" },
--     callback = function(event)
--         if luasnip.session and luasnip.session.current_nodes[event.buf] and not luasnip.session.jump_active then
--             luasnip.unlink_current()
--         end
--     end,
-- })

api.nvim_create_autocmd({ "BufWritePost" }, {
    group = api.nvim_create_augroup("lint", { clear = true }),
    callback = function()
        require("lint").try_lint()
    end,
})

-- api.nvim_create_autocmd("BufWritePost", {
--     pattern = "*.tex",
--     command = "silent VimtexCompileSS",
--     desc = "Compile LaTeX",
-- })

-- Set terminal keymaps
function _G.set_terminal_keymaps()
    local opts = { noremap = true }
    vim.api.nvim_buf_set_keymap(0, "t", "<esc>", [[<C-\><C-n>]], opts)
    vim.api.nvim_buf_set_keymap(0, "t", "jk", [[<C-\><C-n>]], opts)
    vim.api.nvim_buf_set_keymap(0, "t", "<C-h>", [[<C-\><C-n><C-W>h]], opts)
    vim.api.nvim_buf_set_keymap(0, "t", "<C-j>", [[<C-\><C-n><C-W>j]], opts)
    vim.api.nvim_buf_set_keymap(0, "t", "<C-k>", [[<C-\><C-n><C-W>k]], opts)
    vim.api.nvim_buf_set_keymap(0, "t", "<C-l>", [[<C-\><C-n><C-W>l]], opts)
end

vim.cmd("autocmd! TermOpen term://* lua set_terminal_keymaps()")

-- Disable git blame in visual mode
api.nvim_create_autocmd("ModeChanged", {
    pattern = "*:[vV\x16]*", -- Entering visual, visual-line, or visual-block
    callback = function()
        if vim.fn.exists(":GitBlameToggle") == 2 then
            vim.cmd("GitBlameToggle")
        end
    end,
})

-- Re-enable when leaving visual mode
api.nvim_create_autocmd("ModeChanged", {
    pattern = "[vV\x16]*:*", -- Leaving visual modes
    callback = function()
        if vim.fn.exists(":GitBlameToggle") == 2 then
            vim.cmd("GitBlameToggle")
        end
    end,
})

-- Treesitter highlighting
api.nvim_create_autocmd("FileType", {
    pattern = {
        "python",
        "c",
        "cpp",
        "sh",
        "lua",
        "sql",
        "make",
        "markdown",
        "toml",
        "yaml",
        "javascript",
        "javascriptreact",
        "typescript",
        "typescriptreact",
        "json",
        "jsonc",
        "rust",
        "go",
        "java",
        "html",
        "css",
        "dockerfile",
        "help",
        "vim",
    },
    callback = function()
        vim.treesitter.start()
    end,
})
