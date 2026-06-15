#!/usr/bin/env bash
set -euo pipefail

WORKDIR="${1:-}"

if [ -z "$WORKDIR" ]; then
    echo "ERROR: WORKDIR argument required" >&2
    exit 5
fi

mkdir -p "$WORKDIR"

if ! git rev-parse --git-dir >/dev/null 2>&1; then
    echo "NOT_A_GIT_REPO" > "$WORKDIR/type.txt"
    exit 4
fi

staged_empty=true
unstaged_empty=true

if git diff --staged --quiet 2>/dev/null; then
    staged_empty=true
else
    staged_empty=false
fi

if git diff --quiet 2>/dev/null; then
    unstaged_empty=true
else
    unstaged_empty=false
fi

if [ "$staged_empty" = false ]; then
    echo "STAGED_CHANGES" > "$WORKDIR/type.txt"
    git diff --staged > "$WORKDIR/diff.txt"
    exit 0
elif [ "$unstaged_empty" = false ]; then
    echo "UNSTAGED_CHANGES" > "$WORKDIR/type.txt"
    git diff > "$WORKDIR/diff.txt"
    exit 1
else
    if git rev-parse --verify HEAD >/dev/null 2>&1; then
        echo "LAST_COMMIT" > "$WORKDIR/type.txt"
        git show HEAD > "$WORKDIR/diff.txt"
        exit 2
    else
        echo "NOTHING_TO_REVIEW" > "$WORKDIR/type.txt"
        exit 3
    fi
fi
