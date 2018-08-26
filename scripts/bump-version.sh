#!/bin/bash
set -eu

SCRIPT_DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )"
cd $SCRIPT_DIR/..

VERSION=${1}
MAJOR=$(echo "$VERSION" | cut -d. -f1)
MINOR=$(echo "$VERSION" | cut -d. -f2)
PATCH=$(echo "$VERSION" | cut -d. -f3)

case $1 in
major)
    TARGET="$(($MAJOR + 1)).0.0"
    ;;
minor)
    TARGET="$MAJOR.$(($MINOR + 1)).0"
    ;;
patch)
    TARGET="$MAJOR.$MINOR.$(($PATCH + 1))"
    ;;
*)
    if ! echo "$1" | grep -Eq '^(0|[1-9]\d*)\.(0|[1-9]\d*)\.(0|[1-9]\d*)$'; then
        echo "Usage: $0 <version | major | minor | patch>"
        echo "ERROR: Version must be a valid semver in format 'x.y.z'"
        exit 1
    fi

    TARGET="$1"
    ;;
esac

echo "Current version: $VERSION"
echo "Bumping version: $TARGET"

sed -i '' -e "1,/^version/ s/version.*/version = '$TARGET',/" setup.py
git commit -a -m "release: $TARGET" > /dev/null
