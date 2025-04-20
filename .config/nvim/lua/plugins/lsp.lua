return {
  -- LSP Configuration
  {
    "neovim/nvim-lspconfig",
    event = { "BufReadPre", "BufNewFile" },
    dependencies = {
      "mason.nvim",
      "williamboman/mason-lspconfig.nvim",
      "hrsh7th/cmp-nvim-lsp",
      {
        "folke/neodev.nvim", -- Better Lua development
        opts = {}
      },
    },
    opts = {
      diagnostics = {
        underline = true,
        update_in_insert = false,
        virtual_text = { spacing = 4, prefix = "●" },
        severity_sort = true,
      },
      servers = {
        -- List of LSP servers to configure
        lua_ls = {
          settings = {
            Lua = {
              workspace = { checkThirdParty = false },
              telemetry = { enable = false },
              diagnostics = {
                globals = { "vim" },
              },
            },
          },
        },
        -- Add more language servers as needed:
        bashls = {},
        tsserver = {},
        jsonls = {},
        yamlls = {},
        html = {},
        cssls = {},
        pyright = {},
        rust_analyzer = {},
      },
      setup = {},
    },
    config = function(_, opts)
      -- Setup diagnostics
      vim.diagnostic.config(opts.diagnostics)

      -- Setup keymaps when attaching LSP
      local on_attach = function(client, bufnr)
        -- LSP actions
        vim.keymap.set("n", "K", vim.lsp.buf.hover, { buffer = bufnr, desc = "Hover Documentation" })
        vim.keymap.set("n", "gd", vim.lsp.buf.definition, { buffer = bufnr, desc = "Goto Definition" })
        vim.keymap.set("n", "gD", vim.lsp.buf.declaration, { buffer = bufnr, desc = "Goto Declaration" })
        vim.keymap.set("n", "gi", vim.lsp.buf.implementation, { buffer = bufnr, desc = "Goto Implementation" })
        vim.keymap.set("n", "go", vim.lsp.buf.type_definition, { buffer = bufnr, desc = "Type Definition" })
        vim.keymap.set("n", "gr", vim.lsp.buf.references, { buffer = bufnr, desc = "References" })
        vim.keymap.set("n", "gs", vim.lsp.buf.signature_help, { buffer = bufnr, desc = "Signature Help" })
        vim.keymap.set("n", "<F2>", vim.lsp.buf.rename, { buffer = bufnr, desc = "Rename" })
        vim.keymap.set("n", "<F4>", vim.lsp.buf.code_action, { buffer = bufnr, desc = "Code Action" })
        vim.keymap.set("n", "gl", vim.diagnostic.open_float, { buffer = bufnr, desc = "Line Diagnostics" })

        -- Diagnostic navigation
        vim.keymap.set("n", "[d", vim.diagnostic.goto_prev, { buffer = bufnr, desc = "Previous Diagnostic" })
        vim.keymap.set("n", "]d", vim.diagnostic.goto_next, { buffer = bufnr, desc = "Next Diagnostic" })
      end

      -- Setup capabilities (autocompletion integration)
      local capabilities = vim.lsp.protocol.make_client_capabilities()
      capabilities = require("cmp_nvim_lsp").default_capabilities(capabilities)

      -- Setup mason-lspconfig
      local mason_lspconfig = require("mason-lspconfig")
      local servers = opts.servers

      mason_lspconfig.setup({
        ensure_installed = vim.tbl_keys(servers),
      })

      -- Setup servers
      mason_lspconfig.setup_handlers({
        function(server_name)
          local server_opts = servers[server_name] or {}
          server_opts.capabilities = capabilities
          server_opts.on_attach = on_attach

          -- Server-specific settings/overrides
          if opts.setup[server_name] then
            opts.setup[server_name](server_name, server_opts)
          else
            require("lspconfig")[server_name].setup(server_opts)
          end
        end
      })
    end,
  },

  -- Mason (installer tool)
  {
    "williamboman/mason.nvim",
    cmd = "Mason",
    keys = { { "<leader>cm", "<cmd>Mason<cr>", desc = "Mason" } },
    opts = {
      ensure_installed = {
        "stylua",       -- Lua formatter
        "shfmt",        -- Shell formatter
        "prettier",     -- JS/TS/HTML/CSS formatter
        "black",        -- Python formatter
        "isort",        -- Python import sorter
        "pylint",       -- Python linter
        "eslint_d",     -- JS/TS linter
        -- Adding tools that snacks.nvim needs
        "fd",           -- Finder tool needed by snacks.picker.explorer
      },
    },
    config = function(_, opts)
      require("mason").setup(opts)
      local mr = require("mason-registry")
      local function ensure_installed()
        for _, tool in ipairs(opts.ensure_installed) do
          local p = mr.get_package(tool)
          if not p:is_installed() then
            p:install()
          end
        end
      end

      if mr.refresh then
        mr.refresh(ensure_installed)
      else
        ensure_installed()
      end
    end,
  },
}
