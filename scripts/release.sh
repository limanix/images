#!/bin/bash
# Prepares the release of the images in dist/ and prints it as GitHub outputs: the dated tag, and
# the tag of the NixOS release with copies of the images in alias/ under names without the date.
# Prints nothing when that version is released already.
#
# Usage: release.sh >> "$GITHUB_OUTPUT"
set -euo pipefail

file=$(echo dist/limanix-*-aarch64.qcow2)
version=${file#dist/limanix-}
version=${version%-aarch64.qcow2}
if git rev-parse -q --verify "refs/tags/v$version" > /dev/null; then
  echo "v$version is released already" >&2
  exit 0
fi

release=${version%.*}
mkdir -p alias
for arch in aarch64 x86_64; do
  name="limanix-$release-$arch.qcow2"
  cp "dist/limanix-$version-$arch.qcow2" "alias/$name"
  (cd alias && sha256sum "$name" > "$name.sha256")
done

echo "tag=v$version"
echo "alias=v$release"
