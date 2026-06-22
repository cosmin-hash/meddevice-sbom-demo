#!/usr/bin/env bash
# End-to-end: SBOM -> scan -> VEX starter. Run from anywhere.
set -euo pipefail
DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
bash "$DIR/generate_sbom.sh" "$@"
bash "$DIR/scan_vulns.sh"
bash "$DIR/make_vex.sh"
echo
echo "Done. Artifacts in ./outputs. See docs/security-summary.md for the 524B mapping."
