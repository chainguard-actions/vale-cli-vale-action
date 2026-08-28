<!-- markdownlint-disable -->

# Hardening Report: vale-cli--vale-action/2.1.2

> This file was generated automatically by the hardening agent.

**Policy SHA:** `d636be7e43ef829af6e853da6b3c7566db9f72fe`

**Test Policy SHA:** `843adf9e4b8f85d0c08b27b9d0b09dd094b54702`

**Harden Agent Version:** `2`

Action **vale-cli--vale-action/2.1.2** was hardened automatically. 2 finding(s) were identified and resolved across 1 iteration(s).

## Findings Fixed

### unpinned-uses (severity: high)

Multiple workflow files use action references pinned to mutable tags instead of full 40-character SHA commit hashes, making them vulnerable to supply-chain attacks if the tag is moved.

.github/workflows/codeql.yml:
  - actions/checkout@v3
  - github/codeql-action/init@v2
  - github/codeql-action/autobuild@v2
  - github/codeql-action/analyze@v2

.github/workflows/main.yml:
  - actions/checkout@v2

.github/workflows/major.yml:
  - nowactions/update-majorver@v1

Locations:

- `.github/workflows/codeql.yml:21`
- `.github/workflows/codeql.yml:24`
- `.github/workflows/codeql.yml:29`
- `.github/workflows/codeql.yml:32`
- `.github/workflows/main.yml:8`
- `.github/workflows/major.yml:11`

### missing-permissions (severity: medium)

Workflow files main.yml and major.yml have no top-level `permissions:` key and no job-level `permissions:` key on any of their jobs. Without explicit permissions, the GITHUB_TOKEN is granted default (potentially write) permissions, violating the principle of least privilege.

Locations:

- `.github/workflows/main.yml:1`
- `.github/workflows/major.yml:1`

## Iteration Notes

### Iteration 1

**Fixes applied:** unpinned-uses, missing-permissions

**Notes:**

Fixed all 6 unpinned action references by resolving them to full 40-character commit SHAs: actions/checkout@v3 → a37ce91, actions/checkout@v2 → 0717577, github/codeql-action/*@v2 → b8d3b6e, nowactions/update-majorver@v1 → f2014bb. Added top-level `permissions: {}` to main.yml and major.yml. For major.yml, also added job-level `permissions: contents: write` since the update-majorver action requires write access to update the major version tag.

