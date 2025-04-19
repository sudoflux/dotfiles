-- lua/config/plugins/conform.lua
return {
  "stevearc/conform.nvim",
  config = function()
    require("conform").setup {
      formatters_by_ft = {
        lua = { "stylua" },
        python = { "black" },
        javascript = { "prettier" },
        typescript = { "prettier" },
      },
      format_on_save = {
        timeout_ms = 500,
        lsp_fallback = true,
      },
    }

    -- Conform keybindings (if any) should be defined in keybinds.lua
    -- For example, <leader>lf (format) is already in keybinds.lua
  end,
}
