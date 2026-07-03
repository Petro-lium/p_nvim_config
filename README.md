# README.md — Конфигурация Neovim

Dotfiles для Python/web разработки на Neovim с темой Catppuccin.

## Краткая справка

| Параметр          | Значение                                      |
| ----------------- | --------------------------------------------- |
| Менеджер плагинов | lazy.nvim                                     |
| Тема              | Catppuccin (авто: latte/mocha)                |
| Leader-клавиша    | `<Space>`                                     |
| Фон               | auto (зависит от терминала)                   |
| Отступы           | Python: 4 пробела, остальные: 2               |
| LSP-серверы       | pyright (Python), ruff (lint), html, djlint   |
| Форматтеры        | conform.nvim (stylua, prettier, djlint, ruff, sqlfluff) |
| Отладка           | nvim-dap + debugpy (Python)                   |
| Тесты             | nvim-neotest (pytest)                         |
| Базы данных       | vim-dadbod + dadbod-ui                        |
| HTTP-клиент       | kulala.nvim                                   |
| AI-ассистент      | sidekick.nvim                                 |
| Просмотр diff     | diffview.nvim                                 |
| Иконки            | mini.icons                                    |
| Комментарии       | Comment.nvim (gc/gb)                          |
| Popup-подсказки   | which-key.nvim                                |

## Структура проекта

