{
  self,
  lib,
  inputs,
  ...
}: let
  inherit (self) outputs;
  inherit (outputs.lib) mkStrappedSystem;
  inherit (lib) mkMerge;
  inherit (inputs.nixpkgs.lib) nixosSystem;

  mkNixOS = host: system: {
    "${host}" = mkStrappedSystem host system nixosSystem [
      ./${host}
      ./${host}/hardware.nix
    ];
  };
in {
  flake = {
    nixosConfigurations = mkMerge [
      (mkNixOS "dissension" "x86_64-linux")
    ];
  };
}
