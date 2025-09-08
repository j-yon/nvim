local animations = {
    "dissolve",
    "game_of_life",
    "make_it_rain",
    "matrix",
    "slide",
    "scramble",
}

return {
    dir = vim.fn.stdpath("config") .. "/lua/local/cellular-automaton.nvim",
    name = "cellular-automaton.nvim",
    event = { "BufReadPre", "BufNewFile" },
    config = function()
        vim.api.nvim_create_user_command("BeProductive", function()
            vim.cmd("CellularAutomaton " .. animations[math.random(1, #animations)])
        end, {})

        vim.api.nvim_create_user_command("Matrix", function()
            vim.cmd("CellularAutomaton matrix")
        end, {})
    end,
}
