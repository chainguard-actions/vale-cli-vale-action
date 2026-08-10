<!-- markdownlint-disable -->

# Hardening Report: vale-cli--vale-action/2.1.2

> This file was generated automatically by the hardening agent.

**Policy SHA:** `d636be7e43ef829af6e853da6b3c7566db9f72fe`

**Test Policy SHA:** `843adf9e4b8f85d0c08b27b9d0b09dd094b54702`

**Harden Agent Version:** `2`

Action **vale-cli--vale-action/2.1.2** was hardened automatically. 2 finding(s) were identified and resolved across 1 iteration(s).

## Findings Fixed

### unpinned-uses (severity: high)

Multiple workflow files reference GitHub Actions using mutable version tags instead of full 40-character SHA commit hashes. This exposes the workflow to supply-chain attacks if the tag is moved to a malicious commit.

.github/workflows/codeql.yml:
  - uses: actions/checkout@v3 (line 26)
  - uses: github/codeql-action/init@v2 (line 29)
  - uses: github/codeql-action/autobuild@v2 (line 34)
  - uses: github/codeql-action/analyze@v2 (line 37)

.github/workflows/main.yml:
  - uses: actions/checkout@v2 (line 8)

.github/workflows/major.yml:
  - uses: nowactions/update-majorver@v1 (line 11)

All references should be pinned to a full SHA, e.g. actions/checkout@11bd71901bbe5b1630ceea73d27597364c9af683 # v4

Locations:

- `.github/workflows/codeql.yml:26`
- `.github/workflows/codeql.yml:29`
- `.github/workflows/codeql.yml:34`
- `.github/workflows/codeql.yml:37`
- `.github/workflows/main.yml:8`
- `.github/workflows/major.yml:11`

### missing-permissions (severity: medium)

Two workflow files have no top-level `permissions:` block and no job-level `permissions:` block on any of their jobs. Without explicit permissions, GitHub Actions defaults to the repository's default token permissions (often read/write for all scopes), granting more access than necessary.

- .github/workflows/main.yml: no permissions defined at top level or on the 'vale' job.
- .github/workflows/major.yml: no permissions defined at top level or on the 'update-majorver' job.

Add a minimal `permissions:` block (e.g. `contents: read`) at the top level or on each job.

Locations:

- `.github/workflows/main.yml:1`
- `.github/workflows/major.yml:1`

## Iteration Notes

### Iteration 1

**Fixes applied:** unpinned-uses, missing-permissions

**Notes:**

Fixed all 6 unpinned action references by pinning to full SHA hashes with tag comments: actions/checkout@v3 → a37ce9120846195fa4ece8f58b268e6043cb2f26 (codeql.yml), github/codeql-action/init|autobuild|analyze@v2 → b8d3b6e8af63cde30bdc382c0bc28114f4346c88 (codeql.yml), actions/checkout@v2 → 0717577d45739eb3c851188b29f50ed6c0b2194e (main.yml), nowactions/update-majorver@v1 → f2014bbbba95b635e990ce512c5653bd0f4753fb (major.yml). Added top-level permissions blocks: 'contents: read' to main.yml (minimal read-only access for checkout), and 'contents: write' to major.yml (required for update-majorver to push updated major version tags). The codeql.yml already had job-level permissions defined so no changes were needed there.

