return {
    {
        -- Highlight, edit, and navigate code
        "nvim-treesitter/nvim-treesitter",
        branch = "main",
        lazy = false,
        build = ":TSUpdate",
        dependencies = {
            "nvim-treesitter/nvim-treesitter-textobjects",
            "nvim-treesitter/nvim-treesitter-context",
        },
        config = function()
            -- Add languages to be installed here that you want installed for treesitter
            local ensure_installed = {
                "c",
                "cpp",
                "lua",
                "python",
                "rust",
                "tsx",
                "javascript",
                "typescript",
                "css",
                "html",
                -- "latex",
                "vimdoc",
                "vim",
                "bash",
                "sql",
            }

            local installed = require("nvim-treesitter").get_installed("parsers")
            local to_install = vim.iter(ensure_installed)
                :filter(function(lang)
                    return not vim.tbl_contains(installed, lang)
                end)
                :totable()
            if #to_install > 0 then
                require("nvim-treesitter").install(to_install)
            end

            -- Attach highlighting for any buffer whose language is already installed.
            -- Mirrors the old `auto_install = false`: unlisted languages are not
            -- installed on the fly, only enabled if already present.
            vim.api.nvim_create_autocmd("FileType", {
                callback = function(args)
                    local lang = vim.treesitter.language.get_lang(args.match)
                    if not lang or not vim.treesitter.language.add(lang) then
                        return
                    end
                    vim.treesitter.start(args.buf, lang)
                end,
            })

            -- Incremental selection is now built into Neovim core (0.12+),
            -- see `:h vim.treesitter.select()`.
            vim.keymap.set({ "n", "x" }, "<c-space>", function()
                vim.treesitter.select("parent")
            end, { desc = "Increment treesitter selection" })
            vim.keymap.set("x", "<M-space>", function()
                vim.treesitter.select("child")
            end, { desc = "Decrement treesitter selection" })

            require("nvim-treesitter-textobjects").setup({
                select = {
                    lookahead = true, -- Automatically jump forward to textobj, similar to targets.vim
                    include_surrounding_whitespace = false,
                },
                move = {
                    set_jumps = true, -- whether to set jumps in the jumplist
                },
            })

            local select_ts = require("nvim-treesitter-textobjects.select")
            local move_ts = require("nvim-treesitter-textobjects.move")

            local function select_map(lhs, capture)
                vim.keymap.set({ "x", "o" }, lhs, function()
                    select_ts.select_textobject(capture, "textobjects")
                end)
            end
            select_map("aa", "@parameter.outer")
            select_map("ia", "@parameter.inner")
            select_map("af", "@function.outer")
            select_map("if", "@function.inner")
            select_map("ac", "@class.outer")
            select_map("ic", "@class.inner")

            local function move_map(lhs, fn, capture)
                vim.keymap.set({ "n", "x", "o" }, lhs, function()
                    fn(capture, "textobjects")
                end)
            end
            move_map("]m", move_ts.goto_next_start, "@function.outer")
            move_map("]]", move_ts.goto_next_start, "@class.outer")
            move_map("]M", move_ts.goto_next_end, "@function.outer")
            move_map("][", move_ts.goto_next_end, "@class.outer")
            move_map("[m", move_ts.goto_previous_start, "@function.outer")
            move_map("[[", move_ts.goto_previous_start, "@class.outer")
            move_map("[M", move_ts.goto_previous_end, "@function.outer")
            move_map("[]", move_ts.goto_previous_end, "@class.outer")

            require("treesitter-context").setup({
                enable = true, -- Enable this plugin (Can be enabled/disabled later via commands)
                max_lines = 2, -- How many lines the window should span. Values <= 0 mean no limit.
                trim_scope = "outer", -- Which context lines to trim out of view. Choices: 'inner', 'outer'
                min_window_height = 0, -- Minimum editor window height to enable context
                line_numbers = true, -- Whether to display line numbers
                mode = "cursor", -- Line used to calculate context. Choices: 'cursor', 'topline'
            })
            vim.api.nvim_set_hl(0, "TreesitterContext", { bg = "NONE" })
            vim.api.nvim_set_hl(0, "TreesitterContextLineNumber", { bg = "NONE" })
            vim.api.nvim_set_hl(0, "TreesitterContextSeparator", { bg = "NONE" })
        end,
    },
    {
        "nvim-treesitter/nvim-treesitter-textobjects",
        branch = "main",
        init = function()
            -- Disable built-in ftplugin textobject mappings to avoid conflicts;
            -- we bind our own keymaps in the nvim-treesitter config above.
            vim.g.no_plugin_maps = true
        end,
    },
}
