local icons = require("util.icons")

local function get_startup_text()
    local lazy_stats = require("lazy").stats()
    local ms = (math.floor(lazy_stats.startuptime * 100 + 0.5) / 100)
    local icon = icons.ui.Fire

    local startup_text = {
        { icon, hl = "special" },
        { " Neovim loaded ", hl = "footer" },
        { lazy_stats.loaded .. "/" .. lazy_stats.count, hl = "special" },
        { " plugins in ", hl = "footer" },
        { ms .. "ms", hl = "special" },
    }

    -- local fortune = require("fortune").get_fortune()
    -- for _, line in ipairs(fortune) do
    --     table.insert(startup_text, { "\n" .. line, hl = "special" })
    -- end
    return startup_text
end

math.randomseed(os.time())
local function get_morse_text()
    local morse_text = {
        ".-- .... .- - . ...- . .-. / -.-. --- -- . ... \n -. . -..- - --..-- / .. / -.. --- / -. --- - \n  - .... .. -. -.- / .. - / .. ... / - --- / -... . \n   ..-. . .- .-. . -..",
        "... -.-. .. . -. -.-. . / -.-. --- -- .--. . .-.. ... \n ..- ... / - --- / . -..- .--. .-.. --- -.. . \n  - .... . / ... ..- -.",
        ". - ... / ... .. - / - --- --. . - .... . .-. \n .- -. -.. / .-- .- - -.-. .... / - .... . \n  ... - .- .-. ... / -.. .. .",
        "- .... . / ..- -. .. ...- . .-. ... . \n .. ... --..-- / .- -. -.. / .-- . / .- .-. .",
    }

    return morse_text[math.random(#morse_text)]
end

return {
    { -- ascii art
        "MaximilianLloyd/ascii.nvim",
        dependencies = {
            "MunifTanjim/nui.nvim",
        },
    },
    { -- fortunes
        "rubiin/fortune.nvim",
    },
    { -- dashboard
        "snacks.nvim",
        opts = {
            dashboard = {
                width = 80,
                height = 1,
                pane_gap = 12,
                preset = {
                    -- for single pane dashboard
                    -- header = table.concat(require("ascii").get_random("animals", "dinosaurs"), "\n"),
                    -- header = table.concat(require("ascii").get_random("text", "neovim"), "\n"),
                    -- header = table.concat(require("ascii").art.planets.planets.saturn_plus, "\n"),
                    header = get_morse_text(),
                    -- header = ".-.. . - ... / ... .. - / - --- --. . \n - .... . .-. / .- -. -.. / .-- .- - -.-. .... \n - .... . / ... - .- .-. ... / -.. .. .",
                },

                -- Double pane dashboard
                sections = {
                    -- pane 2: header, keys, recent files, git (if possible)
                    { pane = 2, padding = 3 },
                    { section = "header", align = "left", indent = 30, padding = 25, pane = 2 },
                    { section = "keys", gap = 1, indent = 41, padding = 2, pane = 2 },
                    -- {
                    --     section = "recent_files",
                    --     title = "Recent Files",
                    --     padding = 2,
                    --     pane = 2,
                    -- },
                    -- {
                    --     section = "terminal",
                    --     enabled = require("snacks").git.get_root() ~= nil,
                    --     padding = 1,
                    --     pane = 2,
                    --     ttl = 5 * 60,
                    --     indent = 3,
                    --     height = 10,
                    --     icon = icons.git.Branch,
                    --     title = "Git Status",
                    --     cmd = "git --no-pager diff --stat -B -M -C",
                    -- },
                    -- {
                    --     enabled = require("snacks").git.get_root() == nil,
                    --     padding = 1,
                    --     pane = 2,
                    --     icon = icons.git.Branch,
                    --     title = "Not a fan of version control I see...",
                    -- },
                    function()
                        return {
                            align = "center",
                            pane = 2,
                            padding = 3,
                            indent = 40,
                            text = get_startup_text(),
                        }
                    end,

                    -- pane 1: img, startup
                    { pane = 1, padding = -20 },
                    {
                        section = "terminal",
                        pane = 1,
                        align = "center",
                        indent = -5,
                        width = 120,
                        height = 50,
                        cmd = "$HOME/.local/bin/ascii-image-converter $HOME/.config/nvim/assets/eye.png -C -W 120",
                    },
                },

                -- Single pane dashboard
                -- sections = {
                --     { section = "header", height = 20 },
                --     { section = "keys", gap = 1, padding = 2 },
                --     -- {
                --     --     section = "recent_files",
                --     --     title = "Recent Files",
                --     --     padding = 1,
                --     -- },
                --     {
                --         section = "terminal",
                --         enabled = require("snacks").git.get_root() ~= nil,
                --         padding = 2,
                --         ttl = 5 * 60,
                --         indent = 3,
                --         height = 6,
                --         icon = icons.git.Branch,
                --         title = "Git Status",
                --         cmd = "git --no-pager diff --stat -B -M -C",
                --     },
                --     {
                --         enabled = require("snacks").git.get_root() == nil,
                --         padding = 1,
                --         icon = icons.git.Branch,
                --         title = "Not a fan of version control I see...",
                --     },
                --     function()
                --         return {
                --             align = "center",
                --             text = get_startup_text(),
                --         }
                --     end,
                -- },
            },
        },
    },
}