```
%LOCALAPPDATA%\nvim\          # Конфиг Windows (этот репозиторий)
├── init.lua                  # Точка входа — запускает lazy.nvim, загружает vim-options + плагины
├── lua/
│   ├── vim-options.lua       # Основные опции, leader-клавиша, навигация, определения типов файлов
│   ├── plugins.lua           # Пустой заглушка (return {}) — оставлен для lazy.nvim
│   └── plugins/              # Один файл на плагин или группу плагинов
│       ├── comment.lua       # Комментарии (Comment.nvim, gc/gb)
│       ├── alpha.lua         # Стартовый экран (dashboard с ASCII-артом)
│       ├── aerial.lua        # Дерево структуры кода
│       ├── catppuccin.lua    # Тема (авто light/dark)
│       ├── completions.lua   # nvim-cmp + LuaSnip + источники
│       ├── debugging.lua     # nvim-dap + dap-ui + dap-python
│       ├── git-stuff.lua     # vim-fugitive + diffview.nvim + gitsigns
│       ├── lualine.lua       # Строка состояния (с отображением venv)
│       ├── lsp-config.lua    # Mason + lspconfig (ruff, html, djlint, pyright)
│       ├── mini-icons.lua    # Иконки (mini.icons)
│       ├── neo-tree.lua      # Файловый браузер + bufferline
│       ├── conform.lua       # Форматтеры (stylua, prettier, djlint, ruff, sqlfluff)
│       ├── oil.lua           # Редактирование директорий
│       ├── sidekick.lua      # AI-ассистент (CLI)
│       ├── snacks.lua        # Анимации, скролл, отступы, LazyGit
│       ├── telescope.lua     # Fuzzy-поиск (fzf-native + ui-select)
│       ├── treesitter.lua    # Подсветка синтаксиса + отступы (MSVC 'cl' на Windows)
│       ├── venv-selector.lua # Авто-выбор Python venv
│       ├── vim-dadbod.lua    # UI для баз данных
│       ├── which-key.lua     # Всплывающие подсказки клавиш
│       ├── kulala.lua        # HTTP-клиент (.http, .rest)
│       └── neotest.lua       # Тесты (pytest, nvim-neotest)
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

- **pyright** — полноценный LSP для Python (типы, go to definition, auto-import)
- **ruff** — линтинг/форматирование Python
- **html** — поддержка HTML
- **djlint** — форматирование HTML-шаблонов

LSP-клавиши (активны только в файлах с подключенным LSP):

| Клавиша      | Действие                         |
| ------------ | -------------------------------- |
| `K`          | Показать документацию (hover)    |
| `<leader>ld` | Перейти к определению            |
| `<leader>lr` | Найти использования              |
| `<leader>la` | Действия над кодом (code action) |

## Форматирование (conform.nvim)

Определено в `lua/plugins/conform.lua`:

| Форматтер              | Язык                      |
| ---------------------- | ------------------------- |
| ruff_fix + ruff_format | Python                    |
| stylua                 | Lua                       |
| prettier               | JS/JSON/CSS/Markdown/YAML |
| djlint                 | HTML-шаблоны              |
| sqlfluff               | SQL (PostgreSQL)          |

Запуск: `<leader>gf` → `conform.format({ lsp_fallback = true })`

Форматирование при сохранении включено автоматически.

## Обзор ключевых сочетаний

### Навигация по окнам (vim-options.lua)

| Клавиша | Действие    |
| ------- | ----------- |
| `<C-h>` | Окно влево  |
| `<C-j>` | Окно вниз   |
| `<C-k>` | Окно вверх  |
| `<C-l>` | Окно вправо |

### Общие

| Клавиша     | Действие               |
| ----------- | ---------------------- |
| `<leader>h` | Снять подсветку поиска |

### Терминал (vim-options.lua)

| Клавиша      | Действие                         |
| ------------ | -------------------------------- |
| `<Esc>`      | Выйти из терминала в normal mode |
| `<leader>pt` | Открыть PowerShell в терминале   |

### Telescope (telescope.lua)

| Клавиша            | Действие                         |
| ------------------ | -------------------------------- |
| `<C-p>`            | Найти файлы                      |
| `<leader>fg`       | Поиск по содержимому (live grep) |
| `<leader><leader>` | Последние файлы                  |

### Базы данных (vim-dadbod.lua)

| Клавиша      | Действие                 |
| ------------ | ------------------------ |
| `<leader>dd` | Открыть/скрыть Dadbod UI |

### Neo-tree (neo-tree.lua)

| Клавиша      | Действие                         |
| ------------ | -------------------------------- |
| `<C-n>`      | Показать/скрыть файловый браузер |
| `<leader>bf` | Открыть буферы во float-окне     |

### Oil (oil.lua)

| Клавиша | Действие                               |
| ------- | -------------------------------------- |
| `-`     | Редактировать директорию во float-окне |

### Git (git-stuff.lua)

| Клавиша      | Действие                      |
| ------------ | ----------------------------- |
| `<leader>gh` | Просмотр hunk'а               |
| `<leader>gb` | Вкл/выкл blame текущей строки |
| `<leader>gd` | Показать diff (gitsigns)      |
| `<leader>gD` | Открыть обзор diff (diffview) |
| `<leader>gx` | Закрыть diffview              |
| `<leader>gn` | Следующий hunk                |
| `<leader>gN` | Предыдущий hunk               |
| `<leader>ga` | Добавить hunk в staging       |
| `<leader>gu` | Убрать hunk из staging        |
| `<leader>gA` | Добавить файл в staging       |
| `<leader>gs` | LazyGit (через Snacks)        |

### Отладка (debugging.lua)

| Клавиша      | Действие                |
| ------------ | ----------------------- |
| `<Leader>db` | Вкл/выкл точку останова |
| `<Leader>dc` | Продолжить выполнение   |
| `<Leader>dt` | Показать/скрыть DAP UI  |

### Aerial (aerial.lua)

| Клавиша     | Действие                       |
| ----------- | ------------------------------ |
| `<leader>o` | Показать/скрыть структуру кода |

### AI-ассистент (sidekick.lua)

| Клавиша      | Действие                           |
| ------------ | ---------------------------------- |
| `<leader>ko` | Показать/скрыть AI CLI             |
| `<leader>kc` | Закрыть AI CLI                     |
| `<C-_>`      | Фокус на AI CLI из любого режима   |

### HTTP-клиент (kulala.lua)

| Клавиша      | Действие                         |
| ------------ | -------------------------------- |
| `<leader>Rs` | Отправить запрос (Send request)  |
| `<leader>Ra` | Отправить все запросы (Send all) |
| `<leader>Rb` | Открыть scratchpad               |

Работает в файлах с расширением `.http` и `.rest`.

### Тесты (neotest.lua)

| Клавиша      | Действие                       |
| ------------ | ------------------------------ |
| `<leader>tn` | Запустить ближайший тест       |
| `<leader>tf` | Запустить тесты текущего файла |
| `<leader>ta` | Запустить весь тестовый набор  |
| `<leader>tl` | Запустить последний тест       |
| `<leader>tt` | Дерево тестов (summary)        |
| `<leader>to` | Вывод результатов теста        |
| `<leader>td` | Отладка ближайшего теста       |
| `<leader>ts` | Панель вывода тестов           |

### Автодополнение (completions.lua)

| Клавиша     | Действие                      |
| ----------- | ----------------------------- |
| `<C-Space>` | Вызвать автодополнение        |
| `<CR>`      | Подтвердить выбор             |
| `<C-e>`     | Отменить                      |
| `<C-b>`     | Прокрутить документацию вверх |
| `<C-f>`     | Прокрутить документацию вниз  |

### Комментарии (comment.lua)

Плагин: [numToStr/Comment.nvim](https://github.com/numToStr/Comment.nvim) — стандартные gc/gb клавиши

| Клавиша   | Действие                              |
| --------- | ------------------------------------- |
| `gcc`     | Вкл/выкл линейный комментарий (строка)|
| `gcNc`    | Вкл/выкл линейный комментарий (N стр.)|
| `gbc`     | Вкл/выкл блочный комментарий (строка) |
| `gbNc`    | Вкл/выкл блочный комментарий (N стр.) |
| `gc` + движение | Операторный режим (напр. `gcw`, `gc$`) |
| `gb` + движение | Блочный операторный режим            |
| `gc` (v)  | Visual mode: комментарий выделенного  |

Все комментарии переключаемые — повторное нажатие раскомментирует.

## Добавление поддержки языка

1. Добавьте LSP-сервер в `lua/plugins/lsp-config.lua` через `vim.lsp.config()`
2. Treesitter-парсеры устанавливаются автоматически (`auto_install = true`)
3. При необходимости добавьте форматтеры в `lua/plugins/conform.lua`

## Отключённые плагины (резервные копии)

Файлы с расширением `.back` — временно отключены:

- `nvim-tmux-navigation.back` — Навигация в Tmux

Чтобы включить: удалите `.back` из имени файла.

## Распространенённые задачи

```
:Lazy              # Панель статуса плагинов
:Lazy update       # Обновить все плагины
:Lazy sync         # Синхронизировать после изменений конфига
:TSUpdate          # Обновить Treesitter-парсеры
:Mason             # UI Mason (установка/управление LSP)
:Dblast            # Открыть Dadbod UI (базы данных)
```

## Примечания

- Swap-файлы отключены (`vim.opt.swapfile = false`)
- Фон определяется автоматически по терминалу (Catppuccin latte/mocha)
- `.venv` автоматически определяется venv-selector (для Python-проектов)
- Отступы настраиваются динамически: Python — 4 пробела, JS/TS/Lua/HTML/CSS/SQL/JSON/YAML/Markdown — 2 пробела
- Файлы `.rest` распознаются как `http` через `vim.filetype.add` в `vim-options.lua`
