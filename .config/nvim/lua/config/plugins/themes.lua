-- lua/config/plugins/themes.lua
return {
  "folke/tokyonight.nvim",
  config = function()
    require("tokyonight").setup {
      style = "storm",
    }
    vim.cmd [[colorscheme tokyonight]]
  end,
}
