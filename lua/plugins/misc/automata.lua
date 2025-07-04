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
    "eandrju/cellular-automaton.nvim",
    config = function()
        vim.api.nvim_set_hl(0, "MatrixGreen", { fg = "#138c13" })
        vim.api.nvim_set_hl(0, "MatrixDark1", { fg = "#274e30" })
        vim.api.nvim_set_hl(0, "MatrixDark2", { fg = "#0d1c11" })
        vim.api.nvim_set_hl(0, "MatrixGlitch", { fg = "#93c9a1" })
        vim.api.nvim_set_hl(0, "MatrixHead", { fg = "#8ed1cb" })
        vim.api.nvim_set_hl(0, "MatrixTail", { fg = "#425842" })

        require("cellular-automaton").register_animation({
            fps = 50,
            name = "slide",
            update = function(grid)
                for i = 1, #grid do
                    local prev = grid[i][#grid[i]]
                    for j = 1, #grid[i] do
                        grid[i][j], prev = prev, grid[i][j]
                    end
                end
                return true
            end,
        })

        require("cellular-automaton").register_animation({
            fps = 50,
            name = "dissolve",

            update = function(grid)
                for i = 1, #grid do
                    for j = 1, #grid[i] do
                        if math.random() < 0.05 and grid[i][j].char ~= " " then
                            grid[i][j].char = " "
                        end
                    end
                end
                return true
            end,
        })

        require("cellular-automaton").register_animation({
            fps = 10,
            name = "matrix",

            update = function(grid)
                -- highlights
                local all_matrix_hls = { "MatrixGreen", "MatrixDark1", "MatrixDark2", "MatrixGlitch", "MatrixHead", "MatrixTail" }
                local core_matrix_hls = { "MatrixGreen", "MatrixDark1", "MatrixDark2" }
                local function cell_matrix_hl(hls, cell)
                    for i = 1, #hls do
                        if hls[i] == cell.hl_group then
                            return true
                        end
                    end
                    return false
                end

                for col = 1, #grid[1] do
                    for row = #grid, 2, -1 do
                        local cell = grid[row][col]
                        local up_cell = grid[row - 1][col]

                        if up_cell.hl_group == "MatrixHead" then -- update head
                            cell.char = string.char(math.random(33, 126))
                            cell.hl_group = "MatrixHead"
                            up_cell.hl_group = core_matrix_hls[math.random(#core_matrix_hls)]
                        elseif up_cell.hl_group == "MatrixTail" then -- delete after tail
                            cell.hl_group = "MatrixTail"
                            up_cell.char = " "
                            up_cell.hl_group = nil
                        elseif cell.hl_group == "MatrixGlitch" then -- reset glitch
                            cell.hl_group = core_matrix_hls[math.random(#core_matrix_hls)]
                        elseif grid[#grid][col].hl_group == "MatrixHead" then -- remove head at bottom
                            grid[#grid][col].hl_group = core_matrix_hls[math.random(#core_matrix_hls)]
                        elseif grid[#grid][col].hl_group == "MatrixTail" then -- remove tail at bottom
                            grid[#grid][col].char = " "
                            grid[#grid][col].hl_group = nil
                        elseif cell_matrix_hl(all_matrix_hls, cell) then -- random events
                            if math.random() < 0.01 then -- randomly change char
                                cell.char = string.char(math.random(33, 126))
                            elseif math.random() < 0.01 then -- randomly glitch
                                cell.hl_group = "MatrixGlitch"
                            end
                        end
                    end

                    if math.random() < 0.005 then
                        grid[1][col].char = string.char(math.random(33, 126))
                        grid[1][col].hl_group = "MatrixHead"
                    end

                    local hard_term = math.min(50, #grid)
                    local term_row = math.random(hard_term - 20, hard_term)
                    if grid[term_row][col].char ~= " " and cell_matrix_hl(all_matrix_hls, grid[term_row][col]) then
                        grid[1][col].char = " "
                        grid[2][col].hl_group = "MatrixTail"
                    end
                end
                return true
            end,
        })

        local screensaver = function(grid, swapper)
            local get_character_cols = function(row)
                local cols = {}
                for i = 1, #row do
                    if row[i].char ~= " " then
                        table.insert(cols, i)
                    end
                end

                return cols
            end

            for i = 1, #grid do
                local cols = get_character_cols(grid[i])
                if #cols > 0 then
                    local last_col = cols[#cols]
                    local prev = grid[i][last_col]
                    for _, j in ipairs(cols) do
                        prev = swapper(prev, i, j)
                    end
                end
            end
        end

        require("cellular-automaton").register_animation({
            fps = 50,
            name = "screensaver",
            update = function(grid)
                screensaver(grid, function(prev, i, j)
                    grid[i][j], prev = prev, grid[i][j]
                    return prev
                end)

                return true
            end,
        })

        require("cellular-automaton").register_animation({
            fps = 50,
            name = "screensaver_inplace_hl",
            update = function(grid)
                screensaver(grid, function(prev, i, j)
                    grid[i][j].char, prev.char = prev.char, grid[i][j].char
                    return prev
                end)

                return true
            end,
        })

        require("cellular-automaton").register_animation({
            fps = 50,
            name = "screensaver_inplace_char",
            update = function(grid)
                screensaver(grid, function(prev, i, j)
                    grid[i][j].hl_group, prev.hl_group = prev.hl_group, grid[i][j].hl_group
                    return prev
                end)
                return true
            end,
        })

        vim.api.nvim_create_user_command("BeProductive", function()
            vim.cmd("CellularAutomaton " .. animations[math.random(1, #animations)])
        end, {})

        vim.api.nvim_create_user_command("Matrix", function()
            vim.cmd("CellularAutomaton matrix")
        end, {})
    end,
}
