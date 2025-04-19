-- lua/config/plugins/nvimtree.lua
return {
  "kyazdani42/nvim-tree.lua",
  dependencies = { "kyazdani42/nvim-web-devicons" },
  config = function()
    require("nvim-tree").setup {
      view = {
        width = 30,
        side = "left",
      },
      renderer = {
        icons = {
          show = {
            file = true,
            folder = true,
            folder_arrow = true,
            git = true,
          },
        },
      },
    }

    -- NvimTree keybinding (<leader>e) is defined in keybinds.lua, so no wk.register here
  end,
}
