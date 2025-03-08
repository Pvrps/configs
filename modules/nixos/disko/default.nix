{inputs, ...}: let
  inherit (inputs.disko.nixosModules) disko;
in {
  imports = [
    disko
    ./btrfs.nix
  ];
}
