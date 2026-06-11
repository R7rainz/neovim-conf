# neovim-conf

Personal Neovim configuration built on [NvChad v2.5](https://github.com/NvChad/NvChad).

## Structure

```
init.lua              — Entry point, options, mappings, lazy bootstrap
lua/
├── autocmds.lua      — Loads NvChad's autocmds (FilePost event for LSP)
├── chadrc.lua        — NvChad theme config (pastelbeans)
└── plugins/
    ├── init.lua      — All plugin specs (lspconfig, conform, treesitter, etc.)
    ├── cpp.lua       — C/C++ LSP (clangd) + mason-lspconfig
    └── colorschemes.lua — All available themes
```

## Features

- **LSP**: gopls (Go), clangd (C/C++), vtsls (TypeScript), and more via `nvim-lspconfig`
- **Formatting**: conform.nvim with prettier, gofumpt, clang-format
- **Completion**: blink.cmp (NvChad's native completion)
- **Treesitter**: syntax highlighting for all major languages
- **File explorer**: NvimTree
- **Telescope**: fuzzy finding, live grep, buffers, help tags
- **Themes**: 10+ colorschemes (tokyonight, catppuccin, gruvbox-material, kanagawa, rose-pine, onedark, etc.)

## Theme

Default theme is `pastelbeans` (set in `lua/chadrc.lua`). Switch with `:Telescope themes`.

## Keymaps

| Key | Action |
|-----|--------|
| `<Tab>` / `<S-Tab>` | Next/previous buffer |
| `<C-x>` | Close buffer |
| `<C-h/j/k/l>` | Navigation between panes |
| `<leader>e` | Find files (Telescope float) |
| `<leader>ff` | Find files (cwd) |
| `<leader>fg` | Live grep |
| `<leader>tt/tv/tf` | Terminal (horizontal/vertical/float) |
| `gd` | Go to definition |
| `K` | Hover documentation |
| `<leader>ca` | Code action |
| `<leader>rn` | Rename symbol |
| `<leader>cf` | Format buffer |

## Requirements

- Neovim >= 0.12.0
- Nerd Font
- Git
- Go (for gopls)
- Clangd (for C/C++, install via Mason)

## Install

```sh
git clone git@github.com:R7rainz/neovim-conf.git ~/.config/nvim
nvim --headless "+Lazy! sync" +qa
```
