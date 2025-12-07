local icons = require("util.icons")

local function open_win_config_func()
    local scr_w = vim.opt.columns:get()
    local scr_h = vim.opt.lines:get()
    local tree_w = math.floor(scr_w * 0.2)
    local tree_h = math.floor(scr_h * 0.85)
    return {
        border = "rounded",
        relative = "editor",
        width = tree_w,
        height = tree_h,
        col = math.floor(scr_w * 0.8),
        row = 1,
    }
end

return {
    -- {
    --     "ahmedkhalf/project.nvim",
    --     lazy = false,
    --     config = function()
    --         require("project_nvim").setup()
    --     end,
    -- },
    {
        "nvim-tree/nvim-tree.lua",
        version = "*",
        cmd = { "NvimTreeToggle", "NvimTreeOpen", "NvimTreeFindFile" },
        dependencies = {
            "nvim-tree/nvim-web-devicons",
            "ahmedkhalf/project.nvim",
        },
        opts = {
            view = {
                signcolumn = "no",
                float = {
                    enable = true,
                    open_win_config = open_win_config_func,
                },
                cursorline = false,
            },
            modified = {
                enable = true,
            },
            renderer = {
                indent_width = 2,
                indent_markers = {
                    enable = true,
                    inline_arrows = true,
                    icons = {
                        corner = icons.ui.ChunkCornerBottomCurve,
                        edge = icons.ui.ChunkVertical,
                        item = icons.ui.ChunkVertical,
                        bottom = icons.ui.ChunkHorizontal,
                        none = " ",
                    },
                },
                icons = {
                    show = {
                        hidden = true,
                        folder_arrow = true,
                        git = true,
                    },
                    git_placement = "after",
                    bookmarks_placement = "after",
                    symlink_arrow = icons.ui.Forward,
                    glyphs = {
                        folder = {
                            arrow_closed = icons.ui.ChevronShortRight,
                            arrow_open = icons.ui.ChevronShortDown,
                            default = icons.ui.Folder,
                            open = icons.ui.FolderOpen,
                            empty = icons.ui.Folder,
                            empty_open = icons.ui.FolderOpen,
                            symlink = icons.ui.FolderSymlink,
                            symlink_open = icons.ui.FolderOpen,
                        },
                        default = icons.ui.File,
                        symlink = icons.ui.Forward,
                        bookmark = icons.ui.BookMark,
                        modified = icons.ui.Pencil,
                        hidden = "",
                        git = {
                            unstaged = icons.git.FileUnstaged,
                            staged = icons.git.FileStaged,
                            unmerged = icons.git.FileUnmerged,
                            untracked = icons.git.FileUntracked,
                            renamed = icons.git.FileRenamed,
                            deleted = icons.git.FileDeleted,
                            ignored = icons.git.FileIgnored,
                        },
                    },
                },
            },
            filters = {
                git_ignored = false,
            },
            hijack_cursor = true,
            sync_root_with_cwd = true,
            respect_buf_cwd = true,
            update_focused_file = {
                enable = true,
                update_root = true,
            },
        },
        config = function(_, opts)
            require("nvim-tree").setup(opts)

            -- Customize NvimTree highlights
            local bg = vim.api.nvim_get_hl(0, { name = "Normal" }).bg
            vim.api.nvim_set_hl(0, "NvimTreeNormalFloat", { bg = bg })
            vim.api.nvim_set_hl(0, "NvimTreeEndOfBuffer", { bg = bg, fg = bg })
            -- vim.api.nvim_set_hl(0, "NvimTreeNormal", { bg = bg })
            -- vim.api.nvim_set_hl(0, "NvimTreeIndentMarker", { bg = bg })
            -- vim.api.nvim_set_hl(0, "NvimTreeSpecialFile", { bg = bg })
            -- vim.api.nvim_set_hl(0, "NvimTreeImageFile", { bg = bg })
            -- vim.api.nvim_set_hl(0, "NvimTreeGitNew", { bg = bg })
            -- vim.api.nvim_set_hl(0, "NvimTreeGitDeleted", { bg = bg })
            -- vim.api.nvim_set_hl(0, "NvimTreeGitDirty", { bg = bg })
            -- vim.api.nvim_set_hl(0, "NvimTreeRootFolder", { bg = bg })
            -- vim.api.nvim_set_hl(0, "NvimTreeVertSplit", { bg = bg })
            -- vim.api.nvim_set_hl(0, "NvimTreeFolderName", { bg = bg })
            -- vim.api.nvim_set_hl(0, "NvimTreeSymlink", { bg = bg })

            -- this one sets for all borders, but I want this anyways so whatever
            vim.api.nvim_set_hl(0, "FloatBorder", { bg = bg })
        end,
    },
}
