#!/usr/bin/env bash
# Bootstrap entry point for a new macOS machine.
# Run this first — it installs Xcode CLI tools, then delegates to osx_post_install.sh.
#
# References used when building this dotfiles repo:
#   https://github.com/mathiasbynens/dotfiles
#   https://github.com/sidaf/dotfiles
#   https://github.com/necolas/dotfiles
#   https://github.com/mas-cli/mas

set -euo pipefail

DOTFILES_DIR="$(cd "$(dirname "$0")" && pwd)"

# Step 1: Xcode Command Line Tools (required before git, brew, etc.)
if ! xcode-select -p &>/dev/null; then
    echo "==> Installing Xcode Command Line Tools..."
    xcode-select --install
    echo "    Re-run this script after the installation dialog completes."
    exit 0
fi

# Accept the Xcode license silently (required after CLT install)
sudo xcodebuild -license accept 2>/dev/null || true

# Step 2: Run full post-install configuration
exec "$DOTFILES_DIR/osx_fixes/osx_post_install.sh"
