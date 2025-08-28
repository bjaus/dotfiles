#!/usr/bin/env zsh

# Markdown navigation and viewing tools

# ==============================================================================
# Table of Contents generator and navigator
# ==============================================================================

# Generate and display a table of contents for a markdown file
function md-toc() {
  local file="${1:-README.md}"
  
  if [[ ! -f "$file" ]]; then
    echo "File not found: $file"
    return 1
  fi
  
  echo "📚 Table of Contents: $file"
  echo "=" | sed "s/./$(&)/g"
  
  # Extract headers and create TOC with line numbers
  grep -n "^#" "$file" | while IFS=: read -r line_num content; do
    # Count the number of # to determine level
    local level=$(echo "$content" | sed 's/[^#].*//g' | wc -c)
    local indent=$((($level - 2) * 2))
    
    # Remove the # and trim
    local title=$(echo "$content" | sed 's/^#* *//')
    
    # Create indent
    local spaces=""
    for ((i=0; i<$indent; i++)); do
      spaces="${spaces} "
    done
    
    # Print with line number
    printf "%s• %s (line %d)\n" "$spaces" "$title" "$line_num"
  done
}

# Interactive markdown TOC navigator using fzf
function md-nav() {
  local file="${1:-README.md}"
  
  if [[ ! -f "$file" ]]; then
    echo "File not found: $file"
    return 1
  fi
  
  # Generate TOC with line numbers and use fzf to select
  local selected=$(grep -n "^#" "$file" | \
    fzf --prompt="Navigate to section: " \
        --preview="sed -n '{1}p' $file | sed 's/^[0-9]*://' | glow -s dark" \
        --preview-window=up:3:wrap)
  
  if [[ -n "$selected" ]]; then
    local line_num=$(echo "$selected" | cut -d: -f1)
    
    # Open in your editor at that line
    if command -v nvim >/dev/null 2>&1; then
      nvim "+$line_num" "$file"
    elif command -v vim >/dev/null 2>&1; then
      vim "+$line_num" "$file"
    else
      # Just display that section
      sed -n "${line_num},/^#/p" "$file" | head -20 | glow -s dark
    fi
  fi
}

# ==============================================================================
# Markdown viewing with different tools
# ==============================================================================

# View markdown with glow (beautiful rendering)
function mdv() {
  local file="${1:-README.md}"
  
  if command -v glow >/dev/null 2>&1; then
    glow -p "$file"  # -p for paging
  elif command -v mdcat >/dev/null 2>&1; then
    mdcat "$file" | less -R
  elif command -v bat >/dev/null 2>&1; then
    bat --language=markdown "$file"
  else
    cat "$file"
  fi
}

# View markdown with mdcat (supports images in some terminals)
function mdc() {
  local file="${1:-README.md}"
  
  if command -v mdcat >/dev/null 2>&1; then
    mdcat --paginate "$file"
  else
    echo "mdcat not installed. Install with: brew install mdcat"
    mdv "$file"
  fi
}

# ==============================================================================
# Find and browse markdown files
# ==============================================================================

# Find all markdown files in current directory tree
function md-find() {
  local pattern="${1:-*}"
  find . -name "*.md" -o -name "*.markdown" | \
    grep -i "$pattern" | \
    fzf --preview="glow -s dark {}" \
        --preview-window=right:70%:wrap \
        --bind="enter:execute(mdv {})"
}

# Browse all markdown files interactively
function md-browse() {
  local selected=$(find . -name "*.md" -o -name "*.markdown" | \
    fzf --preview="glow -s dark {}" \
        --preview-window=right:70%:wrap \
        --prompt="Select markdown file: ")
  
  if [[ -n "$selected" ]]; then
    mdv "$selected"
  fi
}

# ==============================================================================
# Search within markdown files
# ==============================================================================

