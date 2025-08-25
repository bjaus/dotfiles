# ==================== PERFORMANCE OPTIMIZATIONS ====================
# This .zshrc includes several optimizations for faster shell startup:
# 1. Cursor agent detection - minimal config when in AGENT_MODE
# 2. Consider lazy loading heavy tools like NVM if startup is slow
# 3. Oh My Zsh is loaded with selected plugins for balance of features/speed

# Check if running in cursor agent mode and use minimal config
if [[ "$AGENT_MODE" = "true" ]] || [[ -n "$CURSOR_AGENT" ]]; then
    # Minimal config for cursor agent - no interactive features
    export PATH="$HOME/.local/bin:$HOME/.scripts:$HOME/scripts:$HOME/Library/pnpm:$HOME/.rd/bin:$PATH"
    export EDITOR="nvim"
    export LANG="en_US.UTF-8"
    
    # Basic git aliases only
    alias g='git'
    alias gs='git status'
    alias ga='git add'
    alias gc='git commit'
    alias gp='git push'
    alias gd='git diff'
    
    # Skip all interactive features
    return
fi

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

# ==================== GENERAL ALIASES ====================
alias ca='cursor-agent'
alias cat="bat"
alias cl='claude'
alias clip="tr -d '\n' | pbcopy"
alias nv="nvim"
alias pn="pnpm"
alias rmswp="rm -f /tmp/*.swp"
alias md="glow"

# ==================== GIT ALIASES ====================
# Matching your .gitconfig aliases for consistency
alias g='git'

# Status (matching your s, sb, ss aliases)
alias gs='git s'        # git status
alias gsb='git sb'      # git status -s -b
alias gss='git ss'      # git status -s

# Add (matching your a, aa, ap aliases)
alias ga='git a'        # git add
alias gaa='git aa'      # git add --all
alias gap='git ap'      # git add --patch

# Commit (matching your c, ca, cam, can, cm aliases)
alias gc='git c'        # git commit
alias gca='git ca'      # git commit --amend
alias gcam='git cam'    # git commit -am
alias gcan='git can'    # git commit --amend --no-edit
alias gcm='git cm'      # git commit -m

# Push (matching your ps, psf, pso, psoc aliases)
alias gp='git ps'       # git push
alias gpf='git psf'     # git push --force-with-lease
alias gpo='git pso'     # git push origin
alias gpoc='git psoc'   # git push origin current-branch

# Pull (matching your pl, plo, plom aliases)
alias gpl='git pl'      # git pull
alias gplo='git plo'    # git pull origin
alias gplom='git plom'  # git pull origin master

# Fetch (matching your f, fa, fo aliases)
alias gf='git f'        # git fetch
alias gfa='git fa'      # git fetch --all
alias gfo='git fo'      # git fetch origin

# Diff (matching your d, dc, ds aliases)
alias gd='git d'        # git diff
alias gdc='git dc'      # git diff --cached
alias gds='git ds'      # git diff --stat

# Log (matching your l, lg, ll aliases)
alias gl='git ll'       # git log --oneline
alias glg='git lg'      # your custom pretty log
alias glp='git lp'      # git log --patch

# Branch (matching your b, ba, bd, bdd aliases)
alias gb='git b'        # git branch
alias gba='git ba'      # git branch -a
alias gbd='git bd'      # git branch -d
alias gbD='git bdd'     # git branch -D

# Checkout (matching your o, ob, maino aliases)
alias gco='git o'       # git checkout
alias gcob='git ob'     # git checkout -b
alias gcom='git maino'  # checkout main/master

# Rebase (matching your rb, rba, rbc, rbi aliases)
alias gr='git rb'       # git rebase
alias gra='git rba'     # git rebase --abort
alias grc='git rbc'     # git rebase --continue
alias gri='git rbi'     # git rebase --interactive

# Reset (matching your re, reh, rehh aliases)
alias gre='git re'      # git reset
alias greh='git reh'    # git reset --hard
alias grehh='git rehh'  # git reset --hard HEAD

# Stash (matching your sp, so, sa, sl, ssp aliases)
alias gst='git sp'      # git stash push
alias gstp='git so'     # git stash pop
alias gsta='git sa'     # git stash apply
alias gstl='git sl'     # git stash list
alias gsts='git ssp'    # git stash show -p

