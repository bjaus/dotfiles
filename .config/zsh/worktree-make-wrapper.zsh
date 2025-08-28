#!/usr/bin/env zsh

# Wrapper for make command to handle git worktrees properly

function make() {
  # Check if we're in a git worktree
  local git_dir=$(git rev-parse --git-dir 2>/dev/null)
  
  if [[ -n "$git_dir" ]] && [[ -f "$git_dir/../.git" ]]; then
    # We're in a worktree
    echo "Detected git worktree - preparing for Docker build..."
    
    # Get the main repository path
    local main_repo_git=$(cat "$git_dir/commondir" 2>/dev/null)
    local main_repo_path=$(dirname "$(dirname "$main_repo_git")")
    
    # Set environment variables to help the build
    export GIT_DIR="$git_dir"
    export GIT_WORK_TREE="$(pwd)"
    export GIT_COMMON_DIR="$main_repo_git"
    
    # Check if this is a rewardStyle project with build-utils
    if [[ -f "Makefile" ]] && grep -q "build-utils" Makefile 2>/dev/null; then
      echo "RewardStyle project detected - setting up worktree git config..."
      
      # Create a temporary .git directory if needed
      if [[ ! -d .git ]]; then
        # Backup the .git file
        mv .git .git.worktree.bak 2>/dev/null || true
        
        # Create a minimal .git directory
        mkdir -p .git
        
        # Create the necessary structure
        echo "$main_repo_git" > .git/commondir
        echo "ref: $(git symbolic-ref HEAD 2>/dev/null || git rev-parse HEAD)" > .git/HEAD
        
        # Link to the main repo's objects
        ln -sfn "$main_repo_git/objects" .git/objects 2>/dev/null || true
        ln -sfn "$main_repo_git/refs" .git/refs 2>/dev/null || true
        ln -sfn "$main_repo_git/config" .git/config 2>/dev/null || true
        ln -sfn "$main_repo_git/packed-refs" .git/packed-refs 2>/dev/null || true
        
        # Copy the worktree-specific files
        if [[ -d "$git_dir" ]]; then
          cp -r "$git_dir/index" .git/ 2>/dev/null || true
          cp -r "$git_dir/logs" .git/ 2>/dev/null || true
        fi
        
        # Run make with the original arguments
        command make "$@"
        local exit_code=$?
        
        # Restore the original .git file
        rm -rf .git
        [[ -f .git.worktree.bak ]] && mv .git.worktree.bak .git
        
        return $exit_code
      fi
    fi
  fi
  
  # Not a worktree or not a rewardStyle project, run make normally
  command make "$@"
}

# Export the function
export -f make