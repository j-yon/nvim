local keymap = vim.keymap

-- Honestly I don't know
keymap.set({ "n", "v" }, "<Space>", "<Nop>", { silent = true })

-- Remap for dealing with word wrap
-- keymap.set("n", "k", 'v:count == 0 ? "gk" : "k"', { expr = true, silent = true })
-- keymap.set("n", "j", 'v:count == 0 ? "gj" : "j"', { expr = true, silent = true })

-- Exit insert easily
keymap.set("i", "kj", "<Esc>", { desc = "Exit insert mode with kj" })

-- Window keymaps
keymap.set("n", "<C-h>", "<C-w>h", { desc = "Move to left window" })
keymap.set("n", "<C-j>", "<C-w>j", { desc = "Move to lower window" })
keymap.set("n", "<C-k>", "<C-w>k", { desc = "Move to right window" })
keymap.set("n", "<C-l>", "<C-w>l", { desc = "Move to upper window" })

-- Buffer keymaps
keymap.set("n", "<S-x>", "<cmd>bd<CR>", { desc = "Close buffer" })

-- Terminal keymaps
-- keymap.set("n", "<leader>tv", "<cmd>ToggleTerm size=80 direction=vertical<CR>", { desc = "Toggle vertical terminal" })
-- keymap.set("n", "<leader>th", "<cmd>ToggleTerm size=10 direction=horizontal<CR>", { desc = "Toggle horizontal terminal" })
-- keymap.set("n", "<leader>tf", "<cmd>ToggleTerm direction=float<CR>", { desc = "Toggle floating terminal" })
-- keymap.set("n", "<leader>tp", "<cmd>lua _PYTHON_TOGGLE()<CR>", { desc = "Toggle python terminal" })
-- keymap.set("n", "<leader>tn", "<cmd>lua _NODE_TOGGLE()<CR>", { desc = "Toggle node terminal" })
-- keymap.set("n", "<leader>ts", "<cmd>lua _SQL_TOGGLE()<CR>", { desc = "Toggle node terminal" })
-- keymap.set("n", "<leader>tt", "<cmd>lua _HTOP_TOGGLE()<CR>", { desc = "Toggle htop" })
keymap.set("n", "<leader>tt", function()
    require("snacks").terminal.open()
end, { desc = "Toggle terminal" })
keymap.set("n", "<leader>tp", function()
    require("snacks").terminal.open("/usr/bin/python3")
end, { desc = "Toggle python terminal" })
keymap.set("n", "<leader>tn", function()
    require("snacks").terminal.open("node")
end, { desc = "Toggle node terminal" })
keymap.set("n", "<leader>ts", function()
    require("snacks").terminal.open("psql")
end, { desc = "Toggle psql" })
keymap.set("n", "<leader>th", function()
    require("snacks").terminal.open("/opt/homebrew/bin/htop")
end, { desc = "Toggle htop" })

-- Explorer keymaps
keymap.set("n", "-", "<cmd>Oil<CR>", { desc = "Open parent directory" })
keymap.set("n", "|", require("oil").toggle_float, { desc = "Open floating parent directory" })
keymap.set("n", "<leader>e", "<cmd>NvimTreeOpen<CR>", { desc = "Toggle file explorer" })

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
-- keymap.set("n", "<leader>nn", "<Plug>(neorg.dirman.new-note)", { desc = "Create new Neorg note" })
-- keymap.set("n", "<leader>ni", "<cmd>Neorg toc<CR>", { desc = "Open Neorg table of contents" })
-- keymap.set("n", "<leader>nt", "<Plug>(neorg.qol.todo-items.todo.task-done)", { desc = "Set Neorg todo item as done" })
-- keymap.set("n", "<leader>nT", "<Plug>(neorg.qol.todo-items.todo.task-undone)", { desc = "Set Neorg todo item as undone" })
-- keymap.set("n", "<leader>nj", "<cmd>Neorg journal today<CR>", { desc = "Open journal for today" })
-- keymap.set("n", "<leader>nJ", "<cmd>Neorg journal yesterday<CR>", { desc = "Open journal for yesterday" })
-- keymap.set("n", "<C-.>", "<Plug>(neorg.qol.todo-items.todo.task-cycle)", { desc = "Cycle Neorg todo item status" })

-- Custom function keymaps
keymap.set("n", "<leader>rp", RunMainPython, { desc = "Run main python file" })
keymap.set("n", "<leader>rP", UpdateMainPython, { desc = "Update main python file" })
keymap.set("n", "<leader>rs", RunMainBash, { desc = "Run main sh file" })
keymap.set("n", "<leader>rS", UpdateMainBash, { desc = "Update main sh file" })

-- Dashboard command
vim.api.nvim_create_user_command("Dashboard", function()
    require("snacks").dashboard()
end, {})
