local keymap = vim.keymap

-- Honestly I don't know
keymap.set({ "n", "v" }, "<Space>", "<Nop>", { silent = true })

-- Remap for dealing with word wrap
-- keymap.set("n", "k", 'v:count == 0 ? "gk" : "k"', { expr = true, silent = true })
-- keymap.set("n", "j", 'v:count == 0 ? "gj" : "j"', { expr = true, silent = true })

-- Diagnostic keymaps
-- keymap.set("n", "<leader>dp", vim.diagnostic.get_prev, { desc = "Go to previous diagnostic message" })
-- keymap.set("n", "<leader>dn", vim.diagnostic.get_next, { desc = "Go to next diagnostic message" })
-- keymap.set("n", "<leader>de", vim.diagnostic.open_float, { desc = "Open floating diagnostic message" })
-- keymap.set("n", "<leader>dq", vim.diagnostic.setloclist, { desc = "Open diagnostics list" })

-- Window keymaps
keymap.set("n", "<C-h>", "<C-w>h", { desc = "Move to left window" })
keymap.set("n", "<C-j>", "<C-w>j", { desc = "Move to lower window" })
keymap.set("n", "<C-k>", "<C-w>k", { desc = "Move to right window" })
keymap.set("n", "<C-l>", "<C-w>l", { desc = "Move to upper window" })

-- Buffer keymaps
keymap.set("n", "<S-x>", "<cmd>bd<CR>", { desc = "Close buffer" })

-- Telescope keymaps
local builtin = require("telescope.builtin")
keymap.set("n", "<leader>?", builtin.oldfiles, { desc = "[?] Find recently opened files" })
keymap.set("n", "<leader><space>", builtin.buffers, { desc = "[ ] Find existing buffers" })
keymap.set("n", "<leader>/", function()
    builtin.current_buffer_fuzzy_find(require("telescope.themes").get_dropdown({
        winblend = 10,
        previewer = false,
    }))
end, { desc = "[/] Fuzzily search in current buffer" })

local function telescope_live_grep_open_files()
    builtin.live_grep({
        grep_open_files = true,
        prompt_title = "Live Grep in Open Files",
    })
end

keymap.set("n", "<leader>s/", telescope_live_grep_open_files, { desc = "[S]earch [/] in Open Files" })
keymap.set("n", "<leader>ss", builtin.builtin, { desc = "[S]earch [S]elect Telescope" })
keymap.set("n", "<leader>sf", builtin.find_files, { desc = "[S]earch [F]iles" })
keymap.set("n", "<leader>sh", builtin.help_tags, { desc = "[S]earch [H]elp" })
keymap.set("n", "<leader>sw", builtin.grep_string, { desc = "[S]earch current [W]ord" })
keymap.set("n", "<leader>sg", builtin.live_grep, { desc = "[S]earch by [G]rep" })
keymap.set("n", "<leader>sG", ":LiveGrepGitRoot<cr>", { desc = "[S]earch by [G]rep on Git Root" })
keymap.set("n", "<leader>sd", builtin.diagnostics, { desc = "[S]earch [D]iagnostics" })
keymap.set("n", "<leader>sr", builtin.resume, { desc = "[S]earch [R]esume" })

keymap.set("n", "<leader>gs", builtin.git_status, { desc = "[G]it [S]tatus" })
keymap.set("n", "<leader>gf", builtin.git_files, { desc = "Search [G]it [F]iles" })
keymap.set("n", "<leader>gc", builtin.git_commits, { desc = "Search [G]it [C]ommits" })
keymap.set("n", "<leader>gb", builtin.git_branches, { desc = "Search [G]it [B]ranches" })

-- Terminal keymaps
keymap.set("n", "<leader>tv", "<cmd>ToggleTerm size=80 direction=vertical<CR>", { desc = "Toggle vertical terminal" })
keymap.set("n", "<leader>th", "<cmd>ToggleTerm size=10 direction=horizontal<CR>", { desc = "Toggle horizontal terminal" })
keymap.set("n", "<leader>tf", "<cmd>ToggleTerm direction=float<CR>", { desc = "Toggle floating terminal" })
keymap.set("n", "<leader>tp", "<cmd>lua _PYTHON_TOGGLE()<CR>", { desc = "Toggle python terminal" })
keymap.set("n", "<leader>tn", "<cmd>lua _NODE_TOGGLE()<CR>", { desc = "Toggle node terminal" })
keymap.set("n", "<leader>ts", "<cmd>lua _SQL_TOGGLE()<CR>", { desc = "Toggle node terminal" })
keymap.set("n", "<leader>tt", "<cmd>lua _HTOP_TOGGLE()<CR>", { desc = "Toggle htop" })

-- Oil keymaps
keymap.set("n", "-", "<cmd>Oil<CR>", { desc = "Open parent directory" })
keymap.set("n", "|", require("oil").toggle_float, { desc = "Open floating parent directory" })

-- Lint/Format keymaps
keymap.set({ "n", "v" }, "<leader>ff", function()
    require("conform").format({
        lsp_fallback = true,
        async = false,
        timeout_ms = 1000,
    })
end, { desc = "Format file or range" })

keymap.set("n", "<leader>fl", function()
    require("lint").try_lint()
end, { desc = "Trigger linting for current file" })

-- Snippet keymaps
keymap.set("s", "<BS>", "<C-O>s")

-- Neorg keymaps
keymap.set("n", "<leader>nn", "<Plug>(neorg.dirman.new-note)", { desc = "Create new Neorg note" })
keymap.set("n", "<leader>ni", "<cmd>Neorg toc<CR>", { desc = "Open Neorg table of contents" })
keymap.set("n", "<leader>nt", "<Plug>(neorg.qol.todo-items.todo.task-done)", { desc = "Set Neorg todo item as done" })
keymap.set("n", "<leader>nT", "<Plug>(neorg.qol.todo-items.todo.task-undone)", { desc = "Set Neorg todo item as undone" })
keymap.set("n", "<leader>nj", "<cmd>Neorg journal today<CR>", { desc = "Open journal for today" })
keymap.set("n", "<leader>nJ", "<cmd>Neorg journal yesterday<CR>", { desc = "Open journal for yesterday" })
keymap.set("n", "<C-.>", "<Plug>(neorg.qol.todo-items.todo.task-cycle)", { desc = "Cycle Neorg todo item status" })

-- Custom function keymaps
keymap.set("n", "<leader>r", function()
    vim.ui.input({ prompt = "Enter command: " }, function(input)
        if input == nil then
            return
        end
        RunTerm(input)
    end)
end, { desc = "Run command in terminal" })
