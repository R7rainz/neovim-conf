# Minimal Neovim Config — Web Dev, Go, Lua

A lightweight, fast Neovim configuration built from scratch with [lazy.nvim](https://github.com/folke/lazy.nvim). No bloat, no AI, no frameworks — just the essentials for TypeScript/JavaScript/React, Go, and Lua development.

## What's Inside

- **blink.cmp** — Fast autocompletion with LSP, path, and buffer sources (snippets disabled)
- **LSP** — TypeScript (vtsls), Go (gopls), Lua (lua_ls), Tailwind CSS, HTML, CSS, Emmet, ESLint
- **Treesitter** — Syntax highlighting and indentation for all supported languages
- **Telescope** — File finding with ripgrep and fzf-native
- **Neo-tree** — File explorer with git status
- **conform.nvim** — Code formatting (stylua for Lua, goimports+gofumpt for Go, prettierd for web)
- **which-key** — Keymap discovery
- **go.nvim** — Go tooling (test, run, build, fill struct, etc.)
- **nvim-colorizer.lua** — Color preview for CSS/Tailwind
- **package-info.nvim** — package.json version management
- **persistence.nvim** — Session management
- **toggleterm.nvim** — Floating terminal
- **rose-pine** — Colorscheme

## Requirements

- **Neovim** >= 0.12.0
- **A Nerd Font** (JetBrainsMono Nerd Font recommended)
- **ripgrep** (for Telescope live grep)
- **Go** (for Go development)
- **Node.js** (for LSP servers)

## Installation

```bash
# Backup existing config
mv ~/.config/nvim ~/.config/nvim.bak

# Clone
git clone git@github.com:R7rainz/neovim-conf.git ~/.config/nvim

# Start Neovim — plugins and LSP servers install automatically
nvim
```

## Structure

```
.config/nvim/
├── init.lua              # Entry point + Neovide config
├── lazy-lock.json        # Plugin version lock
└── lua/
    ├── options.lua       # Editor settings
    ├── keymaps.lua       # Keybindings
    ├── autocmds.lua      # Filetype-specific settings
    ├── bootstrap.lua     # lazy.nvim bootstrap
    └── plugins.lua       # All plugin specs
```

## Key Bindings

| Key | Action |
|-----|--------|
| `<Space>` | Leader key |
| `<leader>ff` | Find files |
| `<leader>fw` | Live grep |
| `<leader>fb` | Find buffers |
| `<Tab>` / `<S-Tab>` | Next/previous buffer |
| `<C-x>` | Close buffer |
| `<leader><tab>` | Neo-tree sidebar |
| `<leader>e` | Neo-tree float |
| `gd` / `gD` / `K` / `gi` / `gr` | LSP navigation |
| `<leader>ca` | LSP code action |
| `<leader>rn` | LSP rename |

## License

MIT
