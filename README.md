# CLAUDE.md — Конфигурация Neovim

Dotfiles для Python/web разработки на Neovim с темой Catppuccin.

## Краткая справка

| Параметр | Значение |
|----------|----------|
| Менеджер плагинов | lazy.nvim |
| Тема | Catppuccin (авто: latte/mocha) |
| Leader-клавиша | `<Space>` |
| Фон | `light` (Catppuccin latte) |
| Отступы | 4 пробела |
| LSP-серверы | ruff (Python), html, djlint |
| Отладка | nvim-dap + debugpy (Python) |
| Базы данных | vim-dadbod + dadbod-ui |

## Структура проекта

```
~/.local/share/nvim/          # XDG data (здесь устанавливаются плагины)
~/.config/nvim/               # XDG config (Linux/macOS)
%LOCALAPPDATA%\nvim\          # Конфиг Windows (этот репозиторий)
├── init.lua                  # Точка входа — запускает lazy.nvim, загружает vim-options + плагины
├── lua/
│   ├── vim-options.lua       # Основные опции, leader-клавиша, навигация по окнам
│   ├── plugins.lua           # Пустой заглушка (return {}) — оставлен для lazy.nvim
│   └── plugins/              # Один файл на плагин или группу плагинов
│       ├── alpha.lua         # Стартовый экран (dashboard с ASCII-артом)
│       ├── aerial.lua        # Дерево структуры кода
│       ├── catppuccin.lua    # Тема (авто light/dark)
│       ├── completions.lua   # nvim-cmp + LuaSnip + источники
│       ├── debugging.lua     # nvim-dap + dap-ui + dap-python
│       ├── git-stuff.lua     # vim-fugitive + gitsigns
│       ├── lualine.lua       # Строка состояния
│       ├── lsp-config.lua    # Mason + lspconfig (ruff, html, djlint)
│       ├── neo-tree.lua      # Файловый браузер + bufferline
│       ├── none-ls.lua       # Форматтеры (stylua, prettier, djlint)
│       ├── oil.lua           # Редактирование директории
│       ├── telescope.lua     # Fuzzy-поиск (fzf-native + ui-select)
│       ├── treesitter.lua    # Подсветка синтаксиса + отступы
│       ├── venv-selector.lua # Авто-выбор Python venv
│       ├── vim-dadbod.lua    # UI для баз данных
│       └── vim-test.lua      # Запуск тестов
└── .gitignore
```

## Управление плагинами

