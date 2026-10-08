#!/bin/bash
# Moves the image to the newest catalog release, locks it, and prints GitHub outputs: the catalog
# tag, the image version before and after, and whether the NixOS release changed.
#
# Usage: update-catalog.sh >> "$GITHUB_OUTPUT"
set -euo pipefail

tag=$(gh release view --repo limanix/modules --json tagName --jq .tagName)
before=$(nix eval --raw .#version)
perl -pi -e "s#github:limanix/modules/v[0-9]+#github:limanix/modules/$tag#" flake.nix
nix flake lock
after=$(nix eval --raw .#version)
echo "Catalog $tag: image $before -> $after" >&2

echo "tag=$tag"
echo "before=$before"
echo "after=$after"
if [ "${before%.*}" = "${after%.*}" ]; then
  echo "major=false"
else
  echo "major=true"
fi
