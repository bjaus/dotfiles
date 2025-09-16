#!/usr/bin/env zsh

# Terminal clipboard utilities

# Copy output of a command without ANSI escape codes
function copy-clean() {
  if [[ $# -eq 0 ]]; then
    # If no arguments, read from stdin and strip ANSI codes
    sed 's/\x1b\[[0-9;]*m//g' | pbcopy
  else
    # Run command and copy its output without ANSI codes
    "$@" 2>&1 | sed 's/\x1b\[[0-9;]*m//g' | pbcopy
  fi
  echo "Copied clean text to clipboard"
}

# Copy the last command's output without colors
function copy-last() {
  # Get the last command from history and run it, stripping ANSI codes
  local last_cmd=$(fc -ln -1)
  eval "$last_cmd" 2>&1 | sed 's/\x1b\[[0-9;]*m//g' | pbcopy
  echo "Copied output of '$last_cmd' (clean) to clipboard"
}

# Show clipboard contents without formatting
function show-clipboard() {
  pbpaste | cat -v
}

# Copy current directory path
function copy-pwd() {
  pwd | pbcopy
  echo "Copied current path to clipboard: $(pwd)"
}

# Copy git branch name
function copy-branch() {
  if git rev-parse --git-dir >/dev/null 2>&1; then
    git branch --show-current | pbcopy
    echo "Copied branch name to clipboard: $(git branch --show-current)"
  else
    echo "Not in a git repository"
  fi
}

# Strip ANSI codes from clipboard content
function clean-clipboard() {
  pbpaste | sed 's/\x1b\[[0-9;]*m//g' | pbcopy
  echo "Cleaned clipboard content (removed formatting)"
}

# Aliases
alias cc='copy-clean'
alias cl='copy-last' 
alias sc='show-clipboard'
alias cpwd='copy-pwd'
alias cbr='copy-branch'
alias cclean='clean-clipboard'

# Help function
function clipboard-help() {
  cat <<EOF
📋 Clipboard Tools

Commands:
  copy-clean [cmd]   Copy command output without colors/formatting
  copy-last          Copy last command's output (clean)
  copy-pwd          Copy current directory path
  copy-branch       Copy current git branch name
  clean-clipboard   Strip formatting from clipboard content
  show-clipboard    Show clipboard with visible control characters

Aliases:
  cc                = copy-clean
  cl                = copy-last
  cpwd              = copy-pwd  
  cbr               = copy-branch
  cclean            = clean-clipboard
  sc                = show-clipboard

Examples:
  ls --color=always | cc        # Copy ls output without colors
  git status | cc               # Copy git status without colors
  cl                           # Copy last command output (clean)
  cclean                       # Fix clipboard if it has formatting issues
EOF
}

alias ch='clipboard-help'