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

## SSH Keys Management

SSH keys should **never** be stored in git repositories for security reasons. Instead, here are recommended approaches for managing SSH keys across machines:

### Option 1: Manual copy (Most secure)

Generate and manually transfer keys using secure methods:

```bash
# Generate new SSH key on source machine
ssh-keygen -t ed25519 -C "your_email@example.com"

# Secure copy to new machine (various options)
# Option A: Direct secure copy if SSH is already set up
scp -P port ~/.ssh/id_ed25519* user@newmachine:~/.ssh/

# Option B: Use a temporary encrypted archive
tar czf - ~/.ssh | gpg -c > ssh_keys.tar.gz.gpg
# Transfer file securely, then on new machine:
gpg -d ssh_keys.tar.gz.gpg | tar xzf - -C ~
# Delete the archive afterward
```

### Option 2: Password manager with encrypted notes

Store your SSH keys in an encrypted note within a trusted password manager like Bitwarden, 1Password, or KeePassXC.

### Option 3: Using ssh-copy-id

If you already have SSH access to the new machine without keys:

```bash
ssh-copy-id -i ~/.ssh/id_ed25519.pub user@newmachine
```

### SSH Config Tips

Your SSH configuration can be safely stored in the dotfiles repo since it doesn't contain sensitive data:

```bash
# Create SSH config file if it doesn't exist
mkdir -p ~/.ssh && touch ~/.ssh/config && chmod 600 ~/.ssh/config

# Add it to the dotfiles (excluded from repository by default)
# If you want to include it, modify install_dotfiles.sh
```

Remember to always set proper permissions on SSH files:
```bash
chmod 700 ~/.ssh
chmod 600 ~/.ssh/id_ed25519 
chmod 644 ~/.ssh/id_ed25519.pub
chmod 600 ~/.ssh/config
```
