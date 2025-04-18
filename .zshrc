# Oh My Zsh base
export ZSH="$HOME/.oh-my-zsh"
ZSH_THEME="zhann"
plugins=(git aliases autojump emoji emotty)
source $ZSH/oh-my-zsh.sh

# Setup autojump
[[ -f /opt/homebrew/etc/profile.d/autojump.sh ]] && source /opt/homebrew/etc/profile.d/autojump.sh

# PNPM
export PNPM_HOME="$HOME/Library/pnpm"
[[ ":$PATH:" != *":$PNPM_HOME:"* ]] && export PATH="$PNPM_HOME:$PATH"

# Add personal scripts
export PATH="$HOME/.scripts:$HOME/scripts:$PATH"

# Language settings
export LANG="en_US.UTF-8"

# Editor
if [[ -n $SSH_CONNECTION ]]; then
  export EDITOR="vim"
else
  export EDITOR="nvim"
fi

# Atuin history shell integration
[[ -f "$HOME/.config/atuin/config.toml" && -f "$HOME/.atuin/bin/env" ]] && {
  source "$HOME/.atuin/bin/env"
  eval "$(atuin init zsh)"
}

# Additional config
[[ -f "$HOME/.tnsrc" ]] && source "$HOME/.tnsrc"
[[ -f "$HOME/.zshrc.extended" ]] && source "$HOME/.zshrc.extended"

# Aliases
alias cat="bat"
alias clip="tr -d '\n' | pbcopy"
alias pn="pnpm"
alias nv="nvim"
alias rmswp="rm -f /tmp/*.swp"

# AWSume
alias awsume="source \$(pyenv which awsume)"
fpath=(~/.awsume/zsh-autocomplete/ $fpath)

# Deduplicate PATH (Zsh feature)
typeset -U path PATH

### MANAGED BY RANCHER DESKTOP START (DO NOT EDIT)
export PATH="/Users/bjaus/.rd/bin:$PATH"
### MANAGED BY RANCHER DESKTOP END (DO NOT EDIT)

# pyenv init (interactive shell logic)
if command -v pyenv &>/dev/null; then
  eval "$(pyenv init --path)"
  eval "$(pyenv init -)"
fi

# Ensure goenv shims come first
export PATH="$HOME/.goenv/shims:$PATH"

# Initialize goenv (adds shims and dynamic version switching)
if command -v goenv &>/dev/null; then
  eval "$(goenv init -)"
fi
