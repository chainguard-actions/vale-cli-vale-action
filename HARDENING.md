<!-- markdownlint-disable -->

# Hardening Report: vale-cli--vale-action/v2.0.0

> This file was generated automatically by the hardening agent.

**Policy SHA:** `d636be7e43ef829af6e853da6b3c7566db9f72fe`

**Test Policy SHA:** `843adf9e4b8f85d0c08b27b9d0b09dd094b54702`

**Harden Agent Version:** `2`

Action **vale-cli--vale-action/v2.0.0** was hardened automatically. 2 finding(s) were identified and resolved across 1 iteration(s).

## Findings Fixed

### unpinned-uses (severity: high)

Workflow files reference actions using mutable tag refs instead of immutable 40-character SHA digests, making the workflow vulnerable to supply-chain attacks if the tag is moved. Failing references:
- `.github/workflows/main.yml` line 9: `uses: actions/checkout@v2` (tag `v2`)
- `.github/workflows/major.yml` line 13: `uses: nowactions/update-majorver@v1` (tag `v1`)
These should be pinned to full commit SHAs, e.g. `actions/checkout@11bd71901bbe5b1630ceea73d27597364c9af683 # v2`.

Locations:

- `.github/workflows/main.yml:9`
- `.github/workflows/major.yml:13`

### missing-permissions (severity: medium)

Neither workflow file defines a top-level `permissions:` block, and no job within them defines job-level `permissions:` either. Without explicit permissions, GitHub Actions defaults to broad repository permissions (historically `write-all` for older repos), violating the principle of least privilege. Both files should declare minimal required permissions (e.g. `permissions: contents: read`).

Locations:

- `.github/workflows/main.yml:1`
- `.github/workflows/major.yml:1`

## Iteration Notes

### Iteration 1

**Fixes applied:** unpinned-uses, missing-permissions

**Notes:**

Fixed both workflow files:
1. `.github/workflows/main.yml`: Pinned `actions/checkout@v2` to `actions/checkout@0717577d45739eb3c851188b29f50ed6c0b2194e # v2` and added `permissions: contents: read` at the top level.
2. `.github/workflows/major.yml`: Pinned `nowactions/update-majorver@v1` to `nowactions/update-majorver@f2014bbbba95b635e990ce512c5653bd0f4753fb # v1` and added `permissions: contents: write` at the top level (write is required because this workflow updates major version tags).