# Other (matching your cp, cpa, cpc, m, ma aliases)
alias gcp='git cp'      # git cherry-pick
alias gcpa='git cpa'    # git cherry-pick --abort
alias gcpc='git cpc'    # git cherry-pick --continue
alias gm='git m'        # git merge
alias gma='git ma'      # git merge --abort

# ==================== TMUX ALIASES ====================
alias t='tmux'
alias tn='tmux new -s'
alias tl='tmux ls'
alias ta='tmux attach -t "$(tmux ls | fzf | cut -d: -f1)"'
alias tk='tmux kill-session -t'
alias tka='tmux kill-server'
alias td='tmux detach'
alias ts='tmux switch -t'

# ==================== GIT FUNCTIONS ====================

# Interactive branch selection with preview
function gco-fzf() {
  local branches branch
  branches=$(git --no-pager branch -vv) &&
  branch=$(echo "$branches" | fzf +m --preview="git log --oneline --graph --decorate {1}" | awk '{print $1}' | sed "s/.* //") &&
  git checkout "$branch"
}

# Delete multiple branches interactively
function gb-delete() {
  local branches
  branches=$(git branch | grep -v "^\*" | fzf -m --preview="git log --oneline --graph --decorate {1} -10") &&
  echo "$branches" | xargs -n 1 git branch -d
}

# Interactive commit selection for cherry-pick
function gcp-fzf() {
  local commits commit
  commits=$(git log --oneline) &&
  commit=$(echo "$commits" | fzf --preview="git show --stat {1}" | awk '{print $1}') &&
  git cherry-pick "$commit"
}

# Show git log with file changes
function git-files() {
  git log --oneline | fzf --preview="git show --stat --color {1}" --preview-window=right:60%
}

# Interactive add with preview
function ga-fzf() {
  local files
  files=$(git status -s | awk '{print $2}' | fzf -m --preview="git diff --color {}" --preview-window=right:60%) &&
  echo "$files" | xargs git add
}

# Interactive reset with preview
function greset-fzf() {
  local files
  files=$(git diff --staged --name-only | fzf -m --preview="git diff --staged --color {}" --preview-window=right:60%) &&
  echo "$files" | xargs git reset HEAD
}

# Quick commit with generated message based on changes
function gcq() {
  local changes=$(git diff --staged --stat | head -n -1)
  if [[ -z "$changes" ]]; then
    echo "No staged changes to commit"
    return 1
  fi
  local message="$1"
  if [[ -z "$message" ]]; then
    message=$(echo "$changes" | awk '{print $1}' | xargs | sed 's/ /, /g')
    message="Update: $message"
  fi
  git commit -m "$message"
}

# Show commit diff by hash
function gshow() {
  git show $(git log --oneline | fzf --preview="git show --stat --color {1}" | awk '{print $1}')
}

# Interactive stash management (enhanced version of original)
function gst-fzf() {
  local stash action
  stash=$(git stash list | fzf --preview="echo {} | cut -d: -f1 | xargs git stash show -p" --preview-window=right:60%) || return
  [[ -z "$stash" ]] && return
  
  local ref=$(echo "$stash" | cut -d: -f1)
  echo "Selected: $stash"
  echo -n "Action [a]pply, [p]op, [d]rop, [s]how, [c]ancel: "
  read action
  
  case "$action" in
    a) git stash apply "$ref" ;;
    p) git stash pop "$ref" ;;
    d) git stash drop "$ref" ;;
    s) git stash show -p "$ref" | less ;;
    *) echo "Cancelled" ;;
  esac
}

# Create worktree
function gwt-new() {
  local branch="$1"
  local path="${2:-../$(basename $(pwd))-$branch}"
  if [[ -z "$branch" ]]; then
    echo "Usage: gwt-new <branch> [path]"
    return 1
  fi
  git worktree add "$path" -b "$branch"
  echo "Created worktree at $path for branch $branch"
}

# List and navigate worktrees
function gwt() {
  local worktree
  worktree=$(git worktree list | fzf --preview="ls -la {2}" | awk '{print $1}')
  [[ -n "$worktree" ]] && cd "$worktree"
}

# ==================== TMUX FUNCTIONS ====================

# Create or attach to session with directory name
function tns() {
  local session_name="${1:-$(basename $(pwd))}"
  tmux new-session -A -s "$session_name"
}

# Interactive session switcher with preview
function ts-fzf() {
  local session
  session=$(tmux ls 2>/dev/null | fzf --preview="tmux list-windows -t {1}" | cut -d: -f1) &&
  tmux switch-client -t "$session" 2>/dev/null || tmux attach -t "$session"
}

