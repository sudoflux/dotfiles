-- Dependencies check module
local M = {}

-- List of required dependencies and installation commands
local dependencies = {
  -- Image rendering tools
  { name = "magick", command = "sudo apt install imagemagick" },
  { name = "convert", command = "sudo apt install imagemagick" },
  { name = "lazygit", command = "sudo apt install lazygit" },
  -- PDF tools
  { name = "gs", command = "sudo apt install ghostscript" },
  { name = "pdflatex", command = "sudo apt install texlive-latex-base texlive-fonts-recommended texlive-fonts-extra texlive-latex-extra" },
  { name = "tectonic", command = "cargo install tectonic" },
  -- File searching tools
  { name = "fd", command = "sudo apt install fd-find" },
  { name = "rg", command = "sudo apt install ripgrep" },
  { name = "find", command = "sudo apt install findutils" },
}

-- Check if a command is available
local function is_command_available(cmd)
  local handle = io.popen("command -v " .. cmd .. " 2>/dev/null")
  if handle then
    local result = handle:read("*a")
    handle:close()
    return result and result ~= ""
  end
  return false
end

-- Function to check dependencies and display missing ones
function M.check_dependencies()
  local missing = {}

  for _, dep in ipairs(dependencies) do
    if not is_command_available(dep.name) then
      table.insert(missing, dep)
    end
  end

  if #missing > 0 then
    print("Missing dependencies detected:")
    print("----------------------------")
    for i, dep in ipairs(missing) do
      print(i .. ". " .. dep.name .. " - Install with: " .. dep.command)
    end
    print("\nRun :InstallDependencies to install all missing dependencies.")

    -- Create command to install dependencies
    vim.api.nvim_create_user_command("InstallDependencies", function()
      local term_cmd = ""
      for _, dep in ipairs(missing) do
        term_cmd = term_cmd .. dep.command .. " && "
      end
      term_cmd = term_cmd:sub(1, -4) -- Remove trailing " && "

      vim.cmd("terminal " .. term_cmd)
    end, {})
  end
end

-- Check that treesitter languages are installed
function M.ensure_treesitter_languages()
  local required_langs = {
    "css", "html", "javascript", "latex", "markdown", "markdown_inline",
    "norg", "scss", "svelte", "tsx", "typescript", "vue", "regex"
  }

  vim.api.nvim_create_autocmd("User", {
    pattern = "LazyDone",
    callback = function()
      local ts_ok, ts = pcall(require, "nvim-treesitter.configs")
      if ts_ok and ts then
        -- Ensure the languages are added to ensure_installed
        if ts.setup and type(ts.setup) == "function" then
          local opts = require("plugins.treesitter")[1].opts
          opts.ensure_installed = opts.ensure_installed or {}

          -- Add required languages if not already present
          for _, lang in ipairs(required_langs) do
            local found = false
            for _, existing in ipairs(opts.ensure_installed) do
              if existing == lang then
                found = true
                break
              end
            end

            if not found then
              table.insert(opts.ensure_installed, lang)
            end
          end

          -- Setup treesitter again with updated languages
          ts.setup(opts)
        end
      end
    end,
  })
end

-- Run the dependency check
M.check_dependencies()
M.ensure_treesitter_languages()

return M
