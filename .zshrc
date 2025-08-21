# Oh My Zsh base
export ZSH="$HOME/.oh-my-zsh"
ZSH_THEME="zhann"
plugins=(git aliases autojump emoji emotty)
source $ZSH/oh-my-zsh.sh

# Enable vi mode
bindkey -v

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

# Aliases
alias ca='cursor-agent'
alias cat="bat"
alias cl='claude'
alias clip="tr -d '\n' | pbcopy"
alias nv="nvim"
alias pn="pnpm"
alias rmswp="rm -f /tmp/*.swp"
alias ta='tmux attach -t "$(tmux ls | fzf | cut -d: -f1)"'
alias md="glow"

# Functions

function tmux-rename() {
  local session
  session=$(tmux ls | fzf | cut -d: -f1) || return
  [[ -z "$session" ]] && return
  echo -n "New name: "
  read new_name || return
  [[ "$new_name" == "$session" || -z "$new_name" ]] && return
  tmux rename-session -t "$session" "$new_name"
}

function tmux-kill() {
  local session
  session=$(tmux ls | fzf | cut -d: -f1) || return
  [[ -z "$session" ]] && return

  echo -n "Kill session '$session'? [y/N]: "
  read confirm
  [[ "$confirm" =~ ^[Yy]$ ]] && tmux kill-session -t "$session"
}

function tmux-kill-hard() {
  local session
  session=$(tmux ls | fzf | cut -d: -f1) || return
  [[ -n "$session" ]] && tmux kill-session -t "$session"
}

function git-stash() {
	local stash total i action
	stash=("${(@f)$(git stash list)}")
	total=${#stash[@]}
	if (( total == 0 ))
	then
		echo "No stashes found."
		return 0
	fi
	for ((i = 1; i <= total; i++)) do
		local entry="${stash[i]}"
		local ref=$(echo "$entry" | cut -d: -f1)
		echo
		echo "[$i/$total] $entry"
		echo "--------------------"
		git stash show --stat "$ref"
		echo
		read "action?[a]pply, [p]op, [s]how, [n]ext, [q]uit: "
		case "$action" in
			(a | A) echo "Applying $ref..."
				git stash apply "$ref"
				return 0 ;;
			(p | P) echo "Popping $ref..."
				git stash pop "$ref"
				return 0 ;;
			(s | S) echo "Full patch for $ref:"
				git stash show -p "$ref" | less
				((i--)) ;;
			(q | Q) echo "Quitting."
				return 0 ;;
			(n | N | "") continue ;;
			(*) echo "Unknown option. Skipping." ;;
		esac
	done
	echo "No more stashes."
}

function git-checkout() {
  branch=$(git for-each-ref --format='%(refname:short)' refs/heads/ refs/remotes/ | sort -u | fzf)
  if [ -n "$branch" ]; then
    if [[ "$branch" == origin/* ]]; then
      git checkout -t "$branch"
    else
      git checkout "$branch"
    fi
  fi
}

# Integration

## AWSume
alias awsume="source \$(pyenv which awsume)"
fpath=(~/.awsume/zsh-autocomplete/ $fpath)

## Deduplicate PATH (Zsh feature)
typeset -U path PATH

### MANAGED BY RANCHER DESKTOP START (DO NOT EDIT)
export PATH="/Users/bjaus/.rd/bin:$PATH"
### MANAGED BY RANCHER DESKTOP END (DO NOT EDIT)

## pyenv init (interactive shell logic)
if command -v pyenv &>/dev/null; then
  eval "$(pyenv init --path)"
  eval "$(pyenv init -)"
fi

## Ensure goenv shims come first
export PATH="$HOME/.goenv/shims:$PATH"

## Initialize goenv (adds shims and dynamic version switching)
if command -v goenv &>/dev/null; then
  eval "$(goenv init -)"
fi

if command -v gh &>/dev/null; then
  eval "$(gh copilot alias -- zsh)"
fi

export NVM_DIR="$HOME/.nvm"
[ -s "/opt/homebrew/opt/nvm/nvm.sh" ] && \. "/opt/homebrew/opt/nvm/nvm.sh"  # This loads nvm
[ -s "/opt/homebrew/opt/nvm/etc/bash_completion.d/nvm" ] && \. "/opt/homebrew/opt/nvm/etc/bash_completion.d/nvm"  # This loads nvm bash_completion

# Additional config
[[ -f "$HOME/.tnsrc" ]] && source "$HOME/.tnsrc"
[[ -f "$HOME/.zshrc.extended" ]] && source "$HOME/.zshrc.extended"
export PATH="$HOME/.local/bin:$PATH"
