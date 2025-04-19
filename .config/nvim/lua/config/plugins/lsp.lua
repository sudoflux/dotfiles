-- lua/config/plugins/lsp.lua
return {
  "neovim/nvim-lspconfig",
  dependencies = {
    "williamboman/mason.nvim",
    "williamboman/mason-lspconfig.nvim",
  },
  config = function()
    -- Setup Mason and Mason-LSPconfig
    require("mason").setup()
    require("mason-lspconfig").setup()

    -- Define on_attach function for LSP keybindings
    local on_attach = function(client, bufnr)
      local bufopts = { buffer = bufnr, noremap = true, silent = true }
      -- Use vim.keymap.set to avoid which-key conflicts
      vim.keymap.set("n", "<leader>lD", vim.lsp.buf.declaration, bufopts)
      vim.keymap.set("n", "<leader>lR", vim.lsp.buf.rename, bufopts)
      vim.keymap.set("n", "<leader>la", vim.lsp.buf.code_action, bufopts)
      vim.keymap.set("n", "<leader>ld", vim.lsp.buf.definition, bufopts)
      vim.keymap.set("n", "<leader>lf", vim.lsp.buf.format, bufopts)
      vim.keymap.set("n", "<leader>lh", vim.lsp.buf.hover, bufopts)
      vim.keymap.set("n", "<leader>li", vim.lsp.buf.implementation, bufopts)
      vim.keymap.set("n", "<leader>lr", vim.lsp.buf.references, bufopts)
    end

    -- Setup LSP servers
    local lspconfig = require("lspconfig")
    -- Example: Setup for a few common LSP servers
    lspconfig.pyright.setup { on_attach = on_attach }
    lspconfig.tsserver.setup { on_attach = on_attach }
    lspconfig.lua_ls.setup {
      on_attach = on_attach,
      settings = {
        Lua = {
          diagnostics = {
            globals = { "vim" },
          },
        },
      },
    }
    -- Add more LSP servers as needed
  end,
}
