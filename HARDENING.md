<!-- markdownlint-disable -->

# Hardening Report: vale-cli--vale-action/2.1.2

> This file was generated automatically by the hardening agent.

**Policy SHA:** `d636be7e43ef829af6e853da6b3c7566db9f72fe`

**Test Policy SHA:** `843adf9e4b8f85d0c08b27b9d0b09dd094b54702`

**Harden Agent Version:** `2`

Action **vale-cli--vale-action/2.1.2** was hardened automatically. 2 finding(s) were identified and resolved across 1 iteration(s).

## Findings Fixed

### unpinned-uses (severity: high)

Multiple workflow files reference GitHub Actions using mutable tags instead of full 40-character SHA commit digests, making them vulnerable to supply-chain attacks if the tag is moved.

.github/workflows/codeql.yml:
  - uses: actions/checkout@v3  (line 25)
  - uses: github/codeql-action/init@v2  (line 28)
  - uses: github/codeql-action/autobuild@v2  (line 33)
  - uses: github/codeql-action/analyze@v2  (line 36)

.github/workflows/main.yml:
  - uses: actions/checkout@v2  (line 8)

.github/workflows/major.yml:
  - uses: nowactions/update-majorver@v1  (line 13)

All of these should be pinned to their full SHA digest, e.g. `actions/checkout@11bd71901bbe5b1630ceea73d27597364c9af683 # v4`.

Locations:

- `.github/workflows/codeql.yml:25`
- `.github/workflows/codeql.yml:28`
- `.github/workflows/codeql.yml:33`
- `.github/workflows/codeql.yml:36`
- `.github/workflows/main.yml:8`
- `.github/workflows/major.yml:13`

### missing-permissions (severity: medium)

Two workflow files have no top-level `permissions:` key and no job-level `permissions:` key on any of their jobs. Without explicit permissions, workflows run with the default repository token permissions, which may be overly broad (e.g. write access to contents).

- .github/workflows/main.yml: the single job `vale` has no permissions block.
- .github/workflows/major.yml: the single job `update-majorver` has no permissions block.

Add a `permissions:` block with the minimum required scopes (e.g. `contents: read`) to each workflow or job.

Locations:

- `.github/workflows/main.yml:1`
- `.github/workflows/major.yml:1`

## Iteration Notes

### Iteration 1

**Fixes applied:** unpinned-uses, missing-permissions

**Notes:**

Fixed all 6 unpinned action references by resolving their full SHA digests: actions/checkout@v3 → a37ce9120846195fa4ece8f58b268e6043cb2f26, github/codeql-action/*@v2 → b8d3b6e8af63cde30bdc382c0bc28114f4346c88, actions/checkout@v2 → 0717577d45739eb3c851188b29f50ed6c0b2194e, nowactions/update-majorver@v1 → f2014bbbba95b635e990ce512c5653bd0f4753fb. Added `permissions: contents: read` to main.yml and `permissions: contents: write` to major.yml (write needed for the update-majorver action to push tag updates). codeql.yml already had a permissions block.

