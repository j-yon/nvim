return {
    {
        "akinsho/toggleterm.nvim",
        version = "*",
        config = function()
            local Terminal = require("toggleterm.terminal").Terminal
            local node = Terminal:new({ cmd = "node", hidden = true })
            local python = Terminal:new({ cmd = "python3", hidden = true })
            local sql = Terminal:new({ cmd = "psql", hidden = true })
            local htop = Terminal:new({ cmd = "htop", direction = "float", size = 80, hidden = true })

            function _NODE_TOGGLE()
                node:toggle()
            end
            function _PYTHON_TOGGLE()
                python:toggle()
            end
            function _SQL_TOGGLE()
                sql:toggle()
            end
            function _HTOP_TOGGLE()
                htop:toggle()
            end

            require("toggleterm").setup({
                size = 20,
                open_mapping = [[<c-\>]],
                hide_numbers = true,
                shade_filetypes = {},
                shade_terminals = true,
                shading_factor = 2,
                start_in_insert = true,
                insert_mappings = true,
                persist_size = true,
                direction = "float",
                close_on_exit = true,
                shell = vim.o.shell,
                float_opts = {
                    border = "curved",
                    winblend = 0,
                    highlights = {
                        border = "Normal",
                        background = "Normal",
                    },
                },
            })
        end,
    },
}
