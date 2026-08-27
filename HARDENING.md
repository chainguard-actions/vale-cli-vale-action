<!-- markdownlint-disable -->

# Hardening Report: vale-cli--vale-action/2.1.2

> This file was generated automatically by the hardening agent.

**Policy SHA:** `d636be7e43ef829af6e853da6b3c7566db9f72fe`

**Test Policy SHA:** `843adf9e4b8f85d0c08b27b9d0b09dd094b54702`

**Harden Agent Version:** `2`

Action **vale-cli--vale-action/2.1.2** was hardened automatically. 2 finding(s) were identified and resolved across 1 iteration(s).

## Findings Fixed

### unpinned-uses (severity: high)

Multiple workflow files reference external actions using mutable tags/versions instead of pinned full-length SHA commit hashes. This exposes the workflow to supply-chain attacks if the referenced tag is moved or the repository is compromised.

Failing references:
- main.yml: `uses: actions/checkout@v2` (line 9)
- codeql.yml: `uses: actions/checkout@v3` (line 17), `uses: github/codeql-action/init@v2` (line 20), `uses: github/codeql-action/autobuild@v2` (line 25), `uses: github/codeql-action/analyze@v2` (line 28)
- major.yml: `uses: nowactions/update-majorver@v1` (line 13)

Locations:

- `.github/workflows/main.yml:9`
- `.github/workflows/codeql.yml:17`
- `.github/workflows/codeql.yml:20`
- `.github/workflows/codeql.yml:25`
- `.github/workflows/codeql.yml:28`
- `.github/workflows/major.yml:13`

### missing-permissions (severity: medium)

Two workflow files have no top-level `permissions:` block and no job-level `permissions:` block on any of their jobs. Without explicit permissions, GitHub Actions defaults to broad repository permissions, violating the principle of least privilege.

- main.yml: no permissions declared at top-level or job level.
- major.yml: no permissions declared at top-level or job level.

Locations:

- `.github/workflows/main.yml:1`
- `.github/workflows/major.yml:1`

## Iteration Notes

### Iteration 1

**Fixes applied:** unpinned-uses, missing-permissions

**Notes:**

Fixed all 6 unpinned action references by pinning to full commit SHAs: actions/checkout@v2 → 0717577d..., actions/checkout@v3 → a37ce912..., github/codeql-action/init@v2 → b8d3b6e8..., github/codeql-action/autobuild@v2 → b8d3b6e8..., github/codeql-action/analyze@v2 → b8d3b6e8..., nowactions/update-majorver@v1 → f2014bbb.... Added top-level `permissions: {}` to main.yml and major.yml. For major.yml, also added job-level `permissions: contents: write` since the update-majorver action requires write access to push/update tags. codeql.yml already had explicit job-level permissions and was not flagged for missing-permissions.