# Save tmux session layout
function tmux-save() {
  local session="${1:-$(tmux display-message -p '#S')}"
  local file="${2:-~/.tmux-sessions/$session.txt}"
  mkdir -p "$(dirname "$file")"
  tmux list-windows -t "$session" -F "#{window_index}:#{window_name}:#{pane_current_path}" > "$file"
  echo "Session layout saved to $file"
}

# Restore tmux session layout
function tmux-restore() {
  local file="${1:-~/.tmux-sessions/$(tmux display-message -p '#S').txt}"
  if [[ ! -f "$file" ]]; then
    echo "Layout file not found: $file"
    return 1
  fi
  while IFS=: read -r index name path; do
    tmux new-window -t ":$index" -n "$name" -c "$path" 2>/dev/null || \
    tmux rename-window -t ":$index" "$name"
  done < "$file"
  echo "Session layout restored from $file"
}

# Quick pane navigation
function tmux-pane() {
  local pane
  pane=$(tmux list-panes -F "#{pane_index}: #{pane_current_command} - #{pane_current_path}" | \
    fzf --preview="tmux capture-pane -pt {1} | head -20" | cut -d: -f1) &&
  tmux select-pane -t "$pane"
}

# Create new session in specific directory
function tcd() {
  local dir
  dir=$(find ~ -type d -maxdepth 3 2>/dev/null | fzf) &&
  tmux new-session -c "$dir" -s "$(basename "$dir")"
}

# Kill multiple sessions
function tk-fzf() {
  local sessions
  sessions=$(tmux ls | fzf -m | cut -d: -f1) &&
  echo "$sessions" | xargs -n1 tmux kill-session -t
}

# Unset the old tr function if it exists (from cached shell state)
unset -f tr 2>/dev/null || true

# Rename current session
function tmux-rename() {
  local new_name="$1"
  if [[ -z "$new_name" ]]; then
    echo -n "New session name: "
    read new_name
  fi
  tmux rename-session "$new_name"
}

# Send keys to all panes
function tmux-send-all() {
  local cmd="$*"
  tmux list-panes -F '#{pane_id}' | xargs -I {} tmux send-keys -t {} "$cmd" Enter
}

# Quick window switcher
function tw() {
  local window
  window=$(tmux list-windows -F "#{window_index}: #{window_name}" | fzf | cut -d: -f1) &&
  tmux select-window -t "$window"
}

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

# ==================== COMBINED GIT+TMUX FUNCTIONS ====================

# Open git project in tmux
function tgit() {
  local repo
  repo=$(find ~/ltk/repos -name .git -type d 2>/dev/null | sed 's/\.git$//' | fzf) &&
  cd "$repo" &&
  tns "$(basename "$repo")"
}

# Git status in all tmux panes
function tgs() {
  tmux list-panes -F '#{pane_id}:#{pane_current_path}' | while IFS=: read -r pane path; do
    if [[ -d "$path/.git" ]]; then
      echo "=== Pane $pane: $path ==="
      git -C "$path" status -sb
      echo
    fi
  done
}

# Integration

## AWSume
# Unalias awsume if it exists (from previous configs)
unalias awsume 2>/dev/null || true

# Wrapper function to handle awsume's tmux integration issues
awsume() {
    # Temporarily unset TMUX-related env vars if not actually in tmux
    if [[ -z "$TMUX" ]]; then
        # Not in tmux, but awsume might still try tmux commands
        # Suppress tmux-related errors
        source $(pyenv which awsume) "$@" 2> >(grep -v -E "(rename-session|tmux:)" >&2)
    else
        # Actually in tmux, but still filter tmux errors from awsume
        source $(pyenv which awsume) "$@" 2> >(grep -v -E "(rename-session.*unknown flag|tmux:)" >&2)
    fi
}

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

# Auto-start tmux server if not running
if command -v tmux &>/dev/null && [[ -z "$TMUX" ]]; then
  tmux has-session 2>/dev/null || tmux new-session -d -s default 2>/dev/null
fi

# Create tmux config symlink if it doesn't exist
[[ ! -L "$HOME/.tmux.conf" && -f "$HOME/Projects/dotfiles/.tmux.conf" ]] && \
  ln -s "$HOME/Projects/dotfiles/.tmux.conf" "$HOME/.tmux.conf"

export PATH="$HOME/.local/bin:$PATH"
