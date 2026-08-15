<!-- markdownlint-disable -->

# Hardening Report: vale-cli--vale-action/2.1.2

> This file was generated automatically by the hardening agent.

**Policy SHA:** `d636be7e43ef829af6e853da6b3c7566db9f72fe`

**Test Policy SHA:** `843adf9e4b8f85d0c08b27b9d0b09dd094b54702`

**Harden Agent Version:** `2`

Action **vale-cli--vale-action/2.1.2** was hardened automatically. 3 finding(s) were identified and resolved across 1 iteration(s).

## Findings Fixed

### unpinned-uses (severity: high)

Multiple workflow files reference actions by mutable tag/version refs instead of full 40-character SHA commit digests, making them vulnerable to supply-chain attacks if the tag is moved. Failing references: codeql.yml — actions/checkout@v3, github/codeql-action/init@v2, github/codeql-action/autobuild@v2, github/codeql-action/analyze@v2; main.yml — actions/checkout@v2; major.yml — nowactions/update-majorver@v1.

Locations:

- `.github/workflows/codeql.yml:25`
- `.github/workflows/codeql.yml:28`
- `.github/workflows/codeql.yml:33`
- `.github/workflows/codeql.yml:36`
- `.github/workflows/main.yml:9`
- `.github/workflows/major.yml:13`

### missing-permissions (severity: medium)

main.yml has no top-level 'permissions:' key and its only job ('vale') also has no job-level 'permissions:' key, so the workflow runs with default (broad) repository permissions.

Locations:

- `.github/workflows/main.yml:1`

### missing-permissions (severity: medium)

major.yml has no top-level 'permissions:' key and its only job ('update-majorver') also has no job-level 'permissions:' key, so the workflow runs with default (broad) repository permissions.

Locations:

- `.github/workflows/major.yml:1`

## Iteration Notes

### Iteration 1

**Fixes applied:** unpinned-uses, missing-permissions

**Notes:**

Fixed all findings across three workflow files:

1. codeql.yml: Pinned actions/checkout@v3 → @a37ce9120846195fa4ece8f58b268e6043cb2f26, and all three github/codeql-action/* @v2 references → @b8d3b6e8af63cde30bdc382c0bc28114f4346c88. This file already had job-level permissions so no permissions change was needed.

2. main.yml: Pinned actions/checkout@v2 → @0717577d45739eb3c851188b29f50ed6c0b2194e. Added top-level `permissions: {}` to restrict default broad permissions.

3. major.yml: Pinned nowactions/update-majorver@v1 → @f2014bbbba95b635e990ce512c5653bd0f4753fb. Added top-level `permissions: {}` and job-level `permissions: contents: write` (the minimum needed for the update-majorver action to push tag updates).

