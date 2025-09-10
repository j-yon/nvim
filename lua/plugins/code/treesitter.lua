return {
    {
        -- Highlight, edit, and navigate code
        "nvim-treesitter/nvim-treesitter",
        dependencies = {
            "nvim-treesitter/nvim-treesitter-textobjects",
            "nvim-treesitter/nvim-treesitter-context",
        },
        build = ":TSUpdate",
        event = { "BufReadPost", "BufNewFile" },
        config = function()
            require("nvim-treesitter.configs").setup({
                -- Add languages to be installed here that you want installed for treesitter
                ensure_installed = {
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
                },

                -- Autoinstall languages that are not installed. Defaults to false (but you can change for yourself!)
                auto_install = false,
                -- Install languages synchronously (only applied to `ensure_installed`)
                sync_install = false,
                -- List of parsers to ignore installing
                ignore_install = {},
                -- You can specify additional Treesitter modules here: -- For example: -- playground = {--enable = true,-- },
                modules = {},
                -- highlight = { enable = true },
                -- indent = { enable = true },
                incremental_selection = {
                    enable = true,
                    keymaps = {
                        init_selection = "<c-space>",
                        node_incremental = "<c-space>",
                        scope_incremental = "<c-s>",
                        node_decremental = "<M-space>",
                    },
                },
                textobjects = {
                    select = {
                        enable = true,
                        lookahead = true, -- Automatically jump forward to textobj, similar to targets.vim
                        keymaps = {
                            -- You can use the capture groups defined in textobjects.scm
                            ["aa"] = "@parameter.outer",
                            ["ia"] = "@parameter.inner",
                            ["af"] = "@function.outer",
                            ["if"] = "@function.inner",
                            ["ac"] = "@class.outer",
                            ["ic"] = "@class.inner",
                        },
                    },
                    move = {
                        enable = true,
                        set_jumps = true, -- whether to set jumps in the jumplist
                        goto_next_start = {
                            ["]m"] = "@function.outer",
                            ["]]"] = "@class.outer",
                        },
                        goto_next_end = {
                            ["]M"] = "@function.outer",
                            ["]["] = "@class.outer",
                        },
                        goto_previous_start = {
                            ["[m"] = "@function.outer",
                            ["[["] = "@class.outer",
                        },
                        goto_previous_end = {
                            ["[M"] = "@function.outer",
                            ["[]"] = "@class.outer",
                        },
                    },
                    -- swap = {
                    --   enable = true,
                    --   swap_next = {
                    --     ['<leader>a'] = '@parameter.inner',
                    --   },
                    --   swap_previous = {
                    --     ['<leader>A'] = '@parameter.inner',
                    --   },
                    -- },
                },
            })
            require("treesitter-context").setup({
                enable = true, -- Enable this plugin (Can be enabled/disabled later via commands)
                max_lines = 2, -- How many lines the window should span. Values <= 0 mean no limit.
                trim_scope = "outer", -- Which context lines to trim out of view. Choices: 'inner', 'outer'
                min_window_height = 0, -- Minimum editor window height to enable context
                line_numbers = true, -- Whether to display line numbers
                mode = "cursor", -- Line used to calculate context. Choices: 'cursor', 'topline'
            })
        end,
    },
}
