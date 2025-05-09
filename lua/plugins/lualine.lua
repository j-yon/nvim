return {
  "nvim-lualine/lualine.nvim",
  -- event = { "VeryLazy" },
  config = function()
    local lualine = require "lualine"

    lualine.setup {
      options = {
        theme = "gruvbox",
        section_separators = { left = "", right = "" },
        component_separators = { left = "", right = "" },
        disabled_filetypes = {},
        icons_enabled = true,
      },
      sections = {
        lualine_a = { { "mode" } },
        lualine_b = {
    {
      'buffers',
      show_filename_only = true,
      hide_filename_extension = false,
      show_modified_status = true,

      mode = 0,

      max_length = vim.o.columns * 2 / 3,

      filetype_names = {
        TelescopePrompt = 'Telescope',
        dashboard = 'Dashboard',
        packer = 'Packer',
        fzf = 'FZF',
        alpha = 'Alpha'
      },

      use_mode_colors = false,

      symbols = {
        modified = ' ●',      -- Text to show when the buffer is modified
        alternate_file = '', -- Text to show to identify the alternate file
        directory =  '',     -- Text to show when the buffer is a directory
      },
    }
  },
        lualine_c = { { "branch" } },
        lualine_x = {
          {
            "diagnostics",
            sources = { "nvim_diagnostic" },
            symbols = { error = " ", warn = " ", info = " " },
          },
        },
        lualine_y = { { "progress" } },
        lualine_z = { { "location" } },
      },
      inactive_sections = {
        lualine_a = {},
        lualine_b = { {
          "filename",
          file_status = true,
          path = 1,
        } },
        lualine_c = {},
        lualine_x = { "location" },
        lualine_y = {},
        lualine_z = {},
      },
      tabline = {},
      extensions = { "fugitive" },
    }
  end,
}
