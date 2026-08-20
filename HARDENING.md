<!-- markdownlint-disable -->

# Hardening Report: vale-cli--vale-action/v1.5.0

> This file was generated automatically by the hardening agent.

**Policy SHA:** `d636be7e43ef829af6e853da6b3c7566db9f72fe`

**Test Policy SHA:** `843adf9e4b8f85d0c08b27b9d0b09dd094b54702`

**Harden Agent Version:** `2`

Action **vale-cli--vale-action/v1.5.0** was hardened automatically. 2 finding(s) were identified and resolved across 1 iteration(s).

## Findings Fixed

### unpinned-uses (severity: high)

Three `uses:` references in .github/workflows/main.yml are pinned to mutable tags or branch names instead of immutable 40-character commit SHAs, making the workflow vulnerable to supply-chain attacks if the referenced tag or branch is moved:
- `actions/checkout@v1` (tag)
- `actions/checkout@master` (branch)
- `errata-ai/vale-action@v1.3.0` (tag)
Each should be replaced with a full SHA, e.g. `actions/checkout@11bd71901bbe5b1630ceea73d27597364c9af683 # v1`.

Locations:

- `.github/workflows/main.yml:9`
- `.github/workflows/main.yml:21`
- `.github/workflows/main.yml:24`

### missing-permissions (severity: medium)

The workflow file .github/workflows/main.yml has no top-level `permissions:` key, and neither the `lint` job nor the `release` job defines its own `permissions:` block. Without explicit permissions, the workflow runs with the default (potentially broad) token permissions. A minimal `permissions:` block (e.g. `contents: read`) should be added at the top level or per job.

Locations:

- `.github/workflows/main.yml:1`

## Iteration Notes

### Iteration 1

**Fixes applied:** unpinned-uses, missing-permissions

**Notes:**

Fixed .github/workflows/main.yml: (1) Pinned all three mutable `uses:` references to full 40-character commit SHAs — actions/checkout@v1 → @50fbc622fc4ef5163becd7fab6573eac35f8462e, actions/checkout@master → @61b9e3751b92087fd0b06925ba6dd6314e06f089, errata-ai/vale-action@v1.3.0 → @75a4db25a0833de205ab750af4b4ed36e24280ec — with original tag/branch preserved as inline comments. (2) Added a top-level `permissions: contents: read` block to restrict the default GITHUB_TOKEN to the minimum required permissions.

