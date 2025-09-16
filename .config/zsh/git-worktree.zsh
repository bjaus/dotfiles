#!/usr/bin/env zsh

# Git worktree management functions with fzf support
# Provides easy creation and removal of worktrees based on branch names

# Copy essential files to worktree that aren't tracked by git
function _gwt_copy_essentials() {
  local src_dir="$1"
  local dest_dir="$2"
  
  # List of files to copy if they exist
  local files_to_copy=(
    "Taskfile.yml"
    "Taskfile.yaml"
    "local.env"
    ".env"
    ".env.local"
    ".env.development.local"
  )
  
  for file in "${files_to_copy[@]}"; do
    if [[ -f "$src_dir/$file" ]]; then
      cp "$src_dir/$file" "$dest_dir/$file"
      echo "  ✓ Copied $file"
    fi
  done
  
  # Copy .task directory if it exists (for task cache/state)
  if [[ -d "$src_dir/.task" ]]; then
    cp -r "$src_dir/.task" "$dest_dir/.task"
    echo "  ✓ Copied .task directory"
  fi
}

# Initialize submodules in worktree
function _gwt_init_submodules() {
  local worktree_path="$1"
  local current_dir=$(pwd)
  
  # Change to worktree directory
  cd "$worktree_path" || return 1
  
  # Check if .gitmodules exists
  if [[ -f ".gitmodules" ]]; then
    echo "  Initializing submodules..."
    
    # Initialize and update submodules
    if git submodule init 2>/dev/null && git submodule update 2>/dev/null; then
      echo "  ✓ Submodules initialized"
      
      # Special handling for build-utils if it exists
      if [[ -d "build-utils" ]]; then
        echo "  ✓ build-utils submodule ready"
      fi
    else
      echo "  ⚠ Warning: Failed to initialize some submodules"
      echo "    You may need to run: git submodule update --init --recursive"
    fi
  fi
  
  # Return to previous directory
  cd "$current_dir" >/dev/null
}

# Initialize submodules for existing worktree
function gwt-init-submodules() {
  local worktree_path="${1:-$(pwd)}"
  
  # Verify we're in a git worktree
  if ! git rev-parse --git-dir >/dev/null 2>&1; then
    echo "Error: Not in a git repository" >&2
    return 1
  fi
  
  echo "Initializing submodules in: $worktree_path"
  
  # Check if .gitmodules exists
  if [[ ! -f "$worktree_path/.gitmodules" ]]; then
    echo "No .gitmodules file found - this repository doesn't use submodules"
    return 0
  fi
  
  # Initialize and update submodules recursively
  echo "Running: git submodule update --init --recursive"
  if git submodule update --init --recursive; then
    echo "✓ Submodules initialized successfully"
    
    # Check specifically for build-utils
    if [[ -d "$worktree_path/build-utils" ]]; then
      echo "✓ build-utils submodule is ready"
      
      # Verify it has content
      if [[ -z "$(ls -A "$worktree_path/build-utils" 2>/dev/null)" ]]; then
        echo "⚠ Warning: build-utils directory exists but is empty"
        echo "  Try running: git submodule update --force --recursive build-utils"
      fi
    fi
  else
    echo "⚠ Error: Failed to initialize submodules" >&2
    echo "  Try running manually: git submodule update --init --recursive" >&2
    return 1
  fi
}

# Get the default worktree directory (parent of current repo)
function _gwt_dir() {
  local repo_root=$(git rev-parse --show-toplevel 2>/dev/null)
  if [[ -z "$repo_root" ]]; then
    echo "Error: Not in a git repository" >&2
    return 1
  fi
  echo "$(dirname "$repo_root")"
}

