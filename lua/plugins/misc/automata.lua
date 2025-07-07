-- TODO: add directly to plugin
local animations = {
    "dissolve",
    "game_of_life",
    "make_it_rain",
    "matrix",
    "slide",
    "scramble",
    "screensaver",
    "screensaver_inplace_hl",
    "screensaver_inplace_char",
}

return {
    dir = vim.fn.stdpath("config") .. "/lua/local/cellular-automaton.nvim",
    name = "cellular-automaton.nvim",
    event = { "BufReadPre", "BufNewFile" },
    config = function()
        -- local screensaver = function(grid, swapper)
        --     local get_character_cols = function(row)
        --         local cols = {}
        --         for i = 1, #row do
        --             if row[i].char ~= " " then
        --                 table.insert(cols, i)
        --             end
        --         end

        --         return cols
        --     end

        --     for i = 1, #grid do
        --         local cols = get_character_cols(grid[i])
        --         if #cols > 0 then
        --             local last_col = cols[#cols]
        --             local prev = grid[i][last_col]
        --             for _, j in ipairs(cols) do
        --                 prev = swapper(prev, i, j)
        --             end
        --         end
        --     end
        -- end

        -- require("cellular-automaton").register_animation({
        --     fps = 50,
        --     name = "screensaver",
        --     update = function(grid)
        --         screensaver(grid, function(prev, i, j)
        --             grid[i][j], prev = prev, grid[i][j]
        --             return prev
        --         end)

        --         return true
        --     end,
        -- })

        -- require("cellular-automaton").register_animation({
        --     fps = 50,
        --     name = "screensaver_inplace_hl",
        --     update = function(grid)
        --         screensaver(grid, function(prev, i, j)
        --             grid[i][j].char, prev.char = prev.char, grid[i][j].char
        --             return prev
        --         end)

        --         return true
        --     end,
        -- })

        -- require("cellular-automaton").register_animation({
        --     fps = 50,
        --     name = "screensaver_inplace_char",
        --     update = function(grid)
        --         screensaver(grid, function(prev, i, j)
        --             grid[i][j].hl_group, prev.hl_group = prev.hl_group, grid[i][j].hl_group
        --             return prev
        --         end)
        --         return true
        --     end,
        -- })

        vim.api.nvim_create_user_command("BeProductive", function()
            vim.cmd("CellularAutomaton " .. animations[math.random(1, #animations)])
        end, {})

        vim.api.nvim_create_user_command("Matrix", function()
            vim.cmd("CellularAutomaton matrix")
        end, {})
    end,
}
