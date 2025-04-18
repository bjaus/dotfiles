# Goenv
export GOENV_ROOT="$HOME/.goenv"
export PATH="$GOENV_ROOT/bin:$PATH"

# Pyenv
export PYENV_ROOT="$HOME/.pyenv"
export PATH="$PYENV_ROOT/bin:$PATH"

# GOPRIVATE for Go
export GOPRIVATE="github.com/rewardStyle/*"

# Python path tweaks
export PYTHONPATH="$HOME/.pyenv/shims/python:$HOME/.local/share/nvim/site/plugin:$PYTHONPATH"

# GitHub
export GH_HOST="github.com"

# Pipenv
export PIPENV_VENV_IN_PROJECT=true

# Rust
export RUST_BACKTRACE=1

# Docker
export DOCKER_DEFAULT_PLATFORM=linux/amd64

# AWS SDK
export AWS_SDK_LOAD_CONFIG=true

# History
export HISTSIZE=20000
export HISTCONTROL=ignoredups

# Secrets
[[ -f "$HOME/.zsh-secrets" ]] && source "$HOME/.zsh-secrets"
[[ -f "$HOME/.zsh-ltk" ]] && source "$HOME/.zsh-ltk"
