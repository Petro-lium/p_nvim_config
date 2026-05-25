# CLAUDE.md — Neovim Config

Dotfiles for a Python/web development Neovim setup with Catppuccin theme.

## Quick Facts

| Aspect | Detail |
|--------|--------|
| Plugin manager | lazy.nvim |
| Theme | Catppuccin (auto: latte/mocha) |
| Leader key | `<Space>` |
| Background | `light` (Catppuccin latte) |
| Indent | 4 spaces |
| LSP servers | ruff (Python), html, djlint |
| Debug | nvim-dap + debugpy (Python) |
| DB | vim-dadbod + dadbod-ui |

## Project Structure

```
~/.local/share/nvim/          # XDG data (plugins installed here)
~/.config/nvim/               # XDG config (on Linux/macOS)
%LOCALAPPDATA%\nvim\          # Windows config (this repo)
├── init.lua                  # Entry point — bootstraps lazy.nvim, loads vim-options + plugins
├── lua/
│   ├── vim-options.lua       # Core options, leader key, window nav keymaps
│   ├── plugins.lua           # Empty stub (return {}) — kept for lazy.nvim discovery
│   └── plugins/              # One file per plugin or plugin group
│       ├── alpha.lua         # Start screen (ASCII art dashboard)
│       ├── aerial.lua        # Code outline tree
│       ├── catppuccin.lua    # Theme setup (auto light/dark)
│       ├── completions.lua   # nvim-cmp + LuaSnip + sources
│       ├── debugging.lua     # nvim-dap + dap-ui + dap-python
│       ├── git-stuff.lua     # vim-fugitive + gitsigns
│       ├── lualine.lua       # Status line
│       ├── lsp-config.lua    # Mason + lspconfig (ruff, html, djlint)
│       ├── neo-tree.lua      # File explorer + bufferline
│       ├── none-ls.lua       # Formatters (stylua, prettier, djlint)
│       ├── oil.lua           # Directory editing
│       ├── telescope.lua     # Fuzzy finder (fzf-native + ui-select)
│       ├── treesitter.lua    # Syntax highlighting + indent
│       ├── venv-selector.lua # Python venv auto-selection
│       └── vim-dadbod.lua    # Database UI
└── .gitignore
```

## Plugin Management

Manager: [lazy.nvim](https://github.com/folke/lazy.nvim).

### Adding a New Plugin

1. Create `lua/plugins/<name>.lua`
2. Return a lazy.nvim spec table:

```lua
return {
    "owner/repo",
    lazy = false,
    config = function()
        require("plugin").setup({})
    end,
    keys = { { "<leader>x", "<cmd>PluginCmd<cr>", desc = "Plugin command" } },
    event = "VeryLazy",
}
```

### Style Conventions

- **4-space indentation** everywhere
- Prefer explicit `config = function()` over `opts = {}` when keymaps are involved
- Always include `desc = "..."` on keymaps (shows in which-key)
- Group related keymaps with comments
- One logical plugin (or tightly coupled group) per file

## LSP Configuration

Stack: `mason.nvim` → `mason-lspconfig.nvim` → `nvim-lspconfig`

Current servers (in `lua/plugins/lsp-config.lua`):
- **ruff** — Python linting/formatting
- **html** — HTML language support
- **djlint** — HTML template formatting

Add a new server:

```lua
vim.lsp.config('pyright', {
    capabilities = require('cmp_nvim_lsp').default_capabilities()
})
```

LSP keymaps:

| Key | Action |
|-----|--------|
| `K` | Hover documentation |
| `<leader>ld` | Go to definition |
| `<leader>lr` | Find references |
| `<leader>ca` | Code action |

## Formatting (none-ls)

Defined in `lua/plugins/none-ls.lua`:

| Formatter | Language |
|-----------|----------|
| stylua | Lua |
| prettier | JS/JSON/etc |
| djlint | HTML templates |

Trigger: `<leader>gf` → `vim.lsp.buf.format`

## Keymaps Overview

### Window Navigation (vim-options.lua)

| Key | Action |
|-----|--------|
| `<C-h>` | Window left |
| `<C-j>` | Window down |
| `<C-k>` | Window up |
| `<C-l>` | Window right |

### General

| Key | Action |
|-----|--------|
| `<leader>h` | Clear search highlight |

### Telescope (telescope.lua)

| Key | Action |
|-----|--------|
| `<C-p>` | Find files |
| `<leader>fg` | Live grep |
| `<leader><leader>` | Old files |

### Neo-tree (neo-tree.lua)

| Key | Action |
|-----|--------|
| `<C-n>` | Toggle file explorer |
| `<leader>bf` | Open buffers in float |

### Oil (oil.lua)

| Key | Action |
|-----|--------|
| `-` | Toggle directory edit in float |

### Git (git-stuff.lua)

| Key | Action |
|-----|--------|
| `<leader>gh` | Preview hunk |
| `<leader>gb` | Toggle current line blame |
| `<leader>gd` | Diff |
| `<leader>gn` | Next hunk |
| `<leader>gN` | Prev hunk |
| `<leader>ga` | Stage hunk |
| `<leader>gu` | Undo stage hunk |

### Debug (debugging.lua)

| Key | Action |
|-----|--------|
| `<Leader>db` | Toggle breakpoint |
| `<Leader>dc` | Continue |
| `<Leader>dt` | Toggle DAP UI |

### Aerial (aerial.lua)

| Key | Action |
|-----|--------|
| `<leader>o` | Toggle code outline |

### Completions (completions.lua)

| Key | Action |
|-----|--------|
| `<C-Space>` | Trigger completion |
| `<CR>` | Confirm selection |
| `<C-e>` | Abort |
| `<C-b>` | Scroll docs up |
| `<C-f>` | Scroll docs down |

## Adding Language Support

1. Add LSP server in `lua/plugins/lsp-config.lua` via `vim.lsp.config()`
2. Treesitter parsers install automatically (`auto_install = true`)
3. Add formatters/linters to `lua/plugins/none-ls.lua` if needed

## Disabled Plugins (backed up)

Files with `.back` extension — currently disabled:
- `kulala.lua.back` — HTTP client
- `vim-test.lua.back` — Test runner
- `nvim-tmux-navigation.back` — Tmux nav

To re-enable: remove `.back` extension.

## Common Tasks

```
:Lazy              # Plugin status dashboard
:Lazy update       # Update all plugins
:Lazy sync         # Sync after config changes
:TSUpdate          # Update Treesitter parsers
:Mason             # Mason UI (install/manage LSPs)
:Dblast            # Open Dadbod UI (databases)
```

## Notes

- `vim-options.lua` uses `vim.cmd("set ...")` style — matches existing convention
- Swap files disabled (`vim.opt.swapfile = false`)
- Background is `light` — Catppuccin latte applies
- `.venv` auto-detected by venv-selector (Python projects)
- Zig CC is commented out in vim-options.lua (`vim.env.CC = "zig cc"`)
