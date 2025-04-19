-- GitHub Copilot plugin config
-- Note: Node.js must be installed before this runs (handled in bootstrap)

return {
  "github/copilot.vim",
  config = function()
    -- Optional settings:
    -- vim.g.copilot_no_tab_map = true
    -- vim.api.nvim_set_keymap("i", "<C-J>", 'copilot#Accept("<CR>")', { expr = true, silent = true, noremap = true })
  end,
  event = "InsertEnter"
}
