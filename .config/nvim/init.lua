-- init.lua for lazy.nvim
-- Set leader keys before loading plugins
vim.g.mapleader = " "
vim.g.maplocalleader = " "

-- Basic vim settings
vim.opt.number = true         -- Show line numbers
vim.opt.relativenumber = true -- Show relative line numbers
vim.opt.mouse = 'a'          -- Enable mouse in all modes
vim.opt.ignorecase = true    -- Ignore case in search
vim.opt.smartcase = true     -- But don't ignore it when searching with uppercase
vim.opt.hlsearch = true      -- Highlight search results
vim.opt.incsearch = true     -- Show search results as you type
vim.opt.wrap = false         -- Don't wrap lines
vim.opt.breakindent = true   -- Maintain indent when wrapping indented lines
vim.opt.tabstop = 2          -- Tab width
vim.opt.shiftwidth = 2       -- Indent width
vim.opt.expandtab = true     -- Use spaces instead of tabs
vim.opt.smartindent = true   -- Auto indent new lines
vim.opt.termguicolors = true -- True color support
vim.opt.updatetime = 100     -- Faster completion
vim.opt.timeoutlen = 300     -- Time to wait for mapped sequence
vim.opt.clipboard = 'unnamedplus' -- Use system clipboard
vim.opt.scrolloff = 8        -- Lines of context
vim.opt.sidescrolloff = 8    -- Columns of context
vim.opt.splitbelow = true    -- Put new windows below current
vim.opt.splitright = true    -- Put new windows right of current
vim.opt.undofile = true      -- Save undo history
vim.opt.backup = false       -- No backup files
vim.opt.writebackup = false  -- No backup files while editing

-- Load lazy.nvim plugin manager and plugins
require("config.lazy")
