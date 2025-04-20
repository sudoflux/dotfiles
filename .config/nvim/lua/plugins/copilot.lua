return {
  {
    "github/copilot.vim",
    cmd = "Copilot",
    event = "InsertEnter",
    config = function()
      -- Disable default tab mapping for completion to avoid conflict with nvim-cmp
      vim.g.copilot_no_tab_map = true
      vim.g.copilot_assume_mapped = true
      vim.g.copilot_tab_fallback = ""

      -- Set up keymaps
      vim.keymap.set("i", "<C-j>", 'copilot#Accept("<CR>")', {
        expr = true,
        replace_keycodes = false,
        silent = true,
      })
      vim.keymap.set("i", "<C-k>", '<Plug>(copilot-next)', { silent = true })
      vim.keymap.set("i", "<C-l>", '<Plug>(copilot-previous)', { silent = true })

      -- Enable Copilot for specific filetypes (you can customize this list)
      vim.g.copilot_filetypes = {
        ["*"] = true,
        ["xml"] = false,
        ["markdown"] = false,
      }
    end,
  },

  -- Alternative: Copilot.lua - a more modern implementation with better integration
  -- Uncomment this and comment out the one above if you prefer this version
  -- {
  --   "zbirenbaum/copilot.lua",
  --   cmd = "Copilot",
  --   event = "InsertEnter",
  --   dependencies = {
  --     "zbirenbaum/copilot-cmp",
  --   },
  --   opts = {
  --     suggestion = {
  --       enabled = true,
  --       auto_trigger = true,
  --       debounce = 75,
  --       keymap = {
  --         accept = "<C-j>",
  --         accept_word = false,
  --         accept_line = false,
  --         next = "<C-k>",
  --         prev = "<C-l>",
  --         dismiss = "<C-]>",
  --       },
  --     },
  --     panel = { enabled = false },
  --     filetypes = {
  --       markdown = true,
  --       help = false,
  --     },
  --   },
  -- },
}
