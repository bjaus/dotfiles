#!/usr/bin/env zsh

# Helper functions to identify repository when in a worktree

# Get the repository name from a worktree
function repo-name() {
  local repo_path=$(git rev-parse --show-toplevel 2>/dev/null)
  if [[ -n $repo_path ]]; then
    # If we're in a worktree, get the main repo path
    local git_dir=$(git rev-parse --git-dir 2>/dev/null)
    if [[ -f "$git_dir/../.git" ]] || [[ -f "$git_dir/commondir" ]]; then
      # In a worktree, get the main repo path
      local common_dir=$(cat "$git_dir/commondir" 2>/dev/null)
      if [[ -n $common_dir ]]; then
        local main_repo=$(dirname $(dirname "$common_dir"))
        echo "${main_repo:t}"
      else
        echo "${repo_path:t}"
      fi
    else
      # In main repo
      echo "${repo_path:t}"
    fi
  fi
}

# Show detailed worktree information
function wt-info() {
  if ! git rev-parse --git-dir >/dev/null 2>&1; then
    echo "❌ Not in a git repository"
    return 1
  fi
  
  local repo=$(repo-name)
  local branch=$(git branch --show-current 2>/dev/null)
  local worktree_path=$(pwd)
  local git_dir=$(git rev-parse --git-dir 2>/dev/null)
  
  echo "📦 Repository:    ${repo}"
  echo "🌿 Branch:        ${branch}"
  echo "📁 Worktree:      ${worktree_path}"
  
  # Check if in worktree
  if [[ -f "$git_dir/../.git" ]] || [[ -f "$git_dir/commondir" ]]; then
    echo "⚡ Type:          Worktree"
    local common_dir=$(cat "$git_dir/commondir" 2>/dev/null)
    if [[ -n $common_dir ]]; then
      local main_repo=$(dirname $(dirname "$common_dir"))
      echo "🏠 Main repo:     ${main_repo}"
    fi
  else
    echo "🏠 Type:          Main repository"
  fi
  
  # Show git status summary
  local changes=$(git status --porcelain 2>/dev/null | wc -l | tr -d ' ')
  if [[ $changes -gt 0 ]]; then
    echo "✏️  Changes:       ${changes} file(s) modified"
  else
    echo "✅ Status:        Clean"
  fi
}

# Short version for command line
function wt() {
  local repo=$(repo-name)
  local branch=$(git branch --show-current 2>/dev/null)
  
  if [[ -n $repo ]]; then
    # Check if in worktree
    local git_dir=$(git rev-parse --git-dir 2>/dev/null)
    if [[ -f "$git_dir/../.git" ]] || [[ -f "$git_dir/commondir" ]]; then
      echo "[$repo:$branch⚡]"  # Lightning for worktree
    else
      echo "[$repo:$branch]"
    fi
  else
    echo "[not a git repo]"
  fi
}

# Add to prompt - THIS IS NOW ENABLED BY DEFAULT
# This adds the repository info to your right prompt
RPROMPT='$(wt) '$RPROMPT

# Alternative: Update the terminal title
function update_terminal_title() {
  local repo=$(repo-name)
  local branch=$(git branch --show-current 2>/dev/null)
  
  if [[ -n $repo ]]; then
    # Check if in worktree
    local git_dir=$(git rev-parse --git-dir 2>/dev/null)
    if [[ -f "$git_dir/../.git" ]] || [[ -f "$git_dir/commondir" ]]; then
      echo -ne "\033]0;⚡ $repo:$branch\007"
    else
      echo -ne "\033]0;$repo:$branch\007"
    fi
  fi
}

# Auto-update terminal title on directory change - ENABLED BY DEFAULT
autoload -U add-zsh-hook
add-zsh-hook chpwd update_terminal_title
add-zsh-hook precmd update_terminal_title

# Create a custom cd that shows repo info
function cd() {
  builtin cd "$@"
  local repo=$(repo-name)
  if [[ -n $repo ]] && [[ "$repo" != "$LAST_REPO" ]]; then
    export LAST_REPO="$repo"
    local branch=$(git branch --show-current 2>/dev/null)
    local git_dir=$(git rev-parse --git-dir 2>/dev/null)
    if [[ -f "$git_dir/../.git" ]] || [[ -f "$git_dir/commondir" ]]; then
      echo "📦 Entered worktree: $repo:$branch"
    fi
  fi
}

# Aliases
alias repo='repo-name'
alias wti='wt-info'

echo "💡 Worktree info tools loaded. Commands:"
echo "   wt       - Show [repo:branch] quickly"
echo "   wt-info  - Show detailed repository information"
echo "   repo     - Show just the repository name"