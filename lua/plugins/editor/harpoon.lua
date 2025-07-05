local normalize_list = function(t)
    local normalized = {}
    for _, v in pairs(t) do
        if v ~= nil then
            table.insert(normalized, v)
        end
    end
    return normalized
end

return {
    {
        "ThePrimeagen/harpoon",
        branch = "harpoon2",
        event = { "BufReadPre", "BufNewFile" },
        dependencies = {
            "folke/snacks.nvim",
        },
        config = function()
            require("harpoon"):setup()
        end,
        keys = function()
            local harpoon = require("harpoon")
            local Snacks = require("snacks")

            local keys = {
                {
                    "<leader>hh",
                    function() -- integrate with snacks picker
                        Snacks.picker({
                            finder = function()
                                local file_paths = {}
                                local list = normalize_list(harpoon:list().items)
                                for _, item in ipairs(list) do
                                    table.insert(file_paths, { text = item.value, file = item.value })
                                end
                                return file_paths
                            end,
                            win = {
                                input = {
                                    keys = { ["dd"] = { "harpoon_delete", mode = { "n", "x" } } },
                                },
                                list = {
                                    keys = { ["dd"] = { "harpoon_delete", mode = { "n", "x" } } },
                                },
                            },
                            actions = {
                                harpoon_delete = function(picker, item)
                                    local to_remove = item or picker:selected()
                                    harpoon:list():remove({ value = to_remove.text })
                                    harpoon:list().items = normalize_list(harpoon:list().items)
                                    picker:find({ refresh = true })
                                end,
                            },
                        })
                    end,
                    desc = "Toggle menu",
                },
                {
                    "<leader>ha",
                    function()
                        require("harpoon"):list():add()
                    end,
                    desc = "Add File",
                },
                {
                    "<leader>hc",
                    function()
                        require("harpoon"):list():clear()
                    end,
                    desc = "Clear All",
                },
                {
                    "<leader>hn",
                    function()
                        require("harpoon"):list():next()
                    end,
                    desc = "Next File",
                },
                {
                    "<leader>hp",
                    function()
                        require("harpoon"):list():prev()
                    end,
                    desc = "Previous File",
                },
            }
            for i = 1, 5 do
                table.insert(keys, {
                    "<leader>" .. i,
                    function()
                        require("harpoon"):list():select(i)
                    end,
                    desc = "Go To Mark " .. i,
                })
            end
            return keys
        end,
    },
}
