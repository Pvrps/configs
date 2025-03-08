{pkgs, ...}: {
  time.timeZone = "Canada/Eastern";
  i18n.defaultLocale = "en_US.UTF-8";

  environment = {
    systemPackages = with pkgs; [
      git
      unzip
      zip
      unrar
    ];
  };

  home-manager = {
    useGlobalPkgs = true;
    useUserPackages = true;
  };

  services = {
    logind = {
      powerKey = "ignore";
      powerKeyLongPress = "poweroff";
    };
    udev = {
      packages = with pkgs; [vial];
    };
  };

  systemd.extraConfig = ''
    DefaultTimeoutStopSec=10s
  '';

  # allow others to mount fuse filesystems (hm-impermanence)
  programs.fuse.userAllowOther = true;

  system.stateVersion = "24.05";
}
