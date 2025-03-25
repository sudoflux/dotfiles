# Dotfiles

Personal dotfiles configuration for cross-machine synchronization.

## Contents

- `.bashrc` - Bash shell configuration with aliases and functions
- `.gitconfig` - Git configuration with user identity and useful aliases
- `.gitignore_global` - Global gitignore file
- `.vscode/` - VS Code settings and recommended extensions
- `.cursor/` - Cursor editor settings
- `.config/nvim/` - Basic Neovim configuration for future use

## Installation

1. Clone this repository to your home directory:

```bash
git clone https://github.com/sudoflux/dotfiles.git ~/dotfiles
```

2. Run the installation script:

```bash
cd ~/dotfiles
./install_dotfiles.sh
```

The installation script will:
- Create backups of your existing dotfiles
- Create symbolic links from the repository files to your home directory
- Set up VS Code and Cursor settings if they're installed

## Update

To update your dotfiles across machines:

1. Make changes to the dotfiles in the repository
2. Commit and push the changes to GitHub
3. On other machines, pull the latest changes:

```bash
cd ~/dotfiles
git pull
./install_dotfiles.sh
```

## Customization

- `.bashrc`: Add your machine-specific configurations at the end of this file
- `.gitconfig`: The base config contains the identity - add machine-specific configs as needed
- VS Code/Cursor: Modify settings.json to your preferences

## VS Code and Cursor Extensions

The `.vscode/extensions.json` file contains recommended extensions. To install them:

1. Open VS Code/Cursor
2. Go to Extensions tab
3. Type `@recommended` in the search box
4. Install the workspace recommended extensions

## Neovim Setup (Future)

The basic Neovim configuration is included for future use. To enhance it:

1. Uncomment the plugin section in `.config/nvim/init.vim`
2. Install a plugin manager like vim-plug:

```bash
sh -c 'curl -fLo "${XDG_DATA_HOME:-$HOME/.local/share}"/nvim/site/autoload/plug.vim --create-dirs \
       https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim'
```

3. Open Neovim and run `:PlugInstall`
