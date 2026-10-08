# LimaNix images

[![License: Apache-2.0](https://img.shields.io/github/license/limanix/images?label=license)](LICENSE)

<p align="center">
  <img src=".github/assets/readme-header.png"
       alt="LimaNix images"
       width="100%">
</p>

The base disk that LimaNix boots a new VM from: NixOS on a btrfs root with zstd
compression, for `aarch64` and `x86_64`. btrfs has no fixed inode table: a Nix
store full of small files cannot exhaust it the way it exhausts ext4.

| Part | Contents |
| -- | -- |
| Partitions | an EFI system partition (`ESP`) and a btrfs root (`nixos`) |
| Boot | systemd-boot |
| Lima | the guest integration of [nixos-lima](https://github.com/nixos-lima/nixos-lima) |
| Nixpkgs | the base revision of a [catalog](https://github.com/limanix/modules) release, which a new VM's first generation reuses |

## Build

Needs [Task](https://taskfile.dev) and Docker, and builds natively: `aarch64` on
an arm64 machine, `x86_64` on an x86_64 one. The image lands in `dist/`.

```console
task --yes release/build
```
