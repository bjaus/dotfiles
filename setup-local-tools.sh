#!/bin/bash
# Setup script for machine-specific tools and completions
# This should be run on machines that have specific tools installed

echo "Setting up machine-specific configurations..."

# Create completions directory
mkdir -p ~/.zsh/completions

# ktl completion (only if ktl is installed)
if command -v ktl &>/dev/null; then
  echo "Setting up ktl completion..."
  cat > ~/.zsh/completions/_ktl << 'EOF'
#compdef ktl

_ktl() {
  local -a opts
  local cur
  cur=${words[-1]}

  # Call ktl's built-in completion generator
  if [[ "$cur" == -* ]]; then
    # Flags completion
    opts=($(ktl --generate-bash-completion))
  else
    # Subcommand completion
    opts=($(ktl --generate-bash-completion))
  fi

  _describe 'ktl' opts
}

# Alternative method that works better with urfave/cli
_ktl_complete() {
  local completions
  completions="$(ktl --generate-bash-completion)"
  if [[ -n "$completions" ]]; then
    reply=(${(f)completions})
  fi
}

compctl -K _ktl_complete ktl

# Register the completion function
_ktl "$@"
EOF
  echo "✅ ktl completion installed"
else
  echo "⏭️  ktl not found, skipping completion setup"
fi

# Add more tool-specific setups here as needed
# Example:
# if command -v other-tool &>/dev/null; then
#   echo "Setting up other-tool..."
#   # Setup commands
# fi

echo ""
echo "Machine-specific setup complete!"
echo "Reload your shell with: source ~/.zshrc"