return {
  {
    "folke/tokyonight.nvim",
    priority = 1000,
    config = function()
      vim.opt.termguicolors = true
      vim.cmd.colorscheme("tokyonight")

      -- Optional transparency
      vim.cmd([[
        highlight Normal guibg=NONE ctermbg=NONE
        highlight NormalNC guibg=NONE ctermbg=NONE
        highlight SignColumn guibg=NONE ctermbg=NONE
      ]])

      -- GUI font setting for Neovide, etc.
      if vim.g.neovide then
        vim.o.guifont = "JetBrainsMono Nerd Font:h12"
      end
    end,
  },
}
