-- General vim options
local opt = vim.opt

-- UI
opt.number = true           -- Show line numbers
opt.relativenumber = true   -- Show relative line numbers
opt.signcolumn = "yes"      -- Always show sign column
opt.cursorline = true       -- Highlight current line
opt.showmode = false        -- Don't show mode (shown in statusline)
opt.termguicolors = true    -- True color support
opt.colorcolumn = "80"      -- Column marker
opt.scrolloff = 8           -- Lines to keep above/below cursor
opt.sidescrolloff = 8       -- Columns to keep left/right of cursor
opt.splitbelow = true       -- New horizontal splits below
opt.splitright = true       -- New vertical splits to the right

-- Behavior
opt.hidden = true           -- Enable background buffers
opt.mouse = "a"             -- Enable mouse
opt.clipboard = "unnamedplus" -- Use system clipboard
opt.undofile = true         -- Persistent undo
opt.completeopt = "menuone,noselect" -- Better completion
opt.updatetime = 250        -- Faster update time
opt.timeoutlen = 300        -- Faster keymap timeout
opt.confirm = true          -- Confirm instead of error
opt.backup = false          -- No backup files
opt.writebackup = false     -- No backup while editing
opt.swapfile = false        -- No swap files

-- Search
opt.ignorecase = true       -- Ignore case in search
opt.smartcase = true        -- Override ignorecase if uppercase
opt.hlsearch = false        -- Don't highlight search results
opt.incsearch = true        -- Incremental search

-- Indentation
opt.expandtab = true        -- Use spaces instead of tabs
opt.tabstop = 2             -- Number of spaces for tab
opt.softtabstop = 2         -- Number of spaces for soft tab
opt.shiftwidth = 2          -- Number of spaces for indent
opt.shiftround = true       -- Round indent to multiple of shiftwidth
opt.smartindent = true      -- Auto indent new lines
opt.breakindent = true      -- Maintain indent when wrapping
opt.wrap = false            -- Don't wrap lines

-- Folding
opt.foldmethod = "expr"
opt.foldexpr = "nvim_treesitter#foldexpr()"
opt.foldenable = false      -- Disable folding by default
opt.foldlevel = 99          -- High fold level by default
