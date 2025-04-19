-- Font-specific UI tweaks (if using GUI like Neovide, etc.)
if vim.g.neovide then
  vim.o.guifont = "JetBrainsMono Nerd Font:h12"
end

-- Enable devicons (for file tree, status line, etc.)
require("nvim-web-devicons").setup({})
