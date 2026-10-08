{
  description = "LimaNix base images";

  inputs = {
    modules.url = "github:limanix/modules/v3";
    nixpkgs.follows = "modules/nixpkgs";
    nixos-lima = {
      url = "github:nixos-lima/nixos-lima/v0.2.1";
      inputs.nixpkgs.follows = "nixpkgs";
    };
  };

  outputs =
    { nixpkgs, nixos-lima, ... }:
    let
      systems = [
        "aarch64-linux"
        "x86_64-linux"
      ];
      image =
        system:
        nixpkgs.lib.nixosSystem {
          modules = [
            { nixpkgs.hostPlatform = system; }
            nixos-lima.nixosModules.lima
            ./image.nix
          ];
        };
    in
    {
      version = "${nixpkgs.lib.trivial.release}.${builtins.substring 0 8 nixpkgs.lastModifiedDate}";
      nixosConfigurations = nixpkgs.lib.genAttrs systems image;
      packages = nixpkgs.lib.genAttrs systems (system: {
        default = (image system).config.system.build.qcow2;
      });
    };
}