# Select a branch using fzf
function _gwt_select_branch() {
  local prompt="${1:-Select branch: }"
  local include_remotes="${2:-yes}"
  
  if ! command -v fzf >/dev/null 2>&1; then
    echo "Error: fzf is not installed. Please install fzf or provide branch name manually." >&2
    return 1
  fi
  
  local branches
  if [[ "$include_remotes" == "yes" ]]; then
    # Include both local and remote branches
    branches=$(git for-each-ref --format='%(refname:short)' refs/heads/ refs/remotes/ | 
               sed 's|^origin/||' | 
               sort -u)
  else
    # Local branches only
    branches=$(git for-each-ref --format='%(refname:short)' refs/heads/)
  fi
  
  echo "$branches" | fzf --prompt="$prompt" --height=20 --reverse --exit-0
}

# Select a worktree using fzf
function _gwt_select_worktree() {
  local prompt="${1:-Select worktree: }"
  
  if ! command -v fzf >/dev/null 2>&1; then
    echo "Error: fzf is not installed. Please install fzf or provide worktree name manually." >&2
    return 1
  fi
  
  git worktree list | fzf --prompt="$prompt" --height=20 --reverse --exit-0 | cut -d' ' -f1
}

# Add a worktree based on branch name
function gwt-add() {
  local branch="$1"
  
  # If no branch provided, use fzf to select
  if [[ -z "$branch" ]]; then
    branch=$(_gwt_select_branch "Select branch to create worktree for: ")
    [[ -z "$branch" ]] && return 1
  fi
  
  local current_branch=$(git branch --show-current)
  
  # If trying to create worktree for current branch, switch to main first
  if [[ "$branch" == "$current_branch" ]]; then
    echo "Branch '$branch' is currently checked out. Switching to main branch first..."
    
    # Find the main branch (could be main or master)
    local main_branch
    if git show-ref --verify --quiet refs/heads/main; then
      main_branch="main"
    elif git show-ref --verify --quiet refs/heads/master; then
      main_branch="master"
    else
      echo "Error: Could not find main or master branch to switch to" >&2
      echo "Please manually checkout a different branch first" >&2
      return 1
    fi
    
    # Checkout main branch
    if ! git checkout "$main_branch" 2>/dev/null; then
      echo "Error: Failed to checkout $main_branch branch" >&2
      echo "You may have uncommitted changes. Please commit or stash them first." >&2
      return 1
    fi
    echo "✓ Switched to $main_branch branch"
  fi
  
  local parent_dir=$(_gwt_dir) || return 1
  local worktree_path="$parent_dir/$branch"
  
  # Check if worktree already exists
  if git worktree list | grep -q "$worktree_path"; then
    echo "Worktree already exists at: $worktree_path" >&2
    echo "Use 'gwt-rm $branch' to remove it first, or 'cd $worktree_path' to go there" >&2
    return 1
  fi
  
  # Check if directory exists but isn't a worktree
  if [[ -d "$worktree_path" ]]; then
    echo "Directory already exists at: $worktree_path" >&2
    echo "Remove it first or choose a different branch name" >&2
    return 1
  fi
  
  # Create the worktree
  echo "Creating worktree for branch '$branch' at: $worktree_path"
  if git worktree add "$worktree_path" "$branch" 2>/dev/null; then
    echo "✓ Worktree created successfully"
    
    # Copy essential files
    local repo_root=$(git rev-parse --show-toplevel 2>/dev/null)
    _gwt_copy_essentials "$repo_root" "$worktree_path"
    
    # Initialize submodules
    _gwt_init_submodules "$worktree_path"
    
    echo "  cd $worktree_path"
  else
    # Branch might not exist locally, try creating from remote
    echo "Branch '$branch' not found locally, trying to create from remote..."
    if git worktree add "$worktree_path" -b "$branch" "origin/$branch" 2>/dev/null; then
      echo "✓ Worktree created from origin/$branch"
      
      # Copy essential files
      local repo_root=$(git rev-parse --show-toplevel 2>/dev/null)
      _gwt_copy_essentials "$repo_root" "$worktree_path"
      
      # Initialize submodules
      _gwt_init_submodules "$worktree_path"
      
      echo "  cd $worktree_path"
    else
      # Try without remote tracking
      echo "Creating new branch '$branch'..."
      if git worktree add "$worktree_path" -b "$branch"; then
        echo "✓ Worktree created with new branch"
        
        # Copy essential files
        local repo_root=$(git rev-parse --show-toplevel 2>/dev/null)
        _gwt_copy_essentials "$repo_root" "$worktree_path"
        
        # Initialize submodules
        _gwt_init_submodules "$worktree_path"
        
        echo "  cd $worktree_path"
      else
        echo "Error: Failed to create worktree" >&2
        return 1
      fi
    fi
  fi
}

