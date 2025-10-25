#!/usr/bin/env bash
# Install all Go tools from go-tools.txt
# This ensures all tools work with the current Go version

set -e

SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
TOOLS_FILE="$SCRIPT_DIR/../go-tools.txt"

# Get current Go version (e.g., "1.25.1" -> "1.25")
GO_VERSION=$(go version | awk '{print $3}' | sed 's/go//' | cut -d. -f1,2)

echo "🔧 Installing Go tools for Go $GO_VERSION ($(go version))"
echo "================================================"

# Function to get pinned version for a package based on Go version
# Returns empty string if no pin exists
get_pinned_version() {
  local package_name="$1"

  case "$package_name:$GO_VERSION" in
    golangci-lint:1.25)
      echo "v2.5.0"
      ;;
    golangci-lint:1.24|golangci-lint:1.23|golangci-lint:1.22|golangci-lint:1.21)
      echo "v1.64.8"
      ;;
    # Add more pins as needed:
    # some-tool:1.24)
    #   echo "v2.1.0"
    #   ;;
    *)
      echo ""
      ;;
  esac
}

# Function to get path override for a package at a specific version
# Returns empty string if no override exists
get_path_override() {
  local package_name="$1"
  local version="$2"
  local major_version="${version%%.*}"  # Extract v2 from v2.5.0

  case "$package_name:$major_version" in
    golangci-lint:v2)
      echo "github.com/golangci/golangci-lint/v2/cmd/golangci-lint"
      ;;
    *)
      echo ""
      ;;
  esac
}

# Read tools file and install each package
while IFS= read -r line; do
  # Skip comments and empty lines
  [[ "$line" =~ ^#.*$ ]] && continue
  [[ -z "$line" ]] && continue

  # Extract package path (before the comment)
  package=$(echo "$line" | awk '{print $1}')

  if [[ -n "$package" ]]; then
    # Extract package name from path (last component before @)
    package_base="${package%@*}"
    package_name="${package_base##*/}"

    # Check for pinned version
    pinned_version=$(get_pinned_version "$package_name")

    if [[ -n "$pinned_version" ]]; then
      # Check if there's a path override for this version
      path_override=$(get_path_override "$package_name" "$pinned_version")

      if [[ -n "$path_override" ]]; then
        # Use overridden path with pinned version
        install_package="${path_override}@${pinned_version}"
        echo ""
        echo "📌 Installing (pinned for Go $GO_VERSION with v2 path): $install_package"
      else
        # Use original path with pinned version
        install_package="${package_base}@${pinned_version}"
        echo ""
        echo "📌 Installing (pinned for Go $GO_VERSION): $install_package"
      fi
    else
      # Use version from file
      install_package="$package"
      echo ""
      echo "📦 Installing: $install_package"
    fi

    go install "$install_package"
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
