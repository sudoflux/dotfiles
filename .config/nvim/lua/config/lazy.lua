-- lua/config/lazy.lua
local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not vim.loop.fs_stat(lazypath) then
  vim.fn.system({
    "git", "clone", "--filter=blob:none",
    "https://github.com/folke/lazy.nvim.git",
    lazypath,
  })
end
vim.opt.rtp:prepend(lazypath)

-- Explicitly list plugin specs
require("lazy").setup({
  { import = "config.plugins.keybinds" }, -- Must load first to ensure which-key is set up
  { import = "config.plugins.cmp" },
  { import = "config.plugins.conform" },
  { import = "config.plugins.copilot" },
  { import = "config.plugins.font" },
  { import = "config.plugins.gitsigns" },
  { import = "config.plugins.lsp" },
  { import = "config.plugins.lualine" },
  { import = "config.plugins.mini_icons" },
  { import = "config.plugins.nvimtree" },
  { import = "config.plugins.telescope" },
  { import = "config.plugins.themes" },
  { import = "config.plugins.treesitter" },
})
