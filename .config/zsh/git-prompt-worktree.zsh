# Enhanced git prompt with worktree support

# Function to get git repository name
git_repo_name() {
    local repo_path
    repo_path=$(git rev-parse --show-toplevel 2>/dev/null)
    if [[ -n $repo_path ]]; then
        echo "${repo_path:t}"  # Get basename
    fi
}

# Function to check if we're in a worktree
git_is_worktree() {
    local git_dir common_dir
    git_dir=$(git rev-parse --git-dir 2>/dev/null)
    [[ -n $git_dir ]] || return 1
    
    # Check if .git is a file (worktree) or directory (main repo)
    if [[ -f "$git_dir/../.git" ]]; then
        return 0  # In a worktree
    elif [[ -f "$git_dir/commondir" ]]; then
        return 0  # In a worktree (newer git versions)
    else
        return 1  # In main repo
    fi
}

# Enhanced git prompt info function
git_prompt_info_enhanced() {
    local ref repo_name worktree_indicator dirty_status
    
    # Get standard git info
    ref=$(git symbolic-ref HEAD 2>/dev/null) || ref=$(git rev-parse --short HEAD 2>/dev/null) || return 0
    
    # Get repo name
    repo_name=$(git_repo_name)
    
    # Check if in worktree
    if git_is_worktree; then
        worktree_indicator="⚡"  # Lightning bolt for worktree
    else
        worktree_indicator=""
    fi
    
    # Get dirty status if function exists
    if type parse_git_dirty &>/dev/null; then
        dirty_status=$(parse_git_dirty)
    else
        dirty_status=""
    fi
    
    # Format: [repo-name:branch⚡]
    if [[ -n $repo_name ]]; then
        echo "$ZSH_THEME_GIT_PROMPT_PREFIX${repo_name}:${ref#refs/heads/}${worktree_indicator}${dirty_status}$ZSH_THEME_GIT_PROMPT_SUFFIX"
    else
        echo "$ZSH_THEME_GIT_PROMPT_PREFIX${ref#refs/heads/}${worktree_indicator}${dirty_status}$ZSH_THEME_GIT_PROMPT_SUFFIX"
    fi
}

# Override the default git_prompt_info if it exists
if type git_prompt_info &>/dev/null; then
    # Backup original function
    eval "git_prompt_info_original() { $(declare -f git_prompt_info | tail -n +2) }"
fi

# Replace with our enhanced version
git_prompt_info() {
    git_prompt_info_enhanced
}