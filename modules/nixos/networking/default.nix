{
  config,
  host,
  pkgs,
  ...
}: let
  isImpermanent = config.sysc.impermanence.enable;
in {
  networking = {
    hostName = host;
    search = [
      "local"
    ];
    networkmanager = {
      enable = true;
      plugins = with pkgs; [
        networkmanager-openconnect
        networkmanager-openvpn
      ];
    };
  };

  environment.persistence."/persist" = {
    enable = isImpermanent;
    directories = ["/etc/NetworkManager"];
  };
}
