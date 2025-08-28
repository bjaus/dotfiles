#!/usr/bin/env zsh

# Safeguard for deleted directories - auto-navigate to home if current directory doesn't exist

# Check if current directory exists on shell startup and cd commands
function check_directory() {
  if [[ ! -d "$PWD" ]]; then
    echo "⚠️  Current directory no longer exists: $PWD"
    echo "🏠 Navigating to home directory..."
    cd ~ 2>/dev/null || cd / 2>/dev/null
    return 1
  fi
  return 0
}

# Check on shell startup
check_directory

# Hook into directory changes
autoload -U add-zsh-hook

# Before prompt, check if we're still in a valid directory
function precmd_check_directory() {
  if [[ ! -d "$PWD" ]]; then
    echo "⚠️  Directory was deleted: $PWD"
    cd ~ 2>/dev/null || cd / 2>/dev/null
  fi
}

add-zsh-hook precmd precmd_check_directory

# Override cd to check directory validity
function cd() {
  builtin cd "$@"
  local result=$?
  
  if [[ $result -ne 0 ]]; then
    # cd failed, check if current directory still exists
    if [[ ! -d "$PWD" ]]; then
      echo "⚠️  Current directory no longer exists"
      builtin cd ~ 2>/dev/null || builtin cd / 2>/dev/null
    fi
  fi
  
  return $result
}

# Function to clean up broken worktrees
function clean-broken-worktrees() {
  echo "🔍 Checking for broken worktrees..."
  
  git worktree list 2>/dev/null | while read -r line; do
    local worktree_path=$(echo "$line" | awk '{print $1}')
    if [[ ! -d "$worktree_path" ]]; then
      echo "❌ Found broken worktree: $worktree_path"
      echo "   Removing from git worktree list..."
      git worktree remove "$worktree_path" --force 2>/dev/null || git worktree prune 2>/dev/null
    fi
  done
  
  echo "✅ Cleanup complete"
}

# Alias for convenience
alias cbd='clean-broken-worktrees'