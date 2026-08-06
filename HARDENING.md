<!-- markdownlint-disable -->

# Hardening Report: vale-cli--vale-action/v2.1.0

> This file was generated automatically by the hardening agent.

**Policy SHA:** `d636be7e43ef829af6e853da6b3c7566db9f72fe`

**Test Policy SHA:** `843adf9e4b8f85d0c08b27b9d0b09dd094b54702`

**Harden Agent Version:** `2`

Action **vale-cli--vale-action/v2.1.0** was hardened automatically. 5 finding(s) were identified and resolved across 1 iteration(s).

## Findings Fixed

### unpinned-uses (severity: high)

Multiple workflow files reference GitHub Actions using mutable tags/version strings instead of pinned full 40-character commit SHAs. This exposes the workflow to supply-chain attacks if the referenced tag is moved or the action is compromised. Failing references: actions/checkout@v3, github/codeql-action/init@v2, github/codeql-action/autobuild@v2, github/codeql-action/analyze@v2.

Locations:

- `.github/workflows/codeql.yml:25`
- `.github/workflows/codeql.yml:28`
- `.github/workflows/codeql.yml:33`
- `.github/workflows/codeql.yml:36`

### unpinned-uses (severity: high)

Workflow references actions/checkout@v2 using a mutable version tag instead of a pinned full 40-character commit SHA. This exposes the workflow to supply-chain attacks.

Locations:

- `.github/workflows/main.yml:9`

### unpinned-uses (severity: high)

Workflow references nowactions/update-majorver@v1 using a mutable version tag instead of a pinned full 40-character commit SHA. This is a third-party action and is especially risky without a pinned SHA.

Locations:

- `.github/workflows/major.yml:11`

### missing-permissions (severity: medium)

Workflow file has no top-level 'permissions:' key and no job-level 'permissions:' key on any job. Without explicit permissions, the GITHUB_TOKEN is granted default (potentially broad) permissions. Explicit minimal permissions should be declared.

Locations:

- `.github/workflows/main.yml:1`

### missing-permissions (severity: medium)

Workflow file has no top-level 'permissions:' key and no job-level 'permissions:' key on any job. Without explicit permissions, the GITHUB_TOKEN is granted default (potentially broad) permissions. Explicit minimal permissions should be declared.

Locations:

- `.github/workflows/major.yml:1`

## Iteration Notes

### Iteration 1

**Fixes applied:** unpinned-uses, missing-permissions

**Notes:**

Fixed all 5 findings across 3 workflow files: (1) codeql.yml: pinned actions/checkout@v3 → SHA a37ce912... and github/codeql-action/{init,autobuild,analyze}@v2 → SHA b8d3b6e8... (2) main.yml: pinned actions/checkout@v2 → SHA 0717577d... and added top-level `permissions: {}`. (3) major.yml: pinned nowactions/update-majorver@v1 → SHA f2014bbb..., added top-level `permissions: {}`, and added job-level `permissions: contents: write` since the action needs to push/update tags.

