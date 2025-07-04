local icons = require("util.icons")

return {
    { -- ascii art
        "MaximilianLloyd/ascii.nvim",
        lazy = true,
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
            "MaximilianLloyd/ascii.nvim",
        },
        config = function()
            local alpha = require("alpha")
            local dashboard = require("alpha.themes.dashboard")

            -- Set header
            -- dashboard.section.header.val = require("ascii").get_random("animals", "dinosaurs")
            -- dashboard.section.header.val = require("ascii").art.planets.planets.saturn_plus
            dashboard.section.header.val = require("ascii").get_random("text", "neovim")

            -- Set menu
            dashboard.section.buttons.val = {
                dashboard.button("e", icons.ui.FileBold .. " > New File", "<cmd>ene<CR>"),
                dashboard.button("r", icons.ui.FileOld .. " > Recent Files", "<cmd>Telescope oldfiles<CR>"),
                dashboard.button("f", icons.ui.FindFile .. " > Find File", "<cmd>Telescope find_files<CR>"),
                dashboard.button("g", icons.ui.Search .. " > Find Word", "<cmd>Telescope live_grep<CR>"),
                dashboard.button("t", icons.ui.FolderOpen .. " > Toggle file explorer", "<cmd>Oil<CR>"),
                dashboard.button("c", icons.ui.Gear .. " > Config", "<cmd>e $MYVIMRC<CR>"),
                dashboard.button("l", icons.ui.Sleep .. " > Lazy", "<cmd>Lazy<CR>"),
                dashboard.button("m", icons.ui.Package .. " > Mason", "<cmd>Mason<CR>"),
                dashboard.button("q", icons.ui.Quit .. " > Quit NVIM", "<cmd>qa<CR>"),
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
            "MaximilianLloyd/ascii.nvim",
        },
        opts = function()
            -- weird but needed to add line to end of header
            local ascii = function()
                local ascii = { "", "", "" }

                ---@diagnostic disable-next-line: param-type-mismatch
                local _ = vim.list_extend(ascii, require("ascii").get_random("animals", "dinosaurs"))
                -- local _ = vim.list_extend(ascii, require("ascii").get_random("text", "neovim"))
                -- local _ = vim.list_extend(ascii, require("ascii").art.planets.planets.saturn_plus)

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
                        { action = "ene", desc = " New File", icon = icons.ui.FileBold, key = "n" },
                        { action = "Telescope oldfiles", desc = " Recent Files", icon = icons.ui.FileOld, key = "r" },
                        { action = "Telescope find_files", desc = " Find File", icon = icons.ui.FindFile, key = "f" },
                        { action = "Telescope live_grep", desc = " Find Word", icon = icons.ui.Search, key = "g" },
                        { action = "Oil", desc = " Toggle File Explorer", icon = icons.ui.FolderOpen, key = "t" },
                        { action = "e $MYVIMRC", desc = " Config", icon = icons.ui.Gear, key = "c" },
                        { action = "Lazy", desc = " Lazy", icon = icons.ui.Sleep, key = "l" },
                        { action = "Mason", desc = " Mason", icon = icons.ui.Package, key = "m" },
                        { action = "qa", desc = " Quit NeoVim", icon = icons.ui.Quit, key = "q" },
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
