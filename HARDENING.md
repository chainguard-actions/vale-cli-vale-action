<!-- markdownlint-disable -->

# Hardening Report: vale-cli--vale-action/2.1.2

> This file was generated automatically by the hardening agent.

**Policy SHA:** `d636be7e43ef829af6e853da6b3c7566db9f72fe`

**Test Policy SHA:** `843adf9e4b8f85d0c08b27b9d0b09dd094b54702`

**Harden Agent Version:** `2`

Action **vale-cli--vale-action/2.1.2** was hardened automatically. 3 finding(s) were identified and resolved across 1 iteration(s).

## Findings Fixed

### unpinned-uses (severity: high)

Multiple workflow files reference GitHub Actions using mutable tags instead of full 40-character SHA commit digests, making them vulnerable to supply-chain attacks if the tag is moved.

.github/workflows/codeql.yml:
  - uses: actions/checkout@v3
  - uses: github/codeql-action/init@v2
  - uses: github/codeql-action/autobuild@v2
  - uses: github/codeql-action/analyze@v2

.github/workflows/main.yml:
  - uses: actions/checkout@v2

.github/workflows/major.yml:
  - uses: nowactions/update-majorver@v1

Locations:

- `.github/workflows/codeql.yml:24`
- `.github/workflows/codeql.yml:27`
- `.github/workflows/codeql.yml:32`
- `.github/workflows/codeql.yml:35`
- `.github/workflows/main.yml:8`
- `.github/workflows/major.yml:12`

### missing-permissions (severity: medium)

main.yml has no top-level 'permissions:' key and its only job ('vale') also has no job-level 'permissions:' key. Without explicit permissions, the workflow inherits the default repository token permissions, which may be overly broad.

Locations:

- `.github/workflows/main.yml:1`

### missing-permissions (severity: medium)

major.yml has no top-level 'permissions:' key and its only job ('update-majorver') also has no job-level 'permissions:' key. Without explicit permissions, the workflow inherits the default repository token permissions, which may be overly broad.

Locations:

- `.github/workflows/major.yml:1`

## Iteration Notes

### Iteration 1

**Fixes applied:** unpinned-uses, missing-permissions

**Notes:**

Fixed all 6 unpinned action references by pinning to full SHA digests: actions/checkout@v3 → a37ce9120846195fa4ece8f58b268e6043cb2f26, actions/checkout@v2 → 0717577d45739eb3c851188b29f50ed6c0b2194e, github/codeql-action/{init,autobuild,analyze}@v2 → b8d3b6e8af63cde30bdc382c0bc28114f4346c88, nowactions/update-majorver@v1 → f2014bbbba95b635e990ce512c5653bd0f4753fb. Added `permissions: {}` top-level block to main.yml (no special permissions needed). Added `permissions: {}` top-level block to major.yml with `contents: write` at the job level (needed by update-majorver to push tag updates). codeql.yml already had explicit job-level permissions so no permissions changes were needed there.

