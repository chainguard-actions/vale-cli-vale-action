<!-- markdownlint-disable -->

# Hardening Report: vale-cli--vale-action/v2.0.1

> This file was generated automatically by the hardening agent.

**Policy SHA:** `d636be7e43ef829af6e853da6b3c7566db9f72fe`

**Test Policy SHA:** `843adf9e4b8f85d0c08b27b9d0b09dd094b54702`

**Harden Agent Version:** `2`

Action **vale-cli--vale-action/v2.0.1** was hardened automatically. 3 finding(s) were identified and resolved across 1 iteration(s).

## Findings Fixed

### unpinned-uses (severity: high)

Both workflow files reference actions by mutable version tags instead of full 40-character commit SHAs. In main.yml: `uses: actions/checkout@v2`. In major.yml: `uses: nowactions/update-majorver@v1`. These tags can be moved to point at different (potentially malicious) commits without notice, enabling supply-chain attacks.

Locations:

- `.github/workflows/main.yml:9`
- `.github/workflows/major.yml:11`

### unsafe-shell (severity: high)

Dockerfile line 10 fetches a remote shell script from the `master` branch of reviewdog and pipes it directly to `sh`: `wget -O - -q https://raw.githubusercontent.com/reviewdog/reviewdog/master/install.sh | sh -s -- -b bin ${REVIEWDOG_VERSION}`. This is unsafe because (a) the script is fetched from a mutable branch ref (`master`) rather than a pinned commit or verified release, and (b) the content is executed immediately without any integrity check, allowing a compromised upstream to execute arbitrary code in the build environment.

Locations:

- `Dockerfile:10`

### permissions (severity: medium)

Neither workflow file defines a `permissions:` block at the top level or at the job level. Without explicit permissions, GitHub Actions defaults to the repository's default token permissions (which may be `write-all` for older repositories), granting jobs broader access than necessary. Both main.yml and major.yml are affected.

Locations:

- `.github/workflows/main.yml:1`
- `.github/workflows/major.yml:1`

## Iteration Notes

### Iteration 1

**Fixes applied:** unpinned-uses, permissions, unsafe-shell

**Notes:**

1. unpinned-uses: Pinned `actions/checkout@v2` to `@ee0669bd1cc54295c223e0bb666b733df41de1c5 # v2` in main.yml, and `nowactions/update-majorver@v1` to `@f2014bbbba95b635e990ce512c5653bd0f4753fb # v1` in major.yml.
2. permissions: Added `permissions: {}` at the workflow level in both main.yml and major.yml, with minimal job-level permissions: `checks: write` + `contents: read` for the vale job (needed for github-check reporter), and `contents: write` for the update-majorver job (needed to push the major version tag).
3. unsafe-shell: Replaced the `wget ... | sh` pipe-from-master pattern in Dockerfile with a direct download of the reviewdog release tarball from a pinned version tag (`v0.14.1`). Also pinned the `jdkato/vale:v2.15.5` base image to its sha256 digest.

