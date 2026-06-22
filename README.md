# FDA-Ready SBOM & Cybersecurity Documentation — Demo

**The problem this solves:** since 2023, the FDA can refuse to even *accept* a premarket
submission for a "cyber device" that lacks adequate cybersecurity documentation (Section 524B
of the FD&C Act). A refuse-to-accept on cybersecurity paperwork can cost months. The current
submission template (eSTAR) gates on it structurally — there's no hand-waving past it.

This repo shows, end to end, how a codebase becomes the cybersecurity artifacts a submission
needs — generated, scanned, **triaged**, and mapped to the statute.

## What it produces

```
source code
   │  syft
   ▼
CycloneDX / SPDX SBOM      → §524B(b)(3): machine-readable bill of materials
   │  grype
   ▼
vulnerability findings     → §524B(b)(1): basis for the monitoring/response plan
   │  vexctl (OpenVEX)
   ▼
VEX triage (affected /     → §524B(b)(1)/(2): which findings actually matter, and why
   not_affected / fixed)
   +
CI workflow (every push)   → §524B(b)(2): SBOM automated in CI/CD (SPDF maturity)
```

## Run it (inside WSL2 / Ubuntu)

```bash
bash scripts/install_tools.sh     # one-time: Syft, Grype, vexctl
bash scripts/run_all.sh           # SBOM -> scan -> VEX starter
```
Artifacts land in `outputs/`. The §524B mapping is in `docs/security-summary.md`.

## Repo map

| Path | What it is |
|---|---|
| `sample-app/` | Tiny app with **intentionally** outdated deps, so findings are real |
| `scripts/` | `install_tools` · `generate_sbom` · `scan_vulns` · `make_vex` · `run_all` |
| `docs/security-summary.md` | Buyer-facing artifact → maps each output to §524B(b)(1)/(2)/(3) |
| `docs/example-vex.openvex.json` | Spec-correct OpenVEX showing the triage layer |
| `.github/workflows/sbom.yml` | CI: regenerate the SBOM on every push |
| `outputs/` | Generated artifacts (gitignored; regenerate any time) |

## The point

Syft and Grype are commodity — anyone can run a scanner. The defensible work is the **VEX
triage and the submission-grade documentation**: deciding which of 40 findings are actually
exploitable, justifying each in language an FDA reviewer accepts, and wiring the whole thing
into CI so it stays current. That judgment is the deliverable.

---
*Demonstration on sample code only. Contains no client or device data.*
