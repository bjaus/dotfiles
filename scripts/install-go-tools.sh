#!/usr/bin/env bash
# Install all Go tools from go-tools.txt
# This ensures all tools work with the current Go version

set -e

SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
TOOLS_FILE="$SCRIPT_DIR/../go-tools.txt"

echo "🔧 Installing Go tools for $(go version)"
echo "================================================"

# Read tools file and install each package
while IFS= read -r line; do
  # Skip comments and empty lines
  [[ "$line" =~ ^#.*$ ]] && continue
  [[ -z "$line" ]] && continue

  # Extract package path (before the comment)
  package=$(echo "$line" | awk '{print $1}')

  if [[ -n "$package" ]]; then
    echo ""
    echo "📦 Installing: $package"
    go install "$package"
  fi
done < "$TOOLS_FILE"

echo ""
echo "================================================"
echo "✅ All Go tools installed successfully!"
echo ""
echo "Installed to: $(go env GOPATH)/bin"
echo ""
echo "Tools installed:"
ls -lh "$(go env GOPATH)/bin" | awk 'NR>1 {printf "  - %-30s %10s\n", $9, $5}'
