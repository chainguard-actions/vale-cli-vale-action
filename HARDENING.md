<!-- markdownlint-disable -->

# Hardening Report: vale-cli--vale-action/2.1.2

> This file was generated automatically by the hardening agent.

**Policy SHA:** `d636be7e43ef829af6e853da6b3c7566db9f72fe`

**Test Policy SHA:** `843adf9e4b8f85d0c08b27b9d0b09dd094b54702`

**Harden Agent Version:** `2`

Action **vale-cli--vale-action/2.1.2** was hardened automatically. 2 finding(s) were identified and resolved across 1 iteration(s).

## Findings Fixed

### unpinned-uses (severity: high)

Multiple `uses:` references in workflow files are pinned to mutable tags instead of immutable 40-character SHA digests, making the action vulnerable to supply-chain attacks if the upstream tag is moved or overwritten.

Failing references:
- `.github/workflows/codeql.yml`: `actions/checkout@v3`, `github/codeql-action/init@v2`, `github/codeql-action/autobuild@v2`, `github/codeql-action/analyze@v2`
- `.github/workflows/main.yml`: `actions/checkout@v2`
- `.github/workflows/major.yml`: `nowactions/update-majorver@v1`

Locations:

- `.github/workflows/codeql.yml:22`
- `.github/workflows/codeql.yml:25`
- `.github/workflows/codeql.yml:30`
- `.github/workflows/codeql.yml:33`
- `.github/workflows/main.yml:8`
- `.github/workflows/major.yml:10`

### missing-permissions (severity: medium)

Workflow files `main.yml` and `major.yml` have no top-level `permissions:` key and no job-level `permissions:` key on any of their jobs. Without explicit permissions, jobs inherit the default repository token permissions (which may be `write-all` depending on repository settings), granting unnecessary access.

Locations:

- `.github/workflows/main.yml:1`
- `.github/workflows/major.yml:1`

## Iteration Notes

### Iteration 1

**Fixes applied:** unpinned-uses, missing-permissions

**Notes:**

Fixed all 6 unpinned action references by resolving them to full 40-character commit SHAs: actions/checkout@v3 → a37ce91..., actions/checkout@v2 → 0717577..., github/codeql-action/init@v2 → b8d3b6e..., github/codeql-action/autobuild@v2 → b8d3b6e..., github/codeql-action/analyze@v2 → b8d3b6e..., nowactions/update-majorver@v1 → f2014bb.... Added top-level permissions blocks to main.yml (contents: read) and major.yml (contents: write, required for the tag-updating action). codeql.yml already had explicit job-level permissions so no change was needed there.

