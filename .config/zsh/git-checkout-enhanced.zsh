#!/usr/bin/env zsh

# Enhanced git checkout that intelligently handles worktrees
# If in main repo with no worktrees: regular checkout
# If worktrees exist: switch to worktree or create one if needed

function git-checkout() {
  local branch="$1"
  
  # If no branch provided, use fzf to select
  if [[ -z "$branch" ]]; then
    # Include both local and remote branches
    branch=$(git for-each-ref --format='%(refname:short)' refs/heads/ refs/remotes/ | 
             sed 's|^origin/||' | 
             sort -u | 
             fzf --prompt="Select branch: " --height=20 --reverse --exit-0)
    [[ -z "$branch" ]] && return 1
  fi
  
  # Check if we're in a git repository
  if ! git rev-parse --git-dir >/dev/null 2>&1; then
    echo "Error: Not in a git repository" >&2
    return 1
  fi
  
  # Get the main repository root (not worktree)
  local git_common_dir=$(git rev-parse --git-common-dir 2>/dev/null)
  local is_worktree=false
  
  # Check if we're in a worktree (git-common-dir differs from git-dir)
  if [[ "$(git rev-parse --git-dir)" != "$git_common_dir" ]]; then
    is_worktree=true
  fi
  
  # Check if any worktrees exist
  local worktree_count=$(git worktree list | wc -l)
  
  if [[ $worktree_count -eq 1 ]] && [[ "$is_worktree" == "false" ]]; then
    # No worktrees exist, just do regular checkout
    echo "→ Checking out branch '$branch' in main repository"
    git checkout "$branch"
  else
    # Worktrees exist, check if target branch has a worktree
    local worktree_path=""
    local parent_dir=""
    
    if [[ "$is_worktree" == "true" ]]; then
      # We're in a worktree, get parent directory from current path
      local current_worktree=$(git rev-parse --show-toplevel)
      parent_dir=$(dirname "$current_worktree")
    else
      # We're in main repo, get parent directory
      local repo_root=$(git rev-parse --show-toplevel)
      parent_dir=$(dirname "$repo_root")
    fi
    
    worktree_path="$parent_dir/$branch"
    
    # Check if worktree exists for this branch
    if git worktree list | grep -q "$worktree_path"; then
      # Worktree exists, switch to it
      echo "→ Switching to worktree for branch '$branch'"
      cd "$worktree_path"
      
      # Ensure we're on the right branch (in case worktree got out of sync)
      local current_branch=$(git branch --show-current)
      if [[ "$current_branch" != "$branch" ]]; then
        echo "  Worktree was on '$current_branch', checking out '$branch'"
        git checkout "$branch"
      fi
    elif [[ "$is_worktree" == "true" ]]; then
      # We're in a worktree but target branch doesn't have one
      # Check if branch exists
      if git show-ref --verify --quiet "refs/heads/$branch" || git show-ref --verify --quiet "refs/remotes/origin/$branch"; then
        # Branch exists, ask user what to do
        echo "Branch '$branch' exists but has no worktree."
        echo "Options:"
        echo "  1) Create worktree for '$branch'"
        echo "  2) Switch to main repo and checkout there"
        echo -n "Choose [1/2]: "
        read choice
        
        case "$choice" in
          1)
            echo "Creating worktree for branch '$branch'..."
            # Get the main repo path
            local main_repo=$(git worktree list | head -1 | cut -d' ' -f1)
            cd "$main_repo"
            
            # Check if we need to switch branches first
            local main_branch=$(git branch --show-current)
            if [[ "$main_branch" == "$branch" ]]; then
              # Need to switch to different branch first
              if git show-ref --verify --quiet refs/heads/main; then
                git checkout main
              elif git show-ref --verify --quiet refs/heads/master; then
                git checkout master
              else
                echo "Error: Cannot create worktree for currently checked out branch" >&2
                return 1
              fi
            fi
            
            # Now create the worktree
            if gwt-add "$branch"; then
              cd "$worktree_path"
            fi
            ;;
          2)
            # Switch to main repo
            local main_repo=$(git worktree list | head -1 | cut -d' ' -f1)
            cd "$main_repo"
            git checkout "$branch"
            ;;
          *)
            echo "Invalid choice"
            return 1
            ;;
        esac
      else
        # Branch doesn't exist, create it in current worktree
        echo "Creating new branch '$branch' in current worktree"
        git checkout -b "$branch"
      fi
    else
      # We're in the main repo and target branch doesn't have a worktree
      # Just do regular checkout
      echo "→ Checking out branch '$branch' in main repository"
      git checkout "$branch"
    fi
  fi
}

# Wrapper for git checkout -b to handle worktrees
function git-checkout-new() {
  local branch="$1"
  local base_branch="${2:-HEAD}"
  
  if [[ -z "$branch" ]]; then
    echo -n "Enter new branch name: "
    read branch
    [[ -z "$branch" ]] && return 1
  fi
  
  # Check if we're in a git repository
  if ! git rev-parse --git-dir >/dev/null 2>&1; then
    echo "Error: Not in a git repository" >&2
    return 1
  fi
  
  # Check if any worktrees exist
  local worktree_count=$(git worktree list | wc -l)
  
  if [[ $worktree_count -eq 1 ]]; then
    # No worktrees, create branch normally
    echo "→ Creating new branch '$branch' from '$base_branch'"
    git checkout -b "$branch" "$base_branch"
  else
    # Worktrees exist, ask what to do
    echo "Worktrees detected. How would you like to create branch '$branch'?"
    echo "  1) Create new worktree for this branch"
    echo "  2) Create branch in current location"
    echo -n "Choose [1/2]: "
    read choice
    
    case "$choice" in
      1)
        # Create branch and worktree
        if git branch "$branch" "$base_branch" 2>/dev/null; then
          echo "✓ Created branch '$branch' from '$base_branch'"
          gwt-add "$branch"
          
          local parent_dir
          local repo_root=$(git rev-parse --show-toplevel)
          parent_dir=$(dirname "$repo_root")
          cd "$parent_dir/$branch"
        else
          echo "Error: Failed to create branch" >&2
          return 1
        fi
        ;;
      2)
        # Create branch in current location
        git checkout -b "$branch" "$base_branch"
        ;;
      *)
        echo "Invalid choice"
        return 1
        ;;
    esac
  fi
}

# Override the gco alias to use our enhanced function
alias gco='git-checkout'
alias gcob='git-checkout-new'

# Keep original git checkout available
alias gco-orig='git checkout'