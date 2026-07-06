# AGENTS.md — Neovim Config

Windows-only Neovim dotfiles (`%LOCALAPPDATA%\nvim\`). Plugin manager: lazy.nvim.

For a full reference (all keymaps, every plugin, common tasks) see [`CLAUDE.md`](./CLAUDE.md).

## Repo Structure

```
init.lua                   # bootsrap lazy.nvim, sources vim-options + plugins
lua/
  vim-options.lua          # core options, leader key, window nav keymaps, filetype overrides
  plugins.lua              # stub (return {}), kept for lazy.nvim discovery
  plugins/                 # one file per plugin/group
```

## Adding a Plugin

Create `lua/plugins/<name>.lua` returning a lazy.nvim spec table:

```lua
return {
    "owner/repo",
    lazy = false,
    config = function()
        require("plugin").setup({})
    end,
    keys = { { "<leader>x", "<cmd>PluginCmd<cr>", desc = "..." } },
    event = "VeryLazy",
}
```

Conventions:
- **4-space indentation** everywhere
- Prefer `config = function()` over `opts = {}` when keymaps are involved
- Always include `desc = "..."` on keymaps (which-key integration)
- One logical plugin (or tightly coupled group) per file

## Platform Quirks (Windows)

- Treesitter compiles parsers with MSVC `cl.exe` (not gcc). Ensure `cl` is on PATH.
- neotest-python: pytest result keys use `\` path separators matching neotest's `lib.files.sep` — **do NOT** normalise paths with `gsub("\\", "/")`, it breaks result-key matching.
- diffview.nvim: no nvim-web-devicons; `use_icons = false` in setup.
- LazyGit opened via `Snacks.lazygit()` (not raw terminal).
- Quick terminal: `Snacks.terminal("powershell ...")` via `<leader>pt`.

## Plugin-Specific Details

### LSP (`lsp-config.lua`)
Stack: `mason.nvim` → `mason-lspconfig.nvim` (auto_install=true) → `nvim-lspconfig`
Servers: pyright, ruff, html, djlint. Configured via `vim.lsp.config()`.
LSP keymaps bound on `LspAttach` with `buffer = ev.buf`.

### Formatters (`conform.lua`)
Auto-format on save (1s timeout). Trigger: `<leader>gf`.
| Lang | Formatter |
|------|-----------|
| Python | `ruff_fix`, `ruff_format` |
| Lua | `stylua` |
| JS/TS/CSS/JSON/YAML/MD | `prettier` |
| HTML | `djlint` |
| SQL | `sqlfluff` (`--dialect postgres`) |

### Tests (`neotest.lua`)
neotest-python with pytest (`--no-header --tb=short -s`).
- `<leader>tn` — nearest test
- `<leader>tf` — file tests
- `<leader>ta` — all in project (`vim.fn.getcwd()`)
- `<leader>td` — debug nearest (dap strategy)

### Git (`git-stuff.lua`)
Uses vim-fugitive (`:Git add %`), gitsigns, diffview.nvim.
diffview: `use_icons = false`, opened via `<leader>gD`.

### DAP (`debugging.lua`)
nvim-dap + dap-python (debugpy from Mason). `python = function() return "python" end`.

## Key Leader Shortcuts

| Key | Plugin | Action |
|-----|--------|--------|
| `<C-p>` | telescope | Find files |
| `<leader>fg` | telescope | Live grep |
| `<leader><leader>` | telescope | Old files |
| `<C-n>` | neo-tree | Toggle file tree |
| `-` | oil | Dir edit float |
| `<leader>o` | aerial | Code outline |
| `<leader>gf` | conform | Format file |
| `<leader>h` | — | Clear search hl |
| `<leader>dd` | dadbod | DB UI |
| `<leader>Rs/Ra/Rb` | kulala | HTTP requests |
| `<leader>ko/kc` | sidekick | AI CLI toggle/close |

## Mason Packages (install via :Mason)
- lua-language-server, debugpy, ruff, djlint, prettier, sqlfluff, stylua

## .gitignore
Ignores: `*.swp`, `*.swo`, `*~`, `*.bak`, `*.log`, `.codegraph/`, `lazy-lock.json`, `node_modules/`, `*.luac`, OS files.
