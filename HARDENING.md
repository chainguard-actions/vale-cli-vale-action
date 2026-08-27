<!-- markdownlint-disable -->

# Hardening Report: vale-cli--vale-action/v1.5.0

> This file was generated automatically by the hardening agent.

**Policy SHA:** `d636be7e43ef829af6e853da6b3c7566db9f72fe`

**Test Policy SHA:** `843adf9e4b8f85d0c08b27b9d0b09dd094b54702`

**Harden Agent Version:** `2`

Action **vale-cli--vale-action/v1.5.0** was hardened automatically. 2 finding(s) were identified and resolved across 1 iteration(s).

## Findings Fixed

### unpinned-uses (severity: high)

The workflow file .github/workflows/main.yml contains three unpinned `uses:` references that use mutable tags or branch names instead of full 40-character commit SHAs:
- `actions/checkout@v1` (tag)
- `actions/checkout@master` (branch)
- `errata-ai/vale-action@v1.3.0` (tag)
These can be silently redirected to different (potentially malicious) code if the referenced tag or branch is moved.

Locations:

- `.github/workflows/main.yml:8`
- `.github/workflows/main.yml:20`
- `.github/workflows/main.yml:23`

### missing-permissions (severity: medium)

The workflow file .github/workflows/main.yml has no top-level `permissions:` key, and neither the `lint` job nor the `release` job defines its own `permissions:` block. Without explicit permissions, the workflow runs with the default (potentially broad) token permissions, violating the principle of least privilege.

Locations:

- `.github/workflows/main.yml:1`

## Iteration Notes

### Iteration 1

**Fixes applied:** unpinned-uses, missing-permissions

**Notes:**

Fixed all three unpinned `uses:` references in .github/workflows/main.yml by pinning them to full 40-character commit SHAs (with original tags preserved as comments). Added a top-level `permissions: {}` block to deny all permissions by default, and added `permissions: contents: read` to both the `lint` and `release` jobs, which is the minimum required for checkout operations.

