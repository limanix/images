#!/bin/sh
# Builds the base image: dist/limanix-<version>-<arch>.qcow2.
# `task release/build` runs it from the repository root in the ci/nix container.
#
# Usage: build-image.sh ARCH [VERSION]
# VERSION defaults to the flake's version; a release passes its tag without the leading v.
set -eu

arch=$1

# The checkout belongs to the host user; Nix reads it as root.
git config --global --add safe.directory "$PWD"
flags="--extra-experimental-features nix-command --extra-experimental-features flakes"
flags="$flags --option build-users-group nixbld"

version=${2:-$(nix eval $flags --raw .#version)}
name="limanix-$version-$arch"

out=$(nix build $flags --no-link --print-out-paths --print-build-logs ".#packages.$arch-linux.default")

mkdir -p dist
rm -f "dist/$name.qcow2" "dist/$name.qcow2.sha256"
cp "$out" "dist/$name.qcow2"
chmod 0644 "dist/$name.qcow2"
(cd dist && sha256sum "$name.qcow2" > "$name.qcow2.sha256")
