#!/bin/bash
set -euo pipefail

if [[ $# -lt 1 ]]; then
    echo "Error: CONTEXT_FILE argument required" >&2
    exit 1
fi

CONTEXT_FILE="$1"

if [[ $# -ge 2 && "$2" == "-" ]]; then
    cat > "$CONTEXT_FILE"
elif [[ $# -ge 2 ]]; then
    echo "$2" > "$CONTEXT_FILE"
else
    cat > "$CONTEXT_FILE"
fi

echo "Content written to: $CONTEXT_FILE"
