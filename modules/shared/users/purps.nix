{
  lib,
  pkgs,
  ...
}: let
  inherit (lib) mkIf mkMerge;
in {
  users.users.purps = mkMerge [
    {
      shell = pkgs.fish;
      isNormalUser = true;
      extraGroups = ["wheel" "audio" "video" "dialout" "plugdev" "libvirtd" "networkmanager" "docker" "wireshark"];
    }
  ];
}
