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
keymap.set("n", "<leader>wv", "<C-w>v", { desc = "Open vertical window" })
keymap.set("n", "<leader>wh", "<C-w>s", { desc = "Open horizontal window" })
keymap.set("n", "<leader>we", "<C-w>=", { desc = "Make splits equal size" })
keymap.set("n", "<leader>wx", "<cmd>close<CR>", { desc = "Close window" })

-- Buffer keymaps
keymap.set("n", "<leader>bn", "<cmd>bn<CR>", { desc = "Next buffer" })
keymap.set("n", "<leader>bp", "<cmd>bp<CR>", { desc = "Previous buffer" })
keymap.set("n", "<leader>bx", "<cmd>bd<CR>", { desc = "Close buffer" })

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

-- Oil keymaps
keymap.set("n", "-", "<cmd>Oil<CR>", { desc = "Open parent directory" })
keymap.set("n", "|", require("oil").toggle_float)

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

-- Custom function keymaps
keymap.set("n", "<leader>r", function()
    vim.ui.input({ prompt = "Enter command: " }, function(input)
        if input == nil then
            return
        end
        RunTerm(input)
    end)
end, { desc = "Run command in terminal" })
