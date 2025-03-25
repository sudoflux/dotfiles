# Dotfiles

Personal dotfiles configuration for cross-machine synchronization.

## Contents

- `.bashrc` - Bash shell configuration with aliases and functions
  - Useful aliases for Git, Docker, and Kubernetes
  - Secure shell functions for extraction, directory creation, process finding
  - Improved command-v consistency for better portability
  - Intelligent path handling and command completion
- `.gitconfig` - Git configuration with user identity and useful aliases
  - Default branch set to "main"
  - URL rewriting for SSH connections to GitHub/GitLab
  - Comprehensive aliases for common git workflows
- `.gitignore_global` - Global gitignore file for common patterns
- `.ssh/config` - SSH configuration with sensible defaults (keys not included)
- `.vscode/` - VS Code settings and recommended extensions
  - Auto-formatting on save
  - ESLint integration
  - Consistent code style settings
- `.cursor/` - Cursor editor settings
  - VS Code-compatible settings plus Cursor-specific AI features
- `.config/nvim/` - Basic Neovim configuration for future use

## Installation

### First-time Setup on a New Machine

1. For the initial clone of this repository, use HTTPS (since SSH isn't configured yet):

```bash
git clone https://github.com/sudoflux/dotfiles.git ~/dotfiles
```

2. Run the installation script:

```bash
cd ~/dotfiles
./install_dotfiles.sh
```

3. Set up your SSH keys for GitHub following the instructions in the [GitHub SSH Setup](#github-ssh-setup) section.

4. After SSH is set up, you can optionally switch the repository's remote to use SSH:

```bash
cd ~/dotfiles
git remote set-url origin git@github.com:sudoflux/dotfiles.git
```

The installation script will:
- Create backups of your existing dotfiles
- Create symbolic links from the repository files to your home directory
- Set up VS Code and Cursor settings if they're installed
- Set proper permissions for SSH files

## Features

### Shell Enhancements
- **Command completion** for common tools
- **Extract function** - Handle various archive formats with a single command
- **Improved process search** - Find processes by name without false positives
- **Directory creation** - Make and change to a directory in one command
- **Automatic SSH agent setup**

### Editor Configuration
- **VS Code & Cursor** - Consistent settings between editors including:
  - Code formatting on save
  - Syntax highlighting and bracket matching
  - Theme and icon configuration
  - Recommended extensions

### Git Workflow
- **Useful aliases** for common git commands
- **Enhanced logging** with color and formatting
- **SSH integration** with GitHub and GitLab
- **Default settings** for pull, push, fetch behaviors

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
ssh-keygen -t ed25519 -C "jfletcherj86@gmail.com"

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

## GitHub SSH Setup

Setting up SSH for GitHub repositories makes cloning, pushing, and pulling more secure and convenient by eliminating the need for password authentication.

### Initial Setup

1. Generate a GitHub-specific SSH key (if you don't have one already):

```bash
ssh-keygen -t ed25519 -C "jfletcherj86@gmail.com" -f ~/.ssh/github_ed25519
```

2. Add the key to your SSH agent:

```bash
eval "$(ssh-agent -s)"
ssh-add ~/.ssh/github_ed25519
```

3. Add the public key to your GitHub account:
   - Copy the public key to clipboard:
     ```bash
     cat ~/.ssh/github_ed25519.pub | xclip -selection clipboard
     # On macOS: cat ~/.ssh/github_ed25519.pub | pbcopy
     # Without clipboard tools: cat ~/.ssh/github_ed25519.pub
     ```
   - Go to GitHub → Settings → SSH and GPG keys → New SSH key
   - Paste the key and give it a meaningful title (e.g., "Work Laptop 2025")
   - Click "Add SSH key"

4. Verify the connection:

```bash
ssh -T git@github.com
```

### Converting Repositories from HTTPS to SSH

For existing repositories:

```bash
# Check current remote URL
git remote -v

# Change from HTTPS to SSH
git remote set-url origin git@github.com:sudoflux/REPOSITORY.git
```

### Default to SSH for New Repositories

Configure Git to automatically convert HTTPS GitHub URLs to SSH when adding remotes:

```bash
git config --global url."git@github.com:".insteadOf "https://github.com/"
```

This configuration is already included in your dotfiles `.gitconfig`.
