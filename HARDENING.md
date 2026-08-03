<!-- markdownlint-disable -->

# Hardening Report: vale-cli--vale-action/v3.0.0

> This file was generated automatically by the hardening agent.

**Policy SHA:** `d636be7e43ef829af6e853da6b3c7566db9f72fe`

**Test Policy SHA:** `843adf9e4b8f85d0c08b27b9d0b09dd094b54702`

**Harden Agent Version:** `2`

Action **vale-cli--vale-action/v3.0.0** was hardened automatically. 2 finding(s) were identified and resolved across 1 iteration(s).

## Findings Fixed

### unpinned-uses (severity: high)

Multiple workflow files reference external actions using mutable version tags instead of full 40-character commit SHA pins. This exposes the workflow to supply-chain attacks if the tag is moved to a malicious commit.

- bundle.yml: `actions/checkout@v4`, `actions/setup-node@v4`
- codeql.yml: `actions/checkout@v3`, `github/codeql-action/init@v2`, `github/codeql-action/autobuild@v2`, `github/codeql-action/analyze@v2`
- main.yml: `actions/checkout@v2`
- major.yml: `actions/checkout@v4`

All should be pinned to a full SHA, e.g. `actions/checkout@11bd71901bbe5b1630ceea73d27597364c9af683 # v4`.

Locations:

- `.github/workflows/bundle.yml:12`
- `.github/workflows/bundle.yml:14`
- `.github/workflows/codeql.yml:22`
- `.github/workflows/codeql.yml:25`
- `.github/workflows/codeql.yml:30`
- `.github/workflows/codeql.yml:33`
- `.github/workflows/main.yml:8`
- `.github/workflows/major.yml:20`

### missing-permissions (severity: medium)

Two workflow files have no top-level `permissions:` key and no job-level `permissions:` key on any of their jobs. Without explicit permissions, GitHub Actions defaults to the repository's default token permissions (often broad `read`/`write` access), violating the principle of least privilege.

- bundle.yml: triggered on `push` and `pull_request` with no permissions declared.
- main.yml: triggered on `push` with no permissions declared.

Add a top-level `permissions: {}` block (or specific minimal scopes) to each file.

Locations:

- `.github/workflows/bundle.yml:1`
- `.github/workflows/main.yml:1`

## Iteration Notes

### Iteration 1

**Fixes applied:** unpinned-uses, missing-permissions

**Notes:**

Fixed all 4 workflow files:

**unpinned-uses** (8 locations):
- bundle.yml: actions/checkout@v4 → @11d5960a326750d5838078e36cf38b85af677262 # v4; actions/setup-node@v4 → @49933ea5288caeca8642d1e84afbd3f7d6820020 # v4
- codeql.yml: actions/checkout@v3 → @a37ce9120846195fa4ece8f58b268e6043cb2f26 # v3; github/codeql-action/init@v2, autobuild@v2, analyze@v2 → all pinned to @b8d3b6e8af63cde30bdc382c0bc28114f4346c88 # v2
- main.yml: actions/checkout@v2 → @0717577d45739eb3c851188b29f50ed6c0b2194e # v2
- major.yml: actions/checkout@v4 → @11d5960a326750d5838078e36cf38b85af677262 # v4

**missing-permissions** (2 locations):
- bundle.yml: added top-level `permissions: {}`
- main.yml: added top-level `permissions: {}`

codeql.yml and major.yml already had explicit job-level permissions so no permissions changes were needed there.

