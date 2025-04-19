-- init.lua

-- 1) Set leader *very* early, before require("lazy") or any plugin code
vim.g.mapleader      = " "
vim.g.maplocalleader = " "

-- 2) (Optional) any core Neovim options you like
vim.opt.number        = true
vim.opt.relativenumber = true
vim.opt.termguicolors = true
-- …etc…

-- 3) Load your plugin manager, which will in turn load
--    all of your plugin specs (including keybinds.lua)
require("config.lazy")
