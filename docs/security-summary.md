# Security Documentation Summary — sample-app

*Illustrative deliverable. Maps the generated artifacts to the statutory cybersecurity
obligations for "cyber devices" under Section 524B(b) of the FD&C Act. Replace sample
content with the real device's data in an engagement.*

## Artifacts in this package

| Artifact | Tool | §524B(b) obligation it supports |
|---|---|---|
| `outputs/sbom.cdx.json` (CycloneDX) / `sbom.spdx.json` (SPDX) | Syft | **(b)(3)** — provide a machine-readable SBOM incl. commercial, open-source, and off-the-shelf components |
| `outputs/vulns.json` + table | Grype | **(b)(1)** — basis for the plan to monitor, identify, and address postmarket vulnerabilities |
| `outputs/vex.openvex.json` (see `docs/example-vex.openvex.json`) | vexctl / OpenVEX | **(b)(1)/(b)(2)** — triaged exploitability + remediation posture; evidence of a maintained secure process |
| `.github/workflows/sbom.yml` | GitHub Actions + Anchore | **(b)(2)** — SBOM regeneration automated in CI/CD, showing a maintained Secure Product Development Framework (SPDF) |

## Why the VEX is the value, not the scan

Syft and Grype are commodity tools — anyone can run them. The defensible work is the **VEX
triage**: deciding, per finding, whether the product is actually `affected`, `not_affected`
(with an OpenVEX justification), `fixed`, or `under_investigation`, and documenting *why* in
language an FDA reviewer accepts. A raw scan with 40 unexplained CVEs invites deficiency
letters; a scan plus a reasoned VEX is a submission posture.

## Notes for a real engagement
- Confirm CVE IDs and statuses against the actual `outputs/vulns.json`; the IDs in the example
  VEX are illustrative (one real PyYAML CVE plus two placeholders).
- The premarket vulnerability-management plan should name monitoring sources (e.g., NVD,
  ICS-CERT), define critical-vs-non-critical response timelines, and describe CVD procedures
  and patch delivery — see the FDA cybersecurity reference doc.
- Security risk management is a process distinct from ISO 14971 safety risk management
  (ANSI/AAMI SW96:2023; IEC 81001-5-1:2021).
