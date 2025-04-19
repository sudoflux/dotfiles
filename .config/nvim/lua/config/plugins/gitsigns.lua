-- lua/config/plugins/gitsigns.lua
return {
  "lewis6991/gitsigns.nvim",
  config = function()
    require("gitsigns").setup {
      signs = {
        add = { text = "+" },
        change = { text = "~" },
        delete = { text = "_" },
        topdelete = { text = "‾" },
        changedelete = { text = "~" },
      },
    }

    -- Gitsigns keybindings are defined in keybinds.lua, so no wk.register here
  end,
}
