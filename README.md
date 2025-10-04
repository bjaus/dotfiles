# Dotfiles

Personal development environment configuration.

## Quick Setup (New Machine)

### 1. Install Homebrew
```bash
/bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
```

### 2. Clone Dotfiles
```bash
git clone https://github.com/yourusername/dotfiles.git ~/Projects/dotfiles
cd ~/Projects/dotfiles
```

### 3. Install All Packages
```bash
brew bundle --file=~/Projects/dotfiles/Brewfile
```

### 4. Install Oh My Zsh
```bash
sh -c "$(curl -fsSL https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh)"
```

### 5. Symlink Configuration Files
```bash
ln -sf ~/Projects/dotfiles/.zshrc ~/.zshrc
ln -sf ~/Projects/dotfiles/.zshenv ~/.zshenv
ln -sf ~/Projects/dotfiles/.tmux.conf ~/.tmux.conf
ln -sf ~/Projects/dotfiles/.gitconfig ~/.gitconfig
ln -sf ~/Projects/dotfiles/.config/nvim ~/.config/nvim
ln -sf ~/Projects/dotfiles/.config/ghostty ~/.config/ghostty
```

### 6. Install Additional Tools

#### Node.js (via NVM)
```bash
nvm install --lts
nvm use --lts
```

#### Python (via pyenv)
```bash
pyenv install 3.12.0
pyenv global 3.12.0
```

#### Go (via goenv)
```bash
goenv install 1.21.0
goenv global 1.21.0
```

#### Rust
```bash
rustup-init
```

#### CocoaPods (for Flutter/iOS)
```bash
# Already installed via Brewfile (ruby)
gem install cocoapods
```

### 7. Install Neovim Plugins
```bash
nvim --headless "+Lazy! sync" +qa
```

### 8. Restart Terminal
```bash
exec zsh
```

## Keeping Brewfile Updated

Whenever you install a new package:

```bash
# Install the package
brew install <package-name>

# Manually add it to Brewfile with a comment
cd ~/Projects/dotfiles
# Edit Brewfile and add:
# brew "package-name"  # Description of what it does

git add Brewfile
git commit -m "Add <package-name> to Brewfile"
git push
```

**Note**: Don't use `brew bundle dump --force` as it will remove all comments. Instead, manually add new packages to maintain documentation.

## Key Tools Installed

### Command Line
- **Shell**: Zsh + Oh My Zsh
- **Terminal**: Ghostty
- **Multiplexer**: tmux
- **Editor**: Neovim
- **Git**: lazygit, gh (GitHub CLI)
- **Task Runner**: Task (Taskfile)

### Development
- **Languages**: Go (goenv), Python (pyenv), Node.js (nvm), Rust, Ruby, Dart/Flutter
- **Package Managers**: pnpm, pip, cargo, gem, pub
- **Tools**: Docker, awscli, terraform, pulumi

### Utilities
- **Search**: ripgrep (rg), fd
- **Files**: bat (cat), tree
- **Navigation**: autojump
- **HTTP**: httpie

## Directory Structure

```
~/Projects/dotfiles/
├── .config/
│   ├── nvim/           # Neovim configuration
│   ├── ghostty/        # Ghostty terminal config
│   └── zsh/            # Zsh helper scripts
├── .gitconfig          # Git configuration
├── .tmux.conf          # Tmux configuration
├── .zshrc              # Zsh configuration
├── .zshenv             # Zsh environment variables
├── Brewfile            # Homebrew packages list
└── README.md           # This file
```

## Troubleshooting

### Flutter Doctor Issues
```bash
# Install iOS simulator
xcodebuild -downloadPlatform iOS

# Verify CocoaPods
pod --version

# Check Chrome path
echo $CHROME_EXECUTABLE
```

### Neovim Plugin Errors
```bash
# Clean and reinstall plugins
rm -rf ~/.local/share/nvim
nvim --headless "+Lazy! sync" +qa
```

### Git Conflicts in Plugins
```bash
cd ~/.local/share/nvim/lazy/<plugin-name>
git clean -fd
git checkout .
```
