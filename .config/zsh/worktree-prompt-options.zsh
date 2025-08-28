#!/usr/bin/env zsh

# Options for showing repository info in worktrees
# Choose ONE of these options by uncommenting it

# ============================================
# OPTION 1: Show in terminal title/tab
# ============================================
# This is enabled by default in worktree-info.zsh
# Shows as: "⚡ consumer-profile-service:COA-2551-swagger"

# ============================================
# OPTION 2: Show in right prompt
# ============================================
# This is also enabled by default in worktree-info.zsh
# Shows as: [consumer-profile-service:COA-2551-swagger⚡]

# ============================================
# OPTION 3: Modify left prompt (prepend to existing)
# ============================================
# Uncomment these lines to add repo info to the beginning of your prompt
# function prepend_repo_to_prompt() {
#   local repo_info=$(wt)
#   if [[ -n $repo_info ]] && [[ $repo_info != "[not a git repo]" ]]; then
#     PS1="${repo_info} ${PS1}"
#   fi
# }
# add-zsh-hook precmd prepend_repo_to_prompt

# ============================================
# OPTION 4: Replace directory in prompt with repo:branch
# ============================================
# This replaces the directory name with repo:branch in worktrees
# function prompt_with_repo() {
#   local repo=$(repo-name)
#   local branch=$(git branch --show-current 2>/dev/null)
#   
#   if [[ -n $repo ]]; then
#     local git_dir=$(git rev-parse --git-dir 2>/dev/null)
#     if [[ -f "$git_dir/../.git" ]] || [[ -f "$git_dir/commondir" ]]; then
#       # In worktree - show repo:branch instead of directory
#       PROMPT=$(echo $PROMPT | sed "s/%c/${repo}:${branch}⚡/g")
#       PROMPT=$(echo $PROMPT | sed "s/%~/${repo}:${branch}⚡/g")
#     fi
#   fi
# }
# add-zsh-hook precmd prompt_with_repo

# ============================================
# OPTION 5: Show in tmux status bar
# ============================================
# Add this to your tmux.conf:
# set -g status-left "#(cd #{pane_current_path} && zsh -c 'source ~/.config/zsh/worktree-info.zsh && wt')"

# ============================================
# OPTION 6: Minimal - just change terminal title to repo name
# ============================================
# function simple_terminal_title() {
#   local repo=$(repo-name)
#   if [[ -n $repo ]]; then
#     echo -ne "\033]0;$repo\007"
#   fi
# }
# add-zsh-hook chpwd simple_terminal_title
# add-zsh-hook precmd simple_terminal_title