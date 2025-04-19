-- Basic colorscheme setup
vim.opt.termguicolors = true
vim.cmd.colorscheme("tokyonight") -- Or any other colorscheme you've added via Lazy

-- Optional: transparency support
vim.cmd([[
  highlight Normal guibg=NONE ctermbg=NONE
  highlight NormalNC guibg=NONE ctermbg=NONE
  highlight SignColumn guibg=NONE ctermbg=NONE
]])