# Remove a worktree
function gwt-rm() {
  local branch="$1"
  
  # If no branch provided, use fzf to select from worktrees
  if [[ -z "$branch" ]]; then
    local worktree_path=$(_gwt_select_worktree "Select worktree to remove: ")
    [[ -z "$worktree_path" ]] && return 1
    branch=${worktree_path##*/}
  fi
  
  local parent_dir=$(_gwt_dir) || return 1
  local worktree_path="$parent_dir/$branch"
  
  # Check if argument is a full path
  if [[ "$branch" == /* ]]; then
    worktree_path="$branch"
  fi
  
  # Check if worktree exists
  if ! git worktree list | grep -q "$worktree_path"; then
    echo "Worktree not found: $worktree_path" >&2
    echo "Available worktrees:"
    git worktree list | while read -r line; do
      echo "  $line"
    done
    return 1
  fi
  
  echo "Removing worktree at: $worktree_path"
  if git worktree remove "$worktree_path" --force 2>/dev/null || git worktree remove "$worktree_path"; then
    echo "✓ Worktree removed successfully"
  else
    echo "Error: Failed to remove worktree" >&2
    echo "You may need to manually clean up: rm -rf $worktree_path" >&2
    return 1
  fi
}

# List all worktrees
function gwt-ls() {
  git worktree list | while read -r path rest; do
    local basename=${path##*/}
    
    # Highlight current worktree
    if [[ "$path" == "$(pwd)" ]] || [[ "$path" == "$(git rev-parse --show-toplevel 2>/dev/null)" ]]; then
      echo "→ $basename: $rest"
    else
      echo "  $basename: $rest"
    fi
  done
}

# Switch to a worktree (with fuzzy finding)
function gwt-cd() {
  local branch="$1"
  
  if [[ -z "$branch" ]]; then
    # Use fzf to select
    local selected=$(_gwt_select_worktree "Select worktree to switch to: ")
    if [[ -n "$selected" ]]; then
      cd "$selected"
      return
    fi
    return 1
  fi
  
  local parent_dir=$(_gwt_dir) || return 1
  local worktree_path="$parent_dir/$branch"
  
  if [[ -d "$worktree_path" ]]; then
    cd "$worktree_path"
  else
    echo "Worktree not found: $worktree_path" >&2
    echo "Available worktrees:"
    gwt-ls
    return 1
  fi
}

# Clean up worktrees for deleted branches
function gwt-clean() {
  echo "Cleaning up worktrees for deleted branches..."
  
  # Process each worktree
  local first_line=true
  local main_worktree=""
  
  git worktree list | while IFS=' ' read -r path sha rest; do
    # First line is the main worktree, save it and skip
    if [[ "$first_line" == "true" ]]; then
      main_worktree="$path"
      first_line=false
      continue
    fi
    
    # Extract branch name from rest of line
    # The format is typically: [branch-name] or (detached HEAD)
    local branch=""
    
    # Use parameter expansion to extract text between brackets
    if [[ "$rest" == *"["*"]"* ]]; then
      # Remove everything before [
      local temp="${rest#*[}"
      # Remove everything after ]
      branch="${temp%%]*}"
    fi
    
    # Check if branch still exists
    if [[ -n "$branch" ]] && ! git show-ref --verify --quiet "refs/heads/$branch"; then
      echo "Branch '$branch' no longer exists, removing worktree at: $path"
      git worktree remove "$path" --force 2>/dev/null || git worktree remove "$path"
    fi
  done
  
  # Prune worktree administrative files
  git worktree prune
  echo "✓ Cleanup complete"
}

# Quick worktree add and cd
function gwt-new() {
  local branch="$1"
  
  # If no branch provided, prompt for new branch name
  if [[ -z "$branch" ]]; then
    echo -n "Enter new branch name: "
    read branch
    [[ -z "$branch" ]] && return 1
  fi
  
  if gwt-add "$branch"; then
    local parent_dir=$(_gwt_dir)
    cd "$parent_dir/$branch"
    echo "→ Switched to new worktree"
  fi
}

# Create a new branch based on a worktree branch (or any branch)
function gwt-branch() {
  local base_branch="$1"
  local new_branch="$2"
  
  # If no base branch provided, use fzf to select
  if [[ -z "$base_branch" ]]; then
    base_branch=$(_gwt_select_branch "Select base branch: ")
    [[ -z "$base_branch" ]] && return 1
  fi
  
  # If no new branch name provided, prompt for it
  if [[ -z "$new_branch" ]]; then
    echo -n "Enter new branch name (based on $base_branch): "
    read new_branch
    [[ -z "$new_branch" ]] && return 1
  fi
  
  # Create new branch from base branch without checking it out
  if git branch "$new_branch" "$base_branch" 2>/dev/null; then
    echo "✓ Created branch '$new_branch' based on '$base_branch'"
    echo ""
    echo "You can now:"
    echo "  1. Checkout: git checkout $new_branch"
    echo "  2. Create worktree: gwt-add $new_branch"
    echo "  3. Switch and create worktree: gwt-new $new_branch"
  else
    # Try with origin/ prefix if local branch doesn't exist
    if git branch "$new_branch" "origin/$base_branch" 2>/dev/null; then
      echo "✓ Created branch '$new_branch' based on 'origin/$base_branch'"
      echo ""
      echo "You can now:"
      echo "  1. Checkout: git checkout $new_branch"
      echo "  2. Create worktree: gwt-add $new_branch"
      echo "  3. Switch and create worktree: gwt-new $new_branch"
    else
      echo "Error: Failed to create branch. Base branch '$base_branch' not found." >&2
      echo "Available branches:" >&2
      git branch -a | head -20
      return 1
    fi
  fi
}

# Aliases for convenience
alias gwta='gwt-add'
alias gwtr='gwt-rm'
alias gwtl='gwt-ls'
alias gwtc='gwt-cd'
alias gwtn='gwt-new'
alias gwtb='gwt-branch'
alias gwtclean='gwt-clean'

# Show help
function gwt-help() {
  cat <<EOF
Git Worktree Management Commands (with fzf support):

  gwt-add [branch]         Add worktree (fzf selection if no branch given)
  gwt-rm [branch]          Remove worktree (fzf selection if no branch given)
  gwt-ls                   List all worktrees  
  gwt-cd [branch]          Change to worktree (fzf selection if no branch given)
  gwt-new [branch]         Create worktree and cd (prompts if no branch given)
  gwt-branch [base] [new]  Create branch from base (fzf for base if not given)
  gwt-clean                Remove worktrees for deleted branches
  gwt-init-submodules      Initialize submodules in current worktree
  
Aliases:
  gwta  = gwt-add       wt = show this help
  gwtr  = gwt-rm
  gwtl  = gwt-ls
  gwtc  = gwt-cd
  gwtn  = gwt-new
  gwtb  = gwt-branch
  
Notes:
  - Taskfile.yml is automatically copied to new worktrees
  - Submodules (including build-utils) are automatically initialized
  - Use gwt-init-submodules to fix existing worktrees without submodules

Examples:
  gwt-add                        # Select branch with fzf
  gwt-add feature-123            # Create worktree for specific branch
  gwt-rm                         # Select worktree to remove with fzf
  gwt-cd                         # Select worktree to switch to
  gwt-branch                     # Select base branch with fzf, then prompt for name
  gwt-branch COA-2598 COA-2599   # Create COA-2599 from COA-2598
  
Note: All commands support fzf selection when branch/worktree not specified
EOF
}

# Use 'wt' as the main command to avoid conflict with 'g' alias (git)
alias wt='gwt-help'
alias gwt='gwt-help'  # Keep for compatibility