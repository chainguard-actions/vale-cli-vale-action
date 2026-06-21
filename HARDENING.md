<!-- markdownlint-disable -->

# Hardening Report: vale-cli--vale-action/v2.0.1

> This file was generated automatically by the hardening agent.

**Policy SHA:** `d636be7e43ef829af6e853da6b3c7566db9f72fe`

**Test Policy SHA:** `843adf9e4b8f85d0c08b27b9d0b09dd094b54702`

**Harden Agent Version:** `1`

Action **vale-cli--vale-action/v2.0.1** was hardened automatically. 1 finding(s) were identified and resolved across 1 iteration(s).

## Findings Fixed

### unsafe-shell (severity: high)

The Dockerfile downloads a remote shell script from a mutable branch (`master`) of an external repository and pipes it directly to `sh` without any integrity verification. This allows a compromised or modified upstream script to execute arbitrary code during the Docker image build. Offending line: `RUN wget -O - -q https://raw.githubusercontent.com/reviewdog/reviewdog/master/install.sh| sh -s -- -b bin ${REVIEWDOG_VERSION}`

Locations:

- `Dockerfile:10`

## Iteration Notes

### Iteration 1

**Fixes applied:** unsafe-shell

**Notes:**

Fixed the pipe-to-shell vulnerability in Dockerfile line 10. Changes: (1) Moved ENV REVIEWDOG_VERSION=v0.14.1 before the RUN command that uses it (it was originally defined after, which was also a bug). (2) Replaced `wget -O - -q https://raw.githubusercontent.com/reviewdog/reviewdog/master/install.sh | sh -s -- -b bin ${REVIEWDOG_VERSION}` with a two-step approach: download the script to /tmp/install-reviewdog.sh from a pinned commit SHA (24525080d62b75fd8d589f447e22b0c615713f04, the v0.14.1 tag) instead of the mutable master branch, then execute it separately, then remove it. This eliminates both the pipe-from-internet-to-shell pattern and the mutable branch reference.

