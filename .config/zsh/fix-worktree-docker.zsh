#!/usr/bin/env zsh

# Fix git worktree for Docker builds
# This creates a temporary fix for git worktrees when using Docker

function fix-worktree-docker() {
  # Check if we're in a git worktree
  if ! git rev-parse --git-dir >/dev/null 2>&1; then
    echo "Not in a git repository"
    return 1
  fi
  
  local git_dir=$(git rev-parse --git-dir 2>/dev/null)
  
  # Check if this is a worktree (not main repo)
  if [[ ! -f "$git_dir/../.git" ]]; then
    echo "Not in a worktree"
    return 1
  fi
  
  # Get the main repository path
  local main_repo_git=$(cat "$git_dir/commondir" 2>/dev/null)
  if [[ -z "$main_repo_git" ]]; then
    echo "Could not find main repository"
    return 1
  fi
  
  # Create a temporary .git directory that Docker can use
  echo "Creating Docker-compatible git configuration..."
  
  # Backup existing .git file
  if [[ -f .git ]]; then
    mv .git .git.worktree.bak
  fi
  
  # Copy the git directory structure
  cp -r "$git_dir" .git.tmp
  
  # Copy necessary files from main repo
  local main_git_dir="${main_repo_git}"
  if [[ -d "$main_git_dir" ]]; then
    # Copy essential git files
    cp -r "$main_git_dir/objects" .git.tmp/ 2>/dev/null || true
    cp -r "$main_git_dir/refs" .git.tmp/ 2>/dev/null || true
    cp "$main_git_dir/config" .git.tmp/ 2>/dev/null || true
    cp "$main_git_dir/packed-refs" .git.tmp/ 2>/dev/null || true
  fi
  
  # Move temporary to .git
  rm -rf .git 2>/dev/null || true
  mv .git.tmp .git
  
  echo "✓ Git directory prepared for Docker"
  echo "  Run your Docker/make commands now"
  echo "  Use 'restore-worktree-git' when done"
}

function restore-worktree-git() {
  if [[ -f .git.worktree.bak ]]; then
    echo "Restoring original worktree configuration..."
    rm -rf .git 2>/dev/null || true
    mv .git.worktree.bak .git
    echo "✓ Restored original worktree configuration"
  else
    echo "No backup found to restore"
  fi
}

# Alternative: Create a symlink to the main repo (simpler but may not work in all cases)
function link-worktree-git() {
  if ! git rev-parse --git-dir >/dev/null 2>&1; then
    echo "Not in a git repository"
    return 1
  fi
  
  local git_dir=$(git rev-parse --git-dir 2>/dev/null)
  
  # Check if this is a worktree
  if [[ ! -f "$git_dir/../.git" ]]; then
    echo "Not in a worktree"
    return 1
  fi
  
  # Get the main repository path
  local main_repo_git=$(cat "$git_dir/commondir" 2>/dev/null)
  local main_repo_path=$(dirname "$(dirname "$main_repo_git")")
  
  echo "Main repository: $main_repo_path"
  echo "Creating symlink for Docker compatibility..."
  
  # Create a symlink to the main repo
  ln -sfn "$main_repo_path/.git" .git.main
  
  echo "✓ Created .git.main symlink"
  echo "  You may need to update your Docker mounts to include the main repository"
}

# Export functions
export -f fix-worktree-docker
export -f restore-worktree-git
export -f link-worktree-git

# Aliases for convenience
alias fwd='fix-worktree-docker'
alias rwd='restore-worktree-git'
alias lwd='link-worktree-git'