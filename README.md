# Neovim

![Neovim Screenshot](assets/nvim-startup.png")

Welcome to my Neovim config! This setup is built to be fast, modular, and focused on productivity for development.

## Structure

```
nvim/
├── README.md
├── init.lua
├── lua/
│   ├── plugins/
│   │   ├── code/       -- plugins related to code editing
│   │   ├── editor/     -- plugins related to configuring the editor
│   │   ├── language/   -- plugins for LSP/linting/formatting and autocompletion setup
│   │   ├── ui/         -- plugins related to UI enhancements
│   │   ├── snacks/     -- plugins from the snacks.nvim collection
│   │   └── misc/       -- miscellaneous plugins
│   │   
│   ├── config/         -- configuration files including keymaps, options, and autocommands
│   ├── local/          -- local plugins
│   └── util/           -- utilities
│   
├── templates/          -- custom templates files
└── snippets/           -- custom code snippets
```

## Features

- Modern, minimal UI
- LSP, treesitter, and autocompletion support
- Fast startup with minimal bloat
- Common and custom snippets
- Easy git integration

## Installation

Requirements:
- Latest [stable](https://github.com/neovim/neovim/releases/tag/v0.11.3) or [nightly](https://github.com/neovim/neovim/releases/tag/nightly) Neovim build
- [Git](https://git-scm.com/downloads)
- Optional:
    - [ripgrep](https://github.com/BurntSushi/ripgrep)
    - [fd](https://github.com/sharkdp/fd)

Backup your existing Neovim config if you have one:

```
mv ~/.config/nvim ~/.config/nvim.bak
```

Clone this repository:

```git clone https://github.com/j-yon/nvim.git ~/.config/nvim```

Then, just launch Neovim. Lazy should automatically install all plugins. From here, feel free to customize the setup to your liking.
