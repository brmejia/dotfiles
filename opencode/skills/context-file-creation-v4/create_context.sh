#!/bin/bash
set -euo pipefail

mkdir -p /tmp/opencode-context

CONTEXT_FILE=$(mktemp /tmp/opencode-context/context-XXXXXXXX.md)

echo "$CONTEXT_FILE"
