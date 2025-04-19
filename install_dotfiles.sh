#!/bin/bash

# Dotfiles installation script
# This script creates symlinks from the home directory to any desired dotfiles in ~/dotfiles

# Variables
dotfiles_dir="$HOME/dotfiles"
backup_dir="$HOME/.dotfiles_backup"
date_str=$(date +%Y%m%d_%H%M%S)

# List of files/folders to symlink in homedir
files=".bashrc .gitconfig .gitignore_global"
config_dirs=".config .vscode .cursor"

# Create backup directory
echo "Creating backup directory: $backup_dir/$date_str"
mkdir -p "$backup_dir/$date_str"

# Backup and create symlinks for regular dotfiles
for file in $files; do
  # Backup existing file
  if [ -f "$HOME/$file" ] || [ -L "$HOME/$file" ]; then
    echo "Backing up $file"
    mv "$HOME/$file" "$backup_dir/$date_str/"
  fi

  # Create symlink
  echo "Creating symlink to $file"
  ln -sf "$dotfiles_dir/$file" "$HOME/$file"
done

# Handle SSH config if it exists (only config file, not keys)
if [ -f "$dotfiles_dir/.ssh/config" ]; then
  # Ensure .ssh directory exists with proper permissions
  mkdir -p "$HOME/.ssh"
  chmod 700 "$HOME/.ssh"

  # Create SSH control directory for multiplexing
  mkdir -p "$HOME/.ssh/control"
  chmod 700 "$HOME/.ssh/control"

  # Backup existing config
  if [ -f "$HOME/.ssh/config" ] || [ -L "$HOME/.ssh/config" ]; then
    echo "Backing up SSH config"
    mkdir -p "$backup_dir/$date_str/.ssh"
    mv "$HOME/.ssh/config" "$backup_dir/$date_str/.ssh/"
  fi

  # Create symlink
  echo "Creating symlink to SSH config"
  ln -sf "$dotfiles_dir/.ssh/config" "$HOME/.ssh/config"
  chmod 600 "$HOME/.ssh/config"
fi

# Handle .config directory and its nested directories (like nvim)
if [ -d "$dotfiles_dir/.config" ]; then
  # Ensure .config directory exists in home
  mkdir -p "$HOME/.config"

  # Loop through subdirectories in dotfiles/.config
  for dir in $(find "$dotfiles_dir/.config" -mindepth 1 -maxdepth 1 -type d); do
    dir_name=$(basename "$dir")

    # Backup existing directory
    if [ -d "$HOME/.config/$dir_name" ] || [ -L "$HOME/.config/$dir_name" ]; then
      echo "Backing up .config/$dir_name"
      mkdir -p "$backup_dir/$date_str/.config"
      mv "$HOME/.config/$dir_name" "$backup_dir/$date_str/.config/"
    fi

    # Create symlink
    echo "Creating symlink to .config/$dir_name"
    ln -sf "$dotfiles_dir/.config/$dir_name" "$HOME/.config/$dir_name"
  done
fi

# Ensure lua config directory exists and is symlinked
if [ -d "$dotfiles_dir/.config/nvim/lua" ]; then
  mkdir -p "$HOME/.config/nvim"

  if [ -d "$HOME/.config/nvim/lua" ] || [ -L "$HOME/.config/nvim/lua" ]; then
    echo "Backing up existing Neovim lua/ directory"
    mkdir -p "$backup_dir/$date_str/.config/nvim"
    mv "$HOME/.config/nvim/lua" "$backup_dir/$date_str/.config/nvim/"
  fi

  echo "Creating symlink to .config/nvim/lua"
  ln -sf "$dotfiles_dir/.config/nvim/lua" "$HOME/.config/nvim/lua"
fi

# Neovim: Headless Plugin Sync
if command -v nvim &>/dev/null; then
  echo "Running Neovim headless to install plugins..."
  nvim --headless "+Lazy! sync" +qa
else
  echo "Neovim not found — skipping plugin installation"
fi

# Handle VS Code settings
if [ -d "$dotfiles_dir/.vscode" ]; then
  # Get VS Code settings directory path based on OS
  case "$(uname)" in
    "Darwin")
    vscode_dir="$HOME/Library/Application Support/Code/User"
    ;;
    "Linux")
    vscode_dir="$HOME/.config/Code/User"
    ;;
    "MINGW"*|"MSYS"*|"CYGWIN"*)
    vscode_dir="$APPDATA/Code/User"
    ;;
  *)
    echo "Unsupported OS for VS Code settings"
    vscode_dir=""
    ;;
  esac

  # If VS Code directory exists, create symlinks
  if [ -n "$vscode_dir" ] && [ -d "$vscode_dir" ]; then
    for file in "$dotfiles_dir/.vscode"/*; do
      file_name=$(basename "$file")

      # Backup existing file
      if [ -f "$vscode_dir/$file_name" ] || [ -L "$vscode_dir/$file_name" ]; then
        echo "Backing up VS Code $file_name"
        mkdir -p "$backup_dir/$date_str/vscode"
        mv "$vscode_dir/$file_name" "$backup_dir/$date_str/vscode/"
      fi

      # Create symlink
      echo "Creating symlink to VS Code $file_name"
      ln -sf "$file" "$vscode_dir/$file_name"
    done
  else
    echo "VS Code doesn't appear to be installed. Skipping VS Code configurations."
  fi
fi

# Handle Cursor settings
if [ -d "$dotfiles_dir/.cursor" ]; then
  # Get Cursor settings directory path based on OS
  case "$(uname)" in
    "Darwin")
      cursor_dir="$HOME/Library/Application Support/Cursor/User"
      ;;
    "Linux")
      cursor_dir="$HOME/.config/Cursor/User"
      ;;
    "MINGW"*|"MSYS"*|"CYGWIN"*)
      cursor_dir="$APPDATA/Cursor/User"
      ;;
    *)
      echo "Unsupported OS for Cursor settings"
      cursor_dir=""
      ;;
  esac

  # If Cursor directory exists, create symlinks
  if [ -n "$cursor_dir" ]; then
    # Create directory if it doesn't exist
    mkdir -p "$cursor_dir"

    for file in "$dotfiles_dir/.cursor"/*; do
      file_name=$(basename "$file")

      # Backup existing file
      if [ -f "$cursor_dir/$file_name" ] || [ -L "$cursor_dir/$file_name" ]; then
        echo "Backing up Cursor $file_name"
        mkdir -p "$backup_dir/$date_str/cursor"
        mv "$cursor_dir/$file_name" "$backup_dir/$date_str/cursor/"
      fi

      # Create symlink
      echo "Creating symlink to Cursor $file_name"
      ln -sf "$file" "$cursor_dir/$file_name"
    done
  else
    echo "Could not determine Cursor settings location. Skipping Cursor configurations."
  fi
fi

echo "Dotfiles installation complete!"
echo "Backup of original files created at: $backup_dir/$date_str"
