return {
  "folke/snacks.nvim",
  priority = 1000,
  opts = {
    -- Enable commonly used features
    bigfile = { enabled = true },
    dashboard = { enabled = true },
    explorer = { enabled = true },
    indent = { enabled = true },
    input = { enabled = true },
    notifier = { enabled = true, timeout = 3000 },
    picker = { enabled = true },
    quickfile = { enabled = true },
    scope = { enabled = true },
    scroll = { enabled = true },
    statuscolumn = { enabled = true },
    words = { enabled = true },
    -- Configure image rendering options
    image = {
      enabled = true,
      -- Explicitly set terminal to "auto" so it can auto-detect support
      terminal = "auto", -- Options: "auto", "kitty", "wezterm", "ghostty" or false
    },
  },
  config = function(_, opts)
    require("snacks").setup(opts)
    -- Make snacks global for easy access in keymaps
    _G.Snacks = require("snacks")

    -- Create a command to display snacks health
    vim.api.nvim_create_user_command("SnacksHealth", function()
      vim.cmd("checkhealth snacks")
    end, {})
  end,
}
