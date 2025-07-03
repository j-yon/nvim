-- local icons = require("config.icons")

return {
    { -- ascii art
        "MaximilianLloyd/ascii.nvim",
        dependencies = {
            "MunifTanjim/nui.nvim",
        },
    },
    { -- alpha
        "goolord/alpha-nvim",
        event = "VimEnter",
        enabled = false,
        dependencies = {
            "nvim-tree/nvim-web-devicons",
            "nvim-lua/plenary.nvim",
        },
        config = function()
            local alpha = require("alpha")
            local dashboard = require("alpha.themes.dashboard")

            -- Set header
            -- dashboard.section.header.val = require("ascii").get_random("animals", "dinosaurs")
            dashboard.section.header.val = require("ascii").get_random("text", "neovim")

            -- Set menu
            dashboard.section.buttons.val = {
                dashboard.button("e", "  > New File", "<cmd>ene<CR>"),
                dashboard.button("r", "󰈙  > Recent Files", "<cmd>Telescope oldfiles<CR>"),
                dashboard.button("f", "󰱼  > Find File", "<cmd>Telescope find_files<CR>"),
                dashboard.button("g", "  > Find Word", "<cmd>Telescope live_grep<CR>"),
                dashboard.button("t", "  > Toggle file explorer", "<cmd>Oil<CR>"),
                dashboard.button("c", "  > Config", "<cmd>e $MYVIMRC<CR>"),
                dashboard.button("l", "󰒲  > Lazy", "<cmd>Lazy<CR>"),
                dashboard.button("m", "󰓷  > Mason", "<cmd>Mason<CR>"),
                dashboard.button("q", "  > Quit NVIM", "<cmd>qa<CR>"),
            }

            local stats = require("lazy").stats()
            dashboard.section.footer.val = "⚡ Neovim loaded " .. stats.loaded .. "/" .. stats.count .. " plugins in " .. stats.startuptime .. "ms"

            -- Send config to alpha
            alpha.setup(dashboard.opts)

            -- Disable folding on alpha buffer
            vim.cmd([[autocmd FileType alpha setlocal nofoldenable]])
        end,
    },
    { -- dashboard-nvim
        "glepnir/dashboard-nvim",
        event = "VimEnter",
        enabled = true,
        dependencies = {
            "nvim-tree/nvim-web-devicons",
            "nvim-lua/plenary.nvim",
            "rubiin/fortune.nvim",
        },
        opts = function()
            -- weird but needed to add line to end of header
            local ascii = function()
                -- local ascii = require("ascii").get_random("animals", "dinosaurs")
                local ascii = require("ascii").get_random("text", "neovim")
                local _ = vim.list_extend(ascii, { "" })
                return ascii
            end
            local header = ascii()

            local opts = {
                theme = "doom",
                hide = {
                    -- this is taken care of by lualine
                    -- enabling this messes up the actual laststatus setting after loading a file
                    statusline = false,
                },
                config = {
                    header = header,
                    center = {
                        { action = "ene", desc = " New File", icon = " ", key = "n" },
                        { action = "Telescope oldfiles", desc = " Recent Files", icon = " ", key = "r" },
                        { action = "Telescope find_files", desc = " Find File", icon = " ", key = "f" },
                        { action = "Telescope live_grep", desc = " Find Word", icon = " ", key = "g" },
                        { action = "Oil", desc = " Toggle File Explorer", icon = " ", key = "t" },
                        { action = "e $MYVIMRC", desc = " Config", icon = " ", key = "c" },
                        { action = "Lazy", desc = " Lazy", icon = " ", key = "l" },
                        { action = "Mason", desc = " Mason", icon = " ", key = "m" },
                        { action = "qa", desc = " Quit NeoVim", icon = " ", key = "q" },
                    },
                    footer = function()
                        local stats = require("lazy").stats()
                        local footer = {}
                        footer[1] = "⚡ Neovim loaded " .. stats.loaded .. "/" .. stats.count .. " plugins in " .. stats.startuptime .. "ms"
                        footer[2] = ""

                        local fortune = require("fortune").get_fortune()
                        local _ = vim.list_extend(footer, fortune)

                        return footer
                    end,
                },
            }

            for _, button in ipairs(opts.config.center) do
                button.desc = button.desc .. string.rep(" ", 43 - #button.desc)
                button.key_format = "  %s"
            end

            -- close Lazy and re-open when the dashboard is ready
            if vim.o.filetype == "lazy" then
                vim.cmd.close()
                vim.api.nvim_create_autocmd("User", {
                    pattern = "DashboardLoaded",
                    callback = function()
                        require("lazy").show()
                    end,
                })
            end

            return opts
        end,
    },
    { -- btw
        "letieu/btw.nvim",
        event = "VimEnter",
        enabled = false,
        config = function()
            require("btw").setup()
        end,
    },
}
