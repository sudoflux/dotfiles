-- lua/config/plugins/keybinds.lua
print("Loading keybinds.lua") -- Debug statement to confirm loading

return {
  "folke/which-key.nvim",
  lazy = false,
  config = function()
    local wk = require("which-key")
    wk.setup({})

    -- Define all leader mappings using the new spec
    wk.register({
      -- Buffer mappings
      ["<leader>bd"] = { "<cmd>bd<cr>", desc = "Delete Buffer" },
      ["<leader>bn"] = { "<cmd>bn<cr>", desc = "Next Buffer" },
      ["<leader>bp"] = { "<cmd>bp<cr>", desc = "Previous Buffer" },
      ["<leader>b"] = { group = "buffer" },

      -- File explorer
      ["<leader>e"] = { "<cmd>NvimTreeToggle<cr>", desc = "Toggle File Explorer" },

      -- File mappings (Telescope)
      ["<leader>fb"] = { "<cmd>Telescope buffers<cr>", desc = "Buffers" },
      ["<leader>ff"] = { "<cmd>Telescope find_files<cr>", desc = "Find File" },
      ["<leader>fg"] = { "<cmd>Telescope live_grep<cr>", desc = "Live Grep" },
      ["<leader>fr"] = { "<cmd>Telescope oldfiles<cr>", desc = "Recent Files" },
      ["<leader>f"] = { group = "file" },

      -- Git mappings (Telescope and Gitsigns)
      ["<leader>gC"] = { "<cmd>Telescope git_commits<cr>", desc = "Git Commits" },
      ["<leader>gb"] = { "<cmd>Telescope git_branches<cr>", desc = "Git Branches" },
      ["<leader>gd"] = { "<cmd>Gitsigns diffthis<cr>", desc = "Git Diff" },
      ["<leader>gs"] = { "<cmd>Telescope git_status<cr>", desc = "Git Status" },
      ["<leader>g"] = { group = "git" },

      -- LSP mappings
      ["<leader>lD"] = { function() vim.lsp.buf.declaration() end, desc = "Go to Declaration" },
      ["<leader>lR"] = { function() vim.lsp.buf.rename() end, desc = "Rename Symbol" },
      ["<leader>la"] = { function() vim.lsp.buf.code_action() end, desc = "Code Action" },
      ["<leader>ld"] = { function() vim.lsp.buf.definition() end, desc = "Go to Definition" },
      ["<leader>lf"] = { function() vim.lsp.buf.format() end, desc = "Format Code" },
      ["<leader>lh"] = { function() vim.lsp.buf.hover() end, desc = "Hover Documentation" },
      ["<leader>li"] = { function() vim.lsp.buf.implementation() end, desc = "Go to Implementation" },
      ["<leader>lr"] = { function() vim.lsp.buf.references() end, desc = "Find References" },
      ["<leader>l"] = { group = "lsp" },

      -- Quit and save
      ["<leader>q"] = { "<cmd>q<cr>", desc = "Quit" },
      ["<leader>w"] = { "<cmd>w<cr>", desc = "Save" },
    })

    -- Non-leader keybindings using vim.keymap.set
    local keymap = vim.keymap.set
    keymap("n", "<C-h>", "<C-w>h", { desc = "Move to left window" })
    keymap("n", "<C-j>", "<C-w>j", { desc = "Move to bottom window" })
    keymap("n", "<C-k>", "<C-w>k", { desc = "Move to top window" })
    keymap("n", "<C-l>", "<C-w>l", { desc = "Move to right window" })

    keymap("v", "<", "<gv", { desc = "Indent left" })
    keymap("v", ">", ">gv", { desc = "Indent right" })

    keymap("v", "J", ":m '>+1<CR>gv=gv", { desc = "Move selection down" })
    keymap("v", "K", ":m '<-2<CR>gv=gv", { desc = "Move selection up" })

    keymap("n", "n", "nzz", { desc = "Next search result (centered)" })
    keymap("n", "N", "Nzz", { desc = "Previous search result (centered)" })
  end,
}
