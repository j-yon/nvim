local api = vim.api

-- Highlight on yank
api.nvim_create_autocmd("TextYankPost", {
    callback = function()
        vim.highlight.on_yank()
    end,
    group = api.nvim_create_augroup("YankHighlight", { clear = true }),
    pattern = "*",
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

-- Function to check line count and disable LSP if above threshold
function Check_line_count()
    local line_count = vim.fn.line("$")
    if line_count > 10000 then
        print("Disabling LSP for large file...")
        vim.lsp.stop_client()
    end
end

-- Automatically check line count on BufEnter event
vim.cmd([[autocmd BufEnter * lua Check_line_count()]])

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

-- Neorg journal
local file_exists_and_is_empty = function(filepath)
    local file = io.open(filepath, "r") -- Open the file in read mode
    if file ~= nil then
        local content = file:read("*all") -- Read the entire content of the file
        file:close() -- Close the file
        return content == "" -- Check if the content is empty
    else
        return false
    end
end

api.nvim_create_autocmd({ "BufNew", "BufNewFile" }, {
    callback = function(args)
        local toc = "index.norg"

        vim.schedule(function()
            if vim.fn.fnamemodify(args.file, ":t") == toc then
                return
            end
            if args.event == "BufNewFile" or (args.event == "BufNew" and file_exists_and_is_empty(args.file)) then
                vim.api.nvim_cmd({ cmd = "Neorg", args = { "templates", "journal" } }, {})
            end
        end)
    end,
    desc = "Load journal entries with template",
    pattern = "/Users/jaden/notes/journal/**/*.norg",
})

api.nvim_create_autocmd({ "BufNew", "BufNewFile" }, {
    callback = function(args)
        local toc = "index.norg"

        vim.schedule(function()
            if vim.fn.fnamemodify(args.file, ":t") == toc then
                return
            end
            if (args.event == "BufNewFile" or (args.event == "BufNew" and file_exists_and_is_empty(args.file))) and not string.find(args.file, "/journal/") then
                vim.api.nvim_cmd({ cmd = "Neorg", args = { "inject-metadata" } }, {})
            end
        end)
    end,
    desc = "Load new workspace entries with a Neorg template",
    pattern = "*.norg",
})
