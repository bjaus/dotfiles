# Enhanced vcs_info prompt with worktree support for zhann theme

# Function to check if we're in a worktree
git_is_worktree() {
    local git_dir
    git_dir=$(git rev-parse --git-dir 2>/dev/null)
    [[ -n $git_dir ]] || return 1
    
    # Check if .git is a file (worktree) or directory (main repo)
    if [[ -f "$git_dir/../.git" ]] || [[ -f "$git_dir/commondir" ]]; then
        return 0  # In a worktree
    else
        return 1  # In main repo
    fi
}

# Override theme_precmd to add worktree info
theme_precmd_enhanced() {
  local repo_name worktree_indicator
  
  # Get repository name
  local repo_path=$(git rev-parse --show-toplevel 2>/dev/null)
  if [[ -n $repo_path ]]; then
    repo_name="${repo_path:t}:"
  else
    repo_name=""
  fi
  
  # Check if in worktree
  if git_is_worktree; then
    worktree_indicator="⚡"
  else
    worktree_indicator=""
  fi
  
  # Original theme_precmd logic with modifications
  if [[ -z $(git ls-files --other --exclude-standard 2> /dev/null) ]]; then
    zstyle ':vcs_info:git:*' formats " [${repo_name}%b%c%u${worktree_indicator}%B%F{green}]"
  else
    zstyle ':vcs_info:git:*' formats " [${repo_name}%b%c%u${worktree_indicator}%B%F{red}●%F{green}]"
  fi
  
  vcs_info
}

# Replace the theme_precmd with our enhanced version
if type theme_precmd &>/dev/null 2>&1; then
    # Override the existing theme_precmd
    theme_precmd() {
        theme_precmd_enhanced
    }
fi