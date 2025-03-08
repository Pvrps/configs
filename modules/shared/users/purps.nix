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
      hashedPassword = "$6$.iGquLq4H7sMMsGO$rJG04VDgKRJUwZ8OSCqsTJlZGYVrQgfjBwaIWWQ.tJy0Fnvj4jycRLLq5o7Etg30PJjmQ.glN.PX1gdX3qMmi1";
      extraGroups = ["wheel" "audio" "video" "plugdev" "libvirtd" "networkmanager"];
    }
  ];
}
