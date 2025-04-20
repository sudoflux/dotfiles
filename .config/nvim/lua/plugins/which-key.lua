return {
  "folke/which-key.nvim",
  event = "VeryLazy",
  opts = {
    plugins = {
      marks = true,
      registers = true,
      spelling = {
        enabled = true,
        suggestions = 20,
      },
      presets = {
        operators = true,
        motions = true,
        text_objects = true,
        windows = true,
        nav = true,
        z = true,
        g = true,
      },
    },
    window = {
      border = "rounded",
      padding = { 2, 2, 2, 2 },
    },
    layout = {
      height = { min = 4, max = 25 },
      width = { min = 20, max = 50 },
      spacing = 3,
      align = "center",
    },
    ignore_missing = false,
    show_help = true,
    show_keys = true,
  },
  config = function(_, opts)
    local wk = require("which-key")
    wk.setup(opts)

    -- Register all key mappings
    wk.register({
      ["<leader>"] = {
        -- File operations
        f = {
          name = "File",
          f = { function() Snacks.picker.files() end, "Find Files" },
          r = { function() Snacks.picker.oldfiles() end, "Recent Files" },
          g = { function() Snacks.picker.live_grep() end, "Grep Files" },
          n = { "<cmd>enew<cr>", "New File" },
          s = { "<cmd>w<cr>", "Save File" },
          S = { "<cmd>wall<cr>", "Save All Files" },
          c = { "<cmd>bd<cr>", "Close Buffer" },
        },

        -- Editor / UI
        e = {
          name = "Explorer/Editor",
          e = { function() Snacks.explorer.toggle() end, "Toggle Explorer" },
          f = { function() Snacks.explorer.find_file() end, "Find in Explorer" },
          h = { function() Snacks.dashboard.open() end, "Home Dashboard" },
        },

        -- Search
        s = {
          name = "Search",
          f = { function() Snacks.picker.files() end, "Files" },
          b = { function() Snacks.picker.buffers() end, "Buffers" },
          g = { function() Snacks.picker.live_grep() end, "Grep" },
          h = { function() Snacks.picker.help_tags() end, "Help Tags" },
          s = { function() Snacks.picker.symbols() end, "Symbols" },
          c = { function() Snacks.picker.commands() end, "Commands" },
        },

        -- Buffer operations
        b = {
          name = "Buffer",
          b = { function() Snacks.picker.buffers() end, "Switch Buffer" },
          d = { "<cmd>bd<cr>", "Delete Buffer" },
          n = { "<cmd>bnext<cr>", "Next Buffer" },
          p = { "<cmd>bprevious<cr>", "Previous Buffer" },
          f = { function() Snacks.bigfile.toggle() end, "Toggle Big File Mode" },
        },

        -- Window operations
        w = {
          name = "Window",
          v = { "<cmd>vsplit<cr>", "Vertical Split" },
          s = { "<cmd>split<cr>", "Horizontal Split" },
          c = { "<cmd>close<cr>", "Close Window" },
          o = { "<cmd>only<cr>", "Close Other Windows" },
          h = { "<C-w>h", "Move Left" },
          j = { "<C-w>j", "Move Down" },
          k = { "<C-w>k", "Move Up" },
          l = { "<C-w>l", "Move Right" },
        },

        -- Code actions
        c = {
          name = "Code",
          f = { "<cmd>lua vim.lsp.buf.format()<cr>", "Format" },
          a = { "<cmd>lua vim.lsp.buf.code_action()<cr>", "Code Action" },
          r = { "<cmd>lua vim.lsp.buf.rename()<cr>", "Rename" },
          d = { "<cmd>lua vim.lsp.buf.definition()<cr>", "Go to Definition" },
          D = { "<cmd>lua vim.lsp.buf.declaration()<cr>", "Go to Declaration" },
          i = { "<cmd>lua vim.lsp.buf.implementation()<cr>", "Go to Implementation" },
          R = { "<cmd>lua vim.lsp.buf.references()<cr>", "Find References" },
          h = { "<cmd>lua vim.lsp.buf.hover()<cr>", "Hover Documentation" },
        },

        -- Git operations
        g = {
          name = "Git",
          g = { function() Snacks.picker.git_status() end, "Git Status" },
          b = { function() Snacks.picker.git_branches() end, "Branches" },
          c = { function() Snacks.picker.git_commits() end, "Commits" },
          C = { "<cmd>Git commit<cr>", "Commit" },
          p = { "<cmd>Git push<cr>", "Push" },
          l = { "<cmd>Git pull<cr>", "Pull" },
        },

        -- Toggle options
        t = {
          name = "Toggle",
          n = { "<cmd>set relativenumber!<cr>", "Relative Numbers" },
          w = { "<cmd>set wrap!<cr>", "Word Wrap" },
          h = { "<cmd>nohlsearch<cr>", "Search Highlight" },
          s = { "<cmd>set spell!<cr>", "Spell Check" },
          i = { function() Snacks.indent.refresh() end, "Indent Guides" },
        },

        -- Copilot operations
        p = {
          name = "Copilot",
          e = { "<cmd>Copilot enable<cr>", "Enable Copilot" },
          d = { "<cmd>Copilot disable<cr>", "Disable Copilot" },
          s = { "<cmd>Copilot status<cr>", "Copilot Status" },
          p = { "<cmd>Copilot panel<cr>", "Open Suggestions Panel" },
        },

        -- Quit / Session
        q = {
          name = "Quit/Session",
          q = { "<cmd>qa<cr>", "Quit All" },
          w = { "<cmd>wqa<cr>", "Save and Quit All" },
          s = { "<cmd>SessionSave<cr>", "Save Session" },
          l = { "<cmd>SessionLoad<cr>", "Load Session" },
        },
      },

      -- Buffer navigation
      ["<S-l>"] = { "<cmd>bnext<cr>", "Next Buffer" },
      ["<S-h>"] = { "<cmd>bprevious<cr>", "Previous Buffer" },
    })
  end,
}
