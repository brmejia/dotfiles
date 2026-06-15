#!/usr/bin/env bash
set -euo pipefail

WORKDIR="${1:-}"

if [ -z "$WORKDIR" ]; then
    echo "ERROR: WORKDIR argument required" >&2
    exit 1
fi

if [ ! -f "$WORKDIR/diff.txt" ]; then
    echo "ERROR: $WORKDIR/diff.txt not found. Run detect-changes.sh first." >&2
    exit 1
fi

if ! git rev-parse --git-dir >/dev/null 2>&1; then
    echo "ERROR: Not a git repository" >&2
    exit 1
fi

diff_content=$(cat "$WORKDIR/diff.txt")

if [ -z "$diff_content" ]; then
    echo "ERROR: diff.txt is empty — nothing to review." >&2
    exit 1
fi

commit_log=$(git log --oneline -10 2>/dev/null || echo "(no commits)")
modified_files=$(git status --porcelain 2>/dev/null || echo "(unknown)")

context_file="$WORKDIR/context.md"

cat > "$context_file" <<EOF
# Code Review Context

## Diff

\`\`\`diff
$diff_content
\`\`\`

## Modified Files

\`\`\`
$modified_files
\`\`\`

## Commit Log (last 10)

\`\`\`
$commit_log
\`\`\`
EOF

echo "$context_file"
