#!/usr/bin/env bash
# Create a starter OpenVEX document. VEX records, per vulnerability, whether the
# product is actually 'affected' / 'not_affected' and WHY — the senior-judgment layer.
#
# vexctl's exact flags vary by version; run 'vexctl create --help' to confirm.
# A hand-written, spec-correct example is in docs/example-vex.openvex.json.
set -euo pipefail
ROOT="$(cd "$(dirname "${BASH_SOURCE[0]}")/.." && pwd)"
OUT="$ROOT/outputs"
PRODUCT="pkg:generic/meddevice-sample-app@0.1.0"

if ! command -v vexctl >/dev/null 2>&1; then
  echo "vexctl not installed — see scripts/install_tools.sh."
  echo "Meanwhile, copy docs/example-vex.openvex.json to outputs/ and edit by hand."
  exit 0
fi

# Replace CVE-XXXX-XXXXX with a real ID from outputs/vulns.json before relying on this.
vexctl create \
  --product="$PRODUCT" \
  --vuln="CVE-XXXX-XXXXX" \
  --status="not_affected" \
  --justification="vulnerable_code_not_in_execute_path" \
  --file="$OUT/vex.openvex.json"

echo "Wrote $OUT/vex.openvex.json — edit to reflect the real triage of each finding."