Менеджер: [lazy.nvim](https://github.com/folke/lazy.nvim).

### Добавление нового плагина

1. Создайте `lua/plugins/<name>.lua`
2. Верните таблицу спецификации lazy.nvim:

```lua
return {
    "owner/repo",
    lazy = false,
    config = function()
        require("plugin").setup({})
    end,
    keys = { { "<leader>x", "<cmd>PluginCmd<cr>", desc = "Команда плагина" } },
    event = "VeryLazy",
}
```

### Стилевые соглашения

- **Отступы в 4 пробела** везде
- При использовании keymaps предпочитайте `config = function()` вместо `opts = {}`
- Всегда указывайте `desc = "..."` на keymaps (отображается в which-key)
- Группируйте связанные keymaps с комментариями
- Один логический плагин (или связанная группа) на файл

## Конфигурация LSP

Стек: `mason.nvim` → `mason-lspconfig.nvim` → `nvim-lspconfig`

Текущие серверы (в `lua/plugins/lsp-config.lua`):
- **ruff** — линтинг/форматирование Python
- **html** — поддержка HTML
- **djlint** — форматирование HTML-шаблонов

Добавить новый сервер:

```lua
vim.lsp.config('pyright', {
    capabilities = require('cmp_nvim_lsp').default_capabilities()
})
```

Keymaps LSP:

| Клавиша | Действие |
|---------|----------|
| `K` | Показать документацию (hover) |
| `<leader>ld` | Перейти к определению |
| `<leader>lr` | Найти использования |
| `<leader>ca` | Действия над кодом (code action) |

## Форматирование (none-ls)

Определено в `lua/plugins/none-ls.lua`:

| Форматтер | Язык |
|-----------|------|
| stylua | Lua |
| prettier | JS/JSON/и др. |
| djlint | HTML-шаблоны |

Запуск: `<leader>gf` → `vim.lsp.buf.format`

## Обзор ключевых сочетаний

### Навигация по окнам (vim-options.lua)

| Клавиша | Действие |
|---------|----------|
| `<C-h>` | Окно влево |
| `<C-j>` | Окно вниз |
| `<C-k>` | Окно вверх |
| `<C-l>` | Окно вправо |

### Общие

| Клавиша | Действие |
|---------|----------|
| `<leader>h` | Снять подсветку поиска |

### Telescope (telescope.lua)

| Клавиша | Действие |
|---------|----------|
| `<C-p>` | Найти файлы |
| `<leader>fg` | Поиск по содержимому (live grep) |
| `<leader><leader>` | Последние файлы |

### Базы данных (vim-dadbod.lua)

| Клавиша | Действие |
|---------|----------|
| `<leader>dd` | Открыть/скрыть Dadbod UI |

### Neo-tree (neo-tree.lua)

| Клавиша | Действие |
|---------|----------|
| `<C-n>` | Показать/скрыть файловый браузер |
| `<leader>bf` | Открыть буферы во float-окне |

### Oil (oil.lua)

| Клавиша | Действие |
|---------|----------|
| `-` | Редактировать директорию во float-окне |

### Git (git-stuff.lua)

| Клавиша | Действие |
|---------|----------|
| `<leader>gh` | Просмотр hunk'а |
| `<leader>gb` | Вкл/выкл blame текущей строки |
| `<leader>gd` | Показать diff |
| `<leader>gn` | Следующий hunk |
| `<leader>gN` | Предыдущий hunk |
| `<leader>ga` | Добавить hunk в staging |
| `<leader>gu` | Убрать hunk из staging |

### Отладка (debugging.lua)

| Клавиша | Действие |
|---------|----------|
| `<Leader>db` | Вкл/выкл точку останова |
| `<Leader>dc` | Продолжить выполнение |
| `<Leader>dt` | Показать/скрыть DAP UI |

### Aerial (aerial.lua)

| Клавиша | Действие |
|---------|----------|
| `<leader>o` | Показать/скрыть структуру кода |

### Тесты (vim-test.lua)

| Клавиша | Действие |
|---------|----------|
| `<leader>tn` | Запустить ближайший тест |
| `<leader>tf` | Запустить тесты текущего файла |
| `<leader>ta` | Запустить весь тестовый набор |
| `<leader>tl` | Запустить последний тест |
| `<leader>tg` | Перейти к тесту |

### Автодополнение (completions.lua)

| Клавиша | Действие |
|---------|----------|
| `<C-Space>` | Вызвать автодополнение |
| `<CR>` | Подтвердить выбор |
| `<C-e>` | Отменить |
| `<C-b>` | Прокрутить документацию вверх |
| `<C-f>` | Прокрутить документацию вниз |

## Добавление поддержки языка

1. Добавьте LSP-сервер в `lua/plugins/lsp-config.lua` через `vim.lsp.config()`
2. Treesitter-парсеры устанавливаются автоматически (`auto_install = true`)
3. При необходимости добавьте форматтеры/линтеры в `lua/plugins/none-ls.lua`

## Отключённые плагины (резервные копии)

Файлы с расширением `.back` — временно отключены:
- `kulala.lua.back` — HTTP-клиент
- `nvim-tmux-navigation.back` — Навигация в Tmux

Чтобы включить: удалите `.back` из имени файла.

## Распространённые задачи

```
:Lazy              # Панель статуса плагинов
:Lazy update       # Обновить все плагины
:Lazy sync         # Синхронизировать после изменений конфига
:TSUpdate          # Обновить Treesitter-парсеры
:Mason             # UI Mason (установка/управление LSP)
:Dblast            # Открыть Dadbod UI (базы данных)
```

## Примечания

- `vim-options.lua` использует стиль `vim.cmd("set ...")` — соответствует существующим соглашениям
- Swap-файлы отключены (`vim.opt.swapfile = false`)
- Фон `light` — применяется Catppuccin latte
- `.venv` автоматически определяется venv-selector (для Python-проектов)
- Zig CC закомментирован в vim-options.lua (`vim.env.CC = "zig cc"`)
