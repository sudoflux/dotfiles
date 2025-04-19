#!/bin/bash

# Dotfiles installation script
# This script creates symlinks from the home directory to any desired dotfiles in ~/dotfiles

set -e

# Variables
dotfiles_dir="$HOME/dotfiles"
backup_dir="$HOME/.dotfiles_backup"
date_str=$(date +%Y%m%d_%H%M%S)

# List of files/folders to symlink in homedir
files=(.bashrc .gitconfig .gitignore_global)

# Create backup directory
echo "Creating backup directory: $backup_dir/$date_str"
mkdir -p "$backup_dir/$date_str"

# Backup and create symlinks for regular dotfiles
for file in "${files[@]}"; do
  if [ -e "$HOME/$file" ]; then
    echo "Backing up $file"
    mv "$HOME/$file" "$backup_dir/$date_str/"
  fi
  echo "Creating symlink to $file"
  ln -sf "$dotfiles_dir/$file" "$HOME/$file"
Done

done

# Handle SSH config if it exists
if [ -f "$dotfiles_dir/.ssh/config" ]; then
  mkdir -p "$HOME/.ssh"
  chmod 700 "$HOME/.ssh"
  mkdir -p "$HOME/.ssh/control"
  chmod 700 "$HOME/.ssh/control"

  if [ -e "$HOME/.ssh/config" ]; then
    echo "Backing up SSH config"
    mkdir -p "$backup_dir/$date_str/.ssh"
    mv "$HOME/.ssh/config" "$backup_dir/$date_str/.ssh/"
  fi

  echo "Creating symlink to SSH config"
  ln -sf "$dotfiles_dir/.ssh/config" "$HOME/.ssh/config"
  chmod 600 "$HOME/.ssh/config"
fi

# Remove conflicting init.vim
if [ -f "$HOME/.config/nvim/init.vim" ]; then
  echo "Removing conflicting init.vim"
  rm "$HOME/.config/nvim/init.vim"
fi

# Symlink all .config directories
if [ -d "$dotfiles_dir/.config" ]; then
  mkdir -p "$HOME/.config"
  for dir in "$dotfiles_dir/.config"/*; do
    dir_name=$(basename "$dir")
    if [ -e "$HOME/.config/$dir_name" ]; then
      echo "Backing up .config/$dir_name"
      mkdir -p "$backup_dir/$date_str/.config"
      mv "$HOME/.config/$dir_name" "$backup_dir/$date_str/.config/"
    fi
    echo "Creating symlink to .config/$dir_name"
    ln -sf "$dir" "$HOME/.config/$dir_name"
  done
fi

# Run Lazy sync if Neovim is installed
if command -v nvim &>/dev/null; then
  echo "Running Neovim headless to sync plugins..."
  nvim --headless "+Lazy! sync" +qa
fi

# VS Code settings
if [ -d "$dotfiles_dir/.vscode" ]; then
  case "$(uname)" in
    Darwin) vscode_user="$HOME/Library/Application Support/Code/User" ;;
    Linux) vscode_user="$HOME/.config/Code/User" ;;
    MINGW*|MSYS*|CYGWIN*) vscode_user="$APPDATA/Code/User" ;;
    *) vscode_user="" ;;
  esac
  if [ -n "$vscode_user" ] && [ -d "$vscode_user" ]; then
    for file in "$dotfiles_dir/.vscode"/*; do
      file_name=$(basename "$file")
      if [ -e "$vscode_user/$file_name" ]; then
        mkdir -p "$backup_dir/$date_str/vscode"
        mv "$vscode_user/$file_name" "$backup_dir/$date_str/vscode/"
      fi
      echo "Creating symlink to VS Code $file_name"
      ln -sf "$file" "$vscode_user/$file_name"
    done
  else
    echo "VS Code not detected. Skipping."
  fi
fi

# Cursor settings
if [ -d "$dotfiles_dir/.cursor" ]; then
  case "$(uname)" in
    Darwin) cursor_user="$HOME/Library/Application Support/Cursor/User" ;;
    Linux) cursor_user="$HOME/.config/Cursor/User" ;;
    MINGW*|MSYS*|CYGWIN*) cursor_user="$APPDATA/Cursor/User" ;;
    *) cursor_user="" ;;
  esac
  if [ -n "$cursor_user" ]; then
    mkdir -p "$cursor_user"
    for file in "$dotfiles_dir/.cursor"/*; do
      file_name=$(basename "$file")
      if [ -e "$cursor_user/$file_name" ]; then
        mkdir -p "$backup_dir/$date_str/cursor"
        mv "$cursor_user/$file_name" "$backup_dir/$date_str/cursor/"
      fi
      echo "Creating symlink to Cursor $file_name"
      ln -sf "$file" "$cursor_user/$file_name"
    done
  else
    echo "Cursor path not found. Skipping."
  fi
fi

# Ensure nerd-fonts.txt exists with at least one font
fonts_dir="$dotfiles_dir/fonts"
mkdir -p "$fonts_dir"
fonts_txt="$fonts_dir/nerd-fonts.txt"
if [ ! -f "$fonts_txt" ]; then
  echo "Creating default nerd-fonts.txt with JetBrainsMono"
  cat <<EOF > "$fonts_txt"
https://github.com/ryanoasis/nerd-fonts/releases/latest/download/JetBrainsMono.zip
EOF
fi

# Install Nerd Fonts from nerd-fonts.txt (idempotent)
if [ -f "$fonts_txt" ]; then
  echo "Installing Nerd Fonts..."
  mkdir -p "$HOME/.local/share/fonts"
  while IFS= read -r font_url; do
    font_zip_name=$(basename "$font_url")
    extract_path="$HOME/.local/share/fonts/${font_zip_name%.zip}"
    if [ ! -d "$extract_path" ]; then
      echo "  Downloading $font_zip_name"
      curl -Lo "$HOME/.local/share/fonts/$font_zip_name" "$font_url"
      echo "  Extracting $font_zip_name"
      unzip -o "$HOME/.local/share/fonts/$font_zip_name" -d "$extract_path" > /dev/null || true
      rm "$HOME/.local/share/fonts/$font_zip_name"
    else
      echo "  Skipping $font_zip_name (already extracted)"
    fi
  done < "$fonts_txt"
  fc-cache -fv > /dev/null || true
fi

# Ensure Node.js is installed (for Copilot)
if ! command -v node &>/dev/null; then
  echo "Installing Node.js (required for GitHub Copilot)..."
  sudo apt-get update && sudo apt-get install -y nodejs npm
fi

# Final message
echo "Dotfiles installation complete!"
echo "Backup of original files created at: $backup_dir/$date_str"
echo -e "\e[31mTo finish GitHub Copilot setup, open Neovim and run :Copilot auth once.\e[0m"