# Search for text in all markdown files
function md-grep() {
  local query="$1"
  
  if [[ -z "$query" ]]; then
    echo "Usage: md-grep <search-term>"
    return 1
  fi
  
  rg --type=markdown "$query" --color=always | \
    fzf --ansi --preview="echo {} | cut -d: -f1 | xargs glow -s dark" \
        --preview-window=right:70%:wrap
}

# ==============================================================================
# Markdown link checker and navigator
# ==============================================================================

# Extract and navigate links from markdown
function md-links() {
  local file="${1:-README.md}"
  
  if [[ ! -f "$file" ]]; then
    echo "File not found: $file"
    return 1
  fi
  
  # Extract all links [text](url)
  grep -o '\[.*\]([^)]*)' "$file" | \
    sed 's/\[\(.*\)\](\(.*\))/\2 - \1/' | \
    fzf --prompt="Select link: " \
        --preview="echo {} | cut -d' ' -f1 | xargs -I {} sh -c 'if [[ -f {} ]]; then glow -s dark {}; else echo {}; fi'" | \
    cut -d' ' -f1 | \
    xargs -I {} sh -c 'if [[ -f {} ]]; then mdv {}; else open {}; fi'
}

# ==============================================================================
# Convert and export markdown
# ==============================================================================

# Convert markdown to HTML (requires pandoc)
function md-to-html() {
  local input="${1:-README.md}"
  local output="${2:-${input%.md}.html}"
  
  if command -v pandoc >/dev/null 2>&1; then
    pandoc "$input" -o "$output" --standalone --toc
    echo "Converted to: $output"
  else
    echo "pandoc not installed. Install with: brew install pandoc"
  fi
}

# ==============================================================================
# Quick markdown creation
# ==============================================================================

# Create a new markdown file with template
function md-new() {
  local filename="${1:-untitled.md}"
  local title="${2:-Untitled}"
  
  cat > "$filename" <<EOF
# $title

## Table of Contents

- [Introduction](#introduction)
- [Installation](#installation)
- [Usage](#usage)
- [Contributing](#contributing)
- [License](#license)

## Introduction

[Your content here]

## Installation

\`\`\`bash
# Installation instructions
\`\`\`

## Usage

\`\`\`bash
# Usage examples
\`\`\`

## Contributing

[Contribution guidelines]

## License

[License information]

---
Created: $(date)
EOF
  
  echo "Created: $filename"
  mdv "$filename"
}

# ==============================================================================
# Aliases
# ==============================================================================

alias md='mdv'                    # Quick markdown view
alias mdt='md-toc'                # Table of contents
alias mdn='md-nav'                # Navigate with TOC
alias mdf='md-find'               # Find markdown files
alias mdb='md-browse'             # Browse markdown files
alias mdg='md-grep'               # Search in markdown
alias mdl='md-links'              # Extract links
alias mdh='md-to-html'            # Convert to HTML

# ==============================================================================
# Help function
# ==============================================================================

function md-help() {
  cat <<EOF
📚 Markdown Tools Help

Viewing:
  md/mdv [file]      - View markdown with glow (beautiful rendering)
  mdc [file]         - View markdown with mdcat (supports images)
  
Navigation:
  mdt/md-toc [file]  - Show table of contents
  mdn/md-nav [file]  - Interactive TOC navigation (opens in editor)
  
Browsing:
  mdf/md-find        - Find and preview markdown files
  mdb/md-browse      - Browse all markdown files interactively
  
Searching:
  mdg/md-grep <term> - Search within markdown files
  mdl/md-links       - Extract and navigate links
  
Creation:
  md-new <file>      - Create new markdown with template
  mdh/md-to-html     - Convert markdown to HTML
  
Examples:
  mdt README.md      - Show table of contents for README.md
  mdn               - Navigate current README.md interactively
  mdf api           - Find markdown files with 'api' in name
  mdg "TODO"        - Search for "TODO" in all markdown files
  
Tips:
  • Most commands default to README.md if no file specified
  • Use Tab completion with aliases
  • fzf preview windows support vim keybindings
EOF
}

# Silent load - help available via md-help