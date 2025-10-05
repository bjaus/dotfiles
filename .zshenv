# ==================== VERSION MANAGERS ====================
# Goenv
export GOENV_ROOT="$HOME/.goenv"
export PATH="$GOENV_ROOT/bin:$PATH"

# Pyenv
export PYENV_ROOT="$HOME/.pyenv"
export PATH="$PYENV_ROOT/bin:$PATH"

# ==================== LANGUAGE CONFIGURATION ====================
# Go
export GOPRIVATE="github.com/rewardStyle/*"

# Python
export PYTHONPATH="$HOME/.pyenv/shims/python:$HOME/.local/share/nvim/site/plugin:$PYTHONPATH"
export PIPENV_VENV_IN_PROJECT=true

# Rust
export RUST_BACKTRACE=1

# Flutter
# export CHROME_EXECUTABLE="/Applications/Arc.app/Contents/MacOS/Arc"
export CHROME_EXECUTABLE="/Applications/Brave Browser.app/Contents/MacOS/Brave Browser"

# ==================== TOOLS & SERVICES ====================
# GitHub
export GH_HOST="github.com"
export GH_COPILOT_AGENT_MODE=1

# Docker
export DOCKER_DEFAULT_PLATFORM=linux/amd64

# AWS
export AWS_SDK_LOAD_CONFIG=true

# AWSume alias and completion
alias awsume="source \$(pyenv which awsume)"
fpath=(~/.awsume/zsh-autocomplete/ $fpath)

# ==================== SHELL CONFIGURATION ====================
# History
export HISTSIZE=20000
export HISTCONTROL=ignoredups

# ==================== SECRETS ====================
[[ -f "$HOME/.zsh-secrets" ]] && source "$HOME/.zsh-secrets"
[[ -f "$HOME/.zsh-ltk" ]] && source "$HOME/.zsh-ltk"
