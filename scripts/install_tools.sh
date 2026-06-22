#!/usr/bin/env bash
# One-time install of the security toolchain (run inside WSL2 / Ubuntu).
# Confirm the current install commands on each project's GitHub releases page.
set -euo pipefail

echo "Installing Syft (SBOM generation)..."
curl -sSfL https://raw.githubusercontent.com/anchore/syft/main/install.sh  | sh -s -- -b /usr/local/bin

echo "Installing Grype (vulnerability scanning)..."
curl -sSfL https://raw.githubusercontent.com/anchore/grype/main/install.sh | sh -s -- -b /usr/local/bin

echo "Installing vexctl (OpenVEX) ..."
# vexctl ships as a Go tool / prebuilt binary. If you have Go:
#   go install github.com/openvex/vexctl@latest
# Otherwise download the binary for your platform from:
#   https://github.com/openvex/vexctl/releases
echo "  -> If 'vexctl' is not found after this, grab the binary from the releases page above."

echo
echo "Versions:"
syft version || true
grype version || true
vexctl version 2>/dev/null || echo "vexctl: install manually (see note above)"
