#!/usr/bin/env bash
# SBOM-driven vulnerability scan (scan the SBOM, not the directory — the mature pattern:
# the SBOM is the single source of truth, and the same SBOM is scanned again over time).
set -euo pipefail
ROOT="$(cd "$(dirname "${BASH_SOURCE[0]}")/.." && pwd)"
OUT="$ROOT/outputs"
SBOM="$OUT/sbom.cdx.json"
[ -f "$SBOM" ] || { echo "SBOM not found. Run scripts/generate_sbom.sh first."; exit 1; }

echo "Scanning SBOM for vulnerabilities: $SBOM"
grype "sbom:$SBOM" -o table                       # human-readable to terminal
grype "sbom:$SBOM" -o json="$OUT/vulns.json"       # machine-readable for the record
echo "Wrote $OUT/vulns.json"
echo
echo "NEXT: triage these findings in a VEX document (scripts/make_vex.sh)."
echo "      A finding in the SBOM is NOT the same as an exploitable risk — that judgment is the deliverable."
