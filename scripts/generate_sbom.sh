#!/usr/bin/env bash
# Generate a machine-readable SBOM (CycloneDX + SPDX) from the target source.
set -euo pipefail
ROOT="$(cd "$(dirname "${BASH_SOURCE[0]}")/.." && pwd)"
TARGET="${1:-$ROOT/sample-app}"
OUT="$ROOT/outputs"
mkdir -p "$OUT"

echo "Generating SBOM from: $TARGET"
syft "dir:$TARGET" -o cyclonedx-json="$OUT/sbom.cdx.json"
syft "dir:$TARGET" -o spdx-json="$OUT/sbom.spdx.json"
echo "Wrote:"
echo "  $OUT/sbom.cdx.json   (CycloneDX — primary, FDA-accepted format)"
echo "  $OUT/sbom.spdx.json  (SPDX — alternate FDA-accepted format)"
