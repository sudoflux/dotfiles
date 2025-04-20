-- Base Neovim configuration
vim.g.mapleader = " "
vim.g.maplocalleader = " "

-- Install lazy.nvim automatically
require("config.lazy")

-- Load core configurations
require("config.options")  -- Vim options
require("keymaps")         -- Key mappings

-- Check for and inform about missing system dependencies
require("config.dependencies")
