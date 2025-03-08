{inputs, ...}: let
  inherit (inputs.impermanence.nixosModules.home-manager) impermanence;
in {
  imports = [impermanence];

  config.home.persistence."/persist/home/purps" = {
    allowOther = true;
    directories = [
      ".config/sops"
      ".ssh"
      "Documents"
      "Pictures"
      "Videos"
      "Desktop"
    ];
  };
}
