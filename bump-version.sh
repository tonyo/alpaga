#!/usr/bin/env bash
set -euxo pipefail

OLD_VERSION="${1:-}"
NEW_VERSION="${2:-}"

echo $NEW_VERSION >> version.txt
