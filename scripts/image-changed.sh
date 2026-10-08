#!/bin/bash
# Prints the GitHub output changed=true when the commits since BASE touch the image or its build.
#
# Usage: image-changed.sh BASE >> "$GITHUB_OUTPUT"
set -euo pipefail

files='^(flake\.nix|flake\.lock|image\.nix|scripts/build-image\.sh|Taskfile\.yml|\.github/workflows/pr\.yml)$'
if git diff --name-only "$1" HEAD | grep -qE "$files"; then
  echo "changed=true"
else
  echo "The image is unchanged; no build" >&2
  echo "changed=false"
fi
