#!/bin/bash
set -euo pipefail

if [[ $# -lt 1 ]]; then
    echo "Error: CONTEXT_FILE argument required" >&2
    exit 1
fi

rm -f "$1"
echo "Removed: $1"
