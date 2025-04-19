-- lua/config/plugins/copilot.lua
return {
  "github/copilot.vim",
  config = function()
    -- Copilot settings (if any)
    vim.g.copilot_no_tab_map = true
    vim.api.nvim_set_keymap("i", "<C-J>", 'copilot#Accept("<CR>")', { silent = true, expr = true })
  end,
}
