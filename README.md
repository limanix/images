# LimaNix images

[![License: Apache-2.0](https://img.shields.io/github/license/limanix/images?label=license)](LICENSE)

<p align="center">
  <img src=".github/assets/readme-header.png"
       alt="LimaNix images"
       width="100%">
</p>

The base disk that LimaNix boots a new VM from: NixOS for `aarch64` and
`x86_64`, built on the Nixpkgs of a
[catalog](https://github.com/limanix/modules) release.

## Releases

```text
PR ─▶ merge into main ─▶ release v<nixos>.<date> ─▶ v<nixos> points to it
```

`<nixos>` is the NixOS release of the catalog's Nixpkgs, such as `YY.05` or
`YY.11`. `<date>` is the date of that Nixpkgs revision, `YYYYMMDD`.

- A merge that changes `flake.nix`, `flake.lock` or `image.nix` releases the
  image. Other changes release nothing.
- A second release on the same Nixpkgs adds a number: `v<nixos>.<date>.<n>`.
- Each release carries `limanix-<version>-<arch>.qcow2` and its `.sha256`.
- `v<nixos>` holds the newest image of that NixOS release, under names without a
  date: `limanix-<nixos>-<arch>.qcow2`. Each NixOS release gets its own; a new
  one leaves the previous at its last image. Its files change; pin a dated
  release.

## Update the image

| Change | What to do |
| -- | -- |
| New catalog base | In `flake.nix`, move the catalog release (`modules/vN`) and open a PR |
| New NixOS release | The same, and boot the image in Lima before the merge |
| The image itself | Edit `image.nix` |

## Build locally

Needs [Task](https://taskfile.dev) and Docker. Builds natively: `aarch64` on an
arm64 machine, `x86_64` on an x86_64 one. The image lands in `dist/`.

```console
task --yes release/build
```
