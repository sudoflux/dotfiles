return {
  "neovim/nvim-lspconfig",
  dependencies = {
    "williamboman/mason.nvim",
    "williamboman/mason-lspconfig.nvim",
  },
  config = function()
    require("mason").setup()
    require("mason-lspconfig").setup({
      ensure_installed = { "lua_ls", "bashls", "pyright" },
    })

    local lspconfig = require("lspconfig")
    local caps      = require("cmp_nvim_lsp").default_capabilities()

    lspconfig.lua_ls.setup({ capabilities = caps })
    lspconfig.bashls.setup({ capabilities = caps })
    lspconfig.pyright.setup({ capabilities = caps })
  end,
}
