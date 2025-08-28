#!/usr/bin/env zsh

# Simple fix for git worktrees in Docker builds
# This version is more conservative and easier to debug

function worktree-make() {
  echo "🔧 Preparing worktree for Docker build..."
  
  # Check if .git is a file (worktree indicator)
  if [[ -f .git ]]; then
    local gitdir=$(cat .git | sed 's/gitdir: //')
    
    if [[ -d "$gitdir" ]]; then
      echo "📁 Worktree detected: $gitdir"
      
      # Backup .git file
      cp .git .git.worktree.backup
      
      # Get the common dir (main repo's .git)
      local commondir=$(cat "$gitdir/commondir" 2>/dev/null)
      
      if [[ -n "$commondir" && -d "$commondir" ]]; then
        echo "📂 Main repository .git: $commondir"
        
        # Create temporary .git directory
        rm -rf .git
        mkdir -p .git
        
        # Copy essential files
        echo "📋 Copying git configuration..."
        cp -r "$gitdir"/* .git/ 2>/dev/null || true
        
        # Link to main repo's objects (where the actual git data is)
        ln -s "$commondir/objects" .git/objects 2>/dev/null || true
        ln -s "$commondir/info" .git/info 2>/dev/null || true
        ln -s "$commondir/hooks" .git/hooks 2>/dev/null || true
        ln -s "$commondir/refs" .git/refs.main 2>/dev/null || true
        
        # Copy config from main repo
        if [[ -f "$commondir/config" ]]; then
          cp "$commondir/config" .git/config
        fi
        
        echo "✅ Git directory prepared for Docker"
        echo "🚀 Running: make $@"
        
        # Run make with all arguments
        command make "$@"
        local exit_code=$?
        
        # Restore original .git file
        echo "🔄 Restoring original worktree configuration..."
        rm -rf .git
        mv .git.worktree.backup .git
        
        echo "✅ Restored worktree configuration"
        return $exit_code
      else
        echo "❌ Could not find main repository"
        return 1
      fi
    else
      echo "❌ Invalid worktree configuration"
      return 1
    fi
  else
    # Not a worktree, run make normally
    command make "$@"
  fi
}

# Alias for convenience
alias wmake='worktree-make'

echo "💡 Git worktree Docker fix loaded. Use 'wmake' instead of 'make' in worktrees."