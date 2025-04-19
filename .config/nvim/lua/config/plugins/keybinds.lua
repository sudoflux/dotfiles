-- Keybindings configuration
return {
  "folke/which-key.nvim",
  lazy = false, -- Load immediately
  config = function()
    -- Leader keys are set in init.lua before lazy loads plugins

    local wk = require("which-key")
    wk.setup() -- Basic setup

    -- Define mappings without the prefix, using dictionary style
    local mappings = {
      b = { name = "+Buffer" }, -- Group definition
      bd = { "<cmd>bd<cr>", "Delete Buffer" },
      bn = { "<cmd>bn<cr>", "Next Buffer" },
      bp = { "<cmd>bp<cr>", "Previous Buffer" },

      e = { "<cmd>NvimTreeToggle<cr>", "Toggle File Explorer" },

      f = { name = "+File" },
      fb = { "<cmd>Telescope buffers<cr>", "Buffers" },
      ff = { "<cmd>Telescope find_files<cr>", "Find File" },
      fg = { "<cmd>Telescope live_grep<cr>", "Live Grep" },
      fr = { "<cmd>Telescope oldfiles<cr>", "Recent Files" },

      g = { name = "+Git" },
      gb = { "<cmd>Telescope git_branches<cr>", "Git Branches" },
      gC = { "<cmd>Telescope git_commits<cr>", "Git Commits" }, -- Changed from gc to gC
      gd = { "<cmd>Gitsigns diffthis<cr>", "Git Diff" },
      gs = { "<cmd>Telescope git_status<cr>", "Git Status" },

      l = { name = "+LSP" },
      lD = { "<cmd>lua vim.lsp.buf.declaration()<cr>", "Go to Declaration" },
      lR = { "<cmd>lua vim.lsp.buf.rename()<cr>", "Rename Symbol" },
      la = { "<cmd>lua vim.lsp.buf.code_action()<cr>", "Code Action" },
      ld = { "<cmd>lua vim.lsp.buf.definition()<cr>", "Go to Definition" },
      lf = { "<cmd>lua vim.lsp.buf.format()<cr>", "Format Code" },
      lh = { "<cmd>lua vim.lsp.buf.hover()<cr>", "Hover Documentation" },
      li = { "<cmd>lua vim.lsp.buf.implementation()<cr>", "Go to Implementation" },
      lr = { "<cmd>lua vim.lsp.buf.references()<cr>", "Find References" },

      q = { "<cmd>q<cr>", "Quit" },
      w = { "<cmd>w<cr>", "Save" },
    }

    -- Define options, including the prefix
    local opts = {
      prefix = "<leader>",
      mode = "n", -- specify normal mode
    }

    -- Register the mappings with the options
    wk.register(mappings, opts)

    -- Non-leader keymaps
    local keymap = vim.keymap.set
    -- Easy window navigation
    keymap("n", "<C-h>", "<C-w>h", { desc = "Move to left window" })
    keymap("n", "<C-j>", "<C-w>j", { desc = "Move to bottom window" })
    keymap("n", "<C-k>", "<C-w>k", { desc = "Move to top window" })
    keymap("n", "<C-l>", "<C-w>l", { desc = "Move to right window" })

    -- Better indenting
    keymap("v", "<", "<gv", { desc = "Indent left" })
    keymap("v", ">", ">gv", { desc = "Indent right" })

    -- Move selected lines
    keymap("v", "J", ":m '>+1<CR>gv=gv", { desc = "Move selection down" })
    keymap("v", "K", ":m '<-2<CR>gv=gv", { desc = "Move selection up" })

    -- Center search results
    keymap("n", "n", "nzz", { desc = "Next search result (centered)" })
    keymap("n", "N", "Nzz", { desc = "Previous search result (centered)" })
  end,
}
